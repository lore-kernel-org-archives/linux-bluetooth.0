Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FD477E51
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151358; cv=none; b=MuUFJuW5xTlaRqpQVFt1KCiidsO33YWpOSG7l9evIQi5N4dyuRbwaHiT8zWOs/AR5ydEmgeyd9Po6jNgUR7p1lTdLpMFg8BGXRDwhBKOgzpv+UbkvzT42A9+ExZS7lCdR9wrKxYWQ7nF0P7GYTMhwxL2/BN4v9osxPr6xWP9g+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151358; c=relaxed/simple;
	bh=cZMxYbFTeOMSstAiPD2Yy6Nkd2w+rkX+kPzZfRuX0IU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AHtWsd+mMLp0SdTdOpXUJL8B9wrjgisJhScuMzsgDOFEzNKITCwXkkvA1nGEw+KSYNiA7RRbQEjGKzVspwsgW4C1PfEx6eoY+uxQyENzF5JsnQ5ui5k3+4I4PIzTIpTsLyn49kp1NbnEA0IfjfaSCWkbkiw8QOcUnaP1ZeeiUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EtRCb6cT; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EtRCb6cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787151353;
	bh=UyaCT369q5ajQ720oqpMLQUGC5pTFI3tKCmnceft7a4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EtRCb6cTU/JPNZyGcshZZ+7EDDomY3GZiZgdyN7tlKyjWguTxkkg+4CidDmkLsdpI
	 uI+Ztx3KIvmwS1hve6viTBi1fItXOwvmUFXeFhBxiotPJ3TtL3GDgh4bmlDQlwvtY9
	 7VvhiiGXC0947x6zejD+S8OOxtme+2tLUGeLkMew=
Received: from github.com (hubbernetes-node-17aed48.va3-iad.github.net [10.48.176.31])
	by smtp.github.com (Postfix) with ESMTPA id 44EA4280C81
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 07:55:53 -0700 (PDT)
Date: Wed, 19 Aug 2026 07:55:53 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148530/000000-aa500e@github.com>
Subject: [bluez/bluez] 5a5937: plugins/admin: make AdminPolicy state
 per-adapter
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1148530
  Home:   https://github.com/bluez/bluez
  Commit: 5a5937c3163a69b13676cdc5f046265ecb1f36ec
      https://github.com/bluez/bluez/commit/5a5937c3163a69b13676cdc5f0462=
65ecb1f36ec
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: make AdminPolicy state per-adapter

Fix AdminPolicy D-Bus updates being emitted on the wrong adapter path
by removing the single global policy context and moving to per-adapter
policy objects.

Changes include:
- track policy contexts in a policy queue keyed by adapter pointer
- keep per-adapter device lists inside each policy context
- emit ServiceAllowList changes using the callback's adapter context
- scope device affected updates to the current adapter only
- clean up probe/remove lifecycle so adapters are registered and torn
  down independently
- remove remaining global policy_data/devices coupling

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 577bbc3243a43b0907bfb3ac5e44179eac6af801
      https://github.com/bluez/bluez/commit/577bbc3243a43b0907bfb3ac5e441=
79eac6af801
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client/bluetoothctl: make admin.allow controller-aware

Teach admin.allow to target the selected default controller.

Replace single cached AdminPolicy proxies with per-controller proxy
lookup keyed by controller object path, so controller selection changes
are respected.

Export controller default helpers from main.c for reuse by admin.c.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 3bcb18efc9a33009f097badcd6fc86c08aed6345
      https://github.com/bluez/bluez/commit/3bcb18efc9a33009f097badcd6fc8=
6c08aed6345
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  src/adapter: enforce allowlist for local services

Apply admin allowlist to adapter/server service startup and
registration, and reapply policy dynamically when allowlist changes.

- Gate adapter profile probe by allowlist-derived UUID policy
- Reapply active adapter profiles on allowlist updates (stop
  disallowed, start newly allowed)
- Block SDP service registration when UUID is not allowed
- Reapply existing local SDP registrations at runtime by removing
  services that become disallowed
- Map both a2dp-source and a2dp-sink admin policy checks to
  ADVANCED_AUDIO_UUID (0x110d). This keeps A2DP profile infrastructure
  enabled when the A2DP class UUID is allowed, while specific local
  Audio Source/Sink records remain filtered by their own UUID allowlist
  checks

Assisted-by: GPT:GPT-5.3-Codex


  Commit: fd8828eb8fd4ff4394b92e354ebe4be1edbe4746
      https://github.com/bluez/bluez/commit/fd8828eb8fd4ff4394b92e354ebe4=
be1edbe4746
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: reapply allowlist on policy updates

Invoke adapter allowlist reapply after SetServiceAllowList updates
so runtime state follows policy changes immediately.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 7f32f9c43ad7c4134a0080063daf3ff44722c5e1
      https://github.com/bluez/bluez/commit/7f32f9c43ad7c4134a0080063daf3=
ff44722c5e1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicySet.rst
    M doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc: describe admin allowlist runtime enforcement

Document that ServiceAllowList now also governs local adapter/server
startup and registration, and that allowlist updates are applied
immediately on initialized adapters.

Clarify ServiceAllowList status semantics for both remote profile
connection policy and local server policy.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: dc9aeb2dffc246a22a364ba8129cbe5e8b941531
      https://github.com/bluez/bluez/commit/dc9aeb2dffc246a22a364ba8129cb=
e5e8b941531
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c

  Log Message:
  -----------
  device: unify admin allowlist checks for device services

Consolidate device-side admin policy handling into one coherent model so
incoming and outgoing A2DP behavior follows the configured allowlist
consistently.

Why:
- The initial profile-aware adapter mapping fixed role-inverted A2DP case=
s
  for some paths, but device-side service gating still used mixed criteri=
a.
- Host-initiated Connect() could evaluate A2DP services with the wrong UU=
ID
  perspective, leading to valid flows being blocked (or blocked flows bei=
ng
  considered valid) under partial allowlists.

What changed:
- Use direct UUID allowlist checks for device service eligibility updates=
.
- Add A2DP role-aware mapping for device policy UUID selection:
  - a2dp-sink -> A2DP Source UUID (110a)
  - a2dp-source -> A2DP Sink UUID (110b)
- Apply the same policy UUID resolution in:
  - btd_device_all_services_allowed()
  - btd_device_update_allowed_services()

Result:
- Device-service policy decisions now align with intended local A2DP role=

  semantics for both remote-initiated and host-initiated connection paths=
.
- Admin allowlist enforcement remains strict while eliminating the observ=
ed
  false block during host->remote A2DP connect attempts.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: aa500e191647572383cdd8f15372cbbf531cbe66
      https://github.com/bluez/bluez/commit/aa500e191647572383cdd8f15372c=
bbf531cbe66
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/media.c

  Log Message:
  -----------
  profiles/audio: make A2DP admin allowlist enforcement role-safe

Unify audio-side allowlist enforcement so A2DP behavior remains correct
across dynamic policy updates, reconnects, and role-specific endpoint
negotiation.

Why:
- Dynamic allowlist reapply could leave stale A2DP role state and danglin=
g
  role lists, leading to invalid reuse and instability during subsequent
  signaling/SEP handling.
- Policy enforcement happening late (at SetConfiguration time) allowed
  blocked roles to remain visible during capability negotiation, which ca=
used
  retry/disconnect behavior until session managers were restarted.

What changed:
- Harden A2DP server role removal bookkeeping:
  - clear source_enabled/sink_enabled flags on remove
  - clear server->sources/server->sinks list heads after free
  - unregister shared server only when both roles are disabled
- Enforce admin policy at SEP negotiation boundaries:
  - add role-aware helper mapping local SEP type to policy UUID
  - reject blocked roles in Get_Capability path
  - reject blocked roles early in Set_Configuration path
- Keep endpoint registration resilient when partial allowlists block spec=
ific
  A2DP records, so allowed endpoints continue to register.

Result:
- A2DP policy decisions are consistent with local role semantics.
- Blocked roles are filtered earlier and more predictably.
- Runtime policy transitions are stable, without requiring daemon/session=

  manager restarts to recover expected reconnect behavior.

Assisted-by: GPT:GPT-5.3-Codex


Compare: https://github.com/bluez/bluez/compare/5a5937c3163a%5E...aa500e1=
91647

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
