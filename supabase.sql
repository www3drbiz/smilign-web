-- Supabase SQL Editor에서 실행하세요.
create table if not exists public.reviews (
  id         uuid primary key default gen_random_uuid(),
  author     text not null,            -- 예: 김○○ 님
  treatment  text not null,            -- 예: 임플란트 · 40대
  body       text not null,
  published  boolean not null default false,  -- 동의·검수 후 true
  created_at timestamptz not null default now()
);

alter table public.reviews enable row level security;

-- 로그인한 회원(authenticated)만 게시된 후기를 읽을 수 있습니다. 비회원(anon)에게는 정책이 없어 조회가 차단됩니다.
create policy "members can read published reviews"
  on public.reviews for select
  to authenticated
  using (published = true);

-- 쓰기 정책은 만들지 않습니다. 후기 등록은 대시보드 또는 service_role 키(서버)로만 합니다.
