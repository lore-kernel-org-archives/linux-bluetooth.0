Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE758FD10
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067970; cv=none; b=kpiQFqO9WLsXUJlOQzYjKZ2OGKFrFpdZX6e2BWLP7OuEC4Abr0Q1rBlXrGwcLFMQ73X1bLHKKb9MYoiIscKsr2T+uuLmRWyJbAMYK4xd8ZUoAP+D8r5I6pxY+zHClWbhqbjmdvuJL7kTRP9cTwpqy7esJubStNMsFaRoYZvIMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067970; c=relaxed/simple;
	bh=vYuadRF0dpSqUJwJ83yCy0NkqcGeftVG+lFtP5r9ux8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CXeX5mPcMV1AdmmCnyuuIqJajdxU1KR1OLFX7DIZA1Zb9XqPOl0FsqoSARrxp0RkhTJc9tNdpLBjTT798b3+RnPq3WU3/VUfPW8lgIxAtMzafpDOM63D9SMT1cS9XAwpQf1FUg35gFoz2iKcZ74IJlnPMoLdiZO0JNEqbkZpDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g6oTNe0w; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g6oTNe0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789067965;
	bh=7VNklaflaKRiKjSl6i5jG4BMdDViwvtw2pnGK0dc1UQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g6oTNe0wSHTWj2hUXLfjrGhfqzu26XJBLk/+SQEXLRjaVseFd2Rzm1p1WreXCqik2
	 /gj977Dak2LL0YzHsUeM+qaypODLtjMWV4Z58G0RJkurTbI2MofPnCv+dzamCdAodW
	 8C3mCmK+E8OzXl4KKcQlIQLAujpkDMjDSA10wc5U=
Received: from github.com (hubbernetes-node-e4b5015.va3-iad.github.net [10.48.72.98])
	by smtp.github.com (Postfix) with ESMTPA id 2C98A501353
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:19:25 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:19:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1162311/000000-9ddfe4@github.com>
Subject: [bluez/bluez] 6df617: gatt-server: Check prepare write length before
 rea...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1162311
  Home:   https://github.com/bluez/bluez
  Commit: 6df6172376328d933971ea97888ac49a3207b205
      https://github.com/bluez/bluez/commit/6df6172376328d933971ea97888ac49a3207b205
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Check prepare write length before reallocating

append_prep_data() grew the buffer and copied the new fragment into it
before rejecting a total length above UINT16_MAX. On overflow the
allocation had already been enlarged and written while prep_data->length
was left at its previous value, desynchronising the buffer from its
tracked size.

Move the bound check ahead of the realloc() so an oversized prepare
write queue is rejected without touching the buffer.

Assisted-by: opencode:claude-opus-5


  Commit: 7c30470f5f5ade0156edfc1093b2a938c9367efc
      https://github.com/bluez/bluez/commit/7c30470f5f5ade0156edfc1093b2a938c9367efc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  adapter: Unify the A2DP admin allowlist UUID mapping

The allowlist enforcement added across the adapter, device and A2DP
layers ended up using three different UUIDs for the same two profiles:
adapter.c mapped both a2dp-source and a2dp-sink to ADVANCED_AUDIO_UUID
(0x110d), while device.c and a2dp.c mapped them to the local role UUIDs
0x110a and 0x110b. An allowlist containing only 0x110a therefore blocked
the a2dp-sink adapter probe outright, so the finer grained SEP checks in
a2dp.c never ran.

Add btd_profile_get_policy_uuid() as the single place resolving a
profile to the UUID of the local service it provides. btd_profile names
and remote_uuid describe the remote role, so the A2DP profiles are
inverted there: "a2dp-source" registers the local Sink server and
"a2dp-sink" registers the local Source server. This matches what
device.c and a2dp.c already do.

Note that allowlisting 0x110d alone no longer enables A2DP; the local
role UUIDs 0x110a and/or 0x110b have to be listed.

This also drops the hardcoded profile name table in adapter.c. Every
entry but the two A2DP ones just returned profile->remote_uuid, and any
profile without a local_uuid that was missing from the table resolved to
NULL, i.e. was allowed unconditionally regardless of the allowlist.

Assisted-by: opencode:claude-opus-5


  Commit: f92e323272d0df5870d9fbec86e6ce0d25f76dc9
      https://github.com/bluez/bluez/commit/f92e323272d0df5870d9fbec86e6ce0d25f76dc9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/battery.c
    M src/battery.h

  Log Message:
  -----------
  battery: Document the unknown sentinels and fix a stale name

btd_battery_update() treats UINT8_MAX and btd_battery_update_charging()
treats -1 as "unknown", invalidating the D-Bus property rather than
setting it. Neither was documented at the prototypes.

Also rename unregister_if_path_has_prefix() to
unregister_if_provider_matches(); it no longer compares path prefixes,
it compares the owning provider.

Assisted-by: opencode:claude-opus-5


  Commit: 9ddfe4d82a4fc4354f02ac6dcd578eb9016a1158
      https://github.com/bluez/bluez/commit/9ddfe4d82a4fc4354f02ac6dcd578eb9016a1158
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/admin.c
    M client/admin.h
    M client/main.c
    A client/main.h

  Log Message:
  -----------
  client/bluetoothctl: Declare the controller helper in its own header

bluetoothctl_get_default_controller() is implemented in main.c but was
declared in admin.h, the header of one of the submenus that consumes it.
Move the declaration to a new client/main.h so main.c also sees it.

While at it, drop the bluetooth/bluetooth.h include added to admin.c,
which is unused.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/6df617237632%5E...9ddfe4d82a4f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
