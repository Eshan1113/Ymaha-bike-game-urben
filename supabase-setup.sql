-- ============================================================
--  URBAN MEMORY RUSH – Supabase setup (run ONCE)
--  Paste this whole file into: Supabase Dashboard → SQL Editor → New query → Run
-- ============================================================

create table if not exists public.urban_players (
  id            uuid primary key default gen_random_uuid(),
  name          text        not null,
  phone         text        not null,
  score         integer     not null default 0,
  level_reached integer     not null default 1,
  created_at    timestamptz not null default now()
);

-- Kiosk uses the publishable (anon) key, so allow what the game needs:
alter table public.urban_players enable row level security;

drop policy if exists "kiosk can insert" on public.urban_players;
create policy "kiosk can insert" on public.urban_players
  for insert to anon with check (true);

drop policy if exists "kiosk can select" on public.urban_players;
create policy "kiosk can select" on public.urban_players
  for select to anon using (true);

drop policy if exists "kiosk can update" on public.urban_players;
create policy "kiosk can update" on public.urban_players
  for update to anon using (true) with check (true);
