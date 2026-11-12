# 스마일라인 치과 배포 가이드 (GitHub + Vercel + Supabase)

## 1. Supabase
1. 새 프로젝트 생성 후 **SQL Editor**에서 `supabase.sql` 실행 (후기 테이블 + RLS).
2. **Authentication > Providers**: Email 켜기(이메일 인증 권장), Google 켜기.
   - Google Cloud Console에서 OAuth 클라이언트(웹) 생성 → 승인된 리디렉션 URI에 Supabase가 안내하는 callback URL 등록 → Client ID/Secret을 Supabase에 입력.
3. **Authentication > URL Configuration**: Site URL과 Redirect URLs에 Vercel 배포 주소(와 로컬 테스트 주소) 등록.
4. **Project Settings > API**의 URL과 anon key를 `config.js`에 입력.
5. 후기는 **Table Editor > reviews**에서 직접 입력하고, 환자 동의와 검수 후 `published`를 true로 바꿉니다.

## 2. GitHub
이 폴더(`index.html`, `config.js`, `supabase.sql`, `README.md`)를 저장소에 푸시합니다.

## 3. Vercel
GitHub 저장소를 Import하면 정적 사이트로 바로 배포됩니다. Framework Preset은 Other, 빌드 명령은 비워 둡니다.

## 보안 메모
- anon key는 공개되어도 되는 키입니다. 후기 보호는 RLS 정책이 담당합니다. service_role 키는 절대 코드에 넣지 마세요.
- 비회원이 후기를 볼 수 없는지 배포 후 시크릿 창에서 직접 확인하세요.
