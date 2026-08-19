Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E43A1A22
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150637; cv=none; b=O5NMj1vBqnx6XTyNLc3643fOE7qZY8HuQ5WAGD7h9kG3nQr+CcSqhN0If/3UaPCfdItVy3u2Hhpyfp+dCFVYr0n2oNjLOz7mLFMy9jLkUBvRX7MwYRvYzrneWkkeqSPg3KTiv7/Ge4vKmgtwJK6g32CfUtv3R09ArzGN7Nv6Rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150637; c=relaxed/simple;
	bh=TeVzQPa/4I82AwoEVD6JD7/B71aAzIGFjCdlog52kKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=PS13a6XNcgO++HtLA9rfj0vqqwUq1t2t05u8PkyFXU/s8EWHXGiTvrgYKya3V8DMvc3MXdSAGvKs8efvMdLQhWQwimyiCMiN8f0AGrObIs13l3n304leyyYPVdkeLNI7bozvLWQe2sX8x8efgmTwVJI4fMH/W2e9vFh85W8eyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JrRaXNiA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JrRaXNiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150627;
	bh=TeVzQPa/4I82AwoEVD6JD7/B71aAzIGFjCdlog52kKo=;
	h=From:To:Subject:Date:From;
	b=JrRaXNiAbhDFtGszdjF8XeQR0abCLqwDlCA/ZX4YiAwB/fDz1XYUTsjCJ+/igzPcs
	 rCLr0MUiSOTMz1ngonP6S5a0qV/Bm75MoygXJkqr6bcjp3MbHxK/9XI3nMVjCGqJV1
	 ge2XjR/Ujh60YuEv+LMMyFzewLHVg4B9sHiRx1Y9qy6c4zbbpHY0XnjKLlyr8QcMS6
	 cHhCYFZ7PBbsWqZEA0ElYEJNrDztHCB8W6/CH0bKrAEG7lZUH/BQqHYJnSxc58iiZZ
	 FmEZ30+dSQ8qNQtQm3dlQSvJXVLaA18g+NugN1lPklrCKauPxqjaZBtnlZaBb/+X1o
	 rdXIYyYQ8S4Qw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 29FCC17E0566
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/7] plugin/admin: Make allowlist adapter-scoped and enforce at runtime
Date: Wed, 19 Aug 2026 16:43:30 +0200
Message-ID: <20260819144337.889893-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series tightens AdminPolicy ServiceAllowList handling and makes
its behavior consistent across adapter selection, adapter profile
activation, local SDP service registration, and device service
allowance checks.

The first part removes global AdminPolicy state and makes policy
tracking per-adapter, which fixes D-Bus updates being emitted on the
wrong adapter and avoids cross-adapter coupling.

The second part updates bluetoothctl admin.allow to be adapter-aware:
it now targets the currently selected default adapter instead of a
single global proxy.

The core functional change is runtime enforcement of ServiceAllowList
for local adapter/server services in addition to existing remote-device
policy checks. When policy changes, adapters immediately reapply
allowlist decisions by stopping/removing disallowed services and
starting newly allowed ones, without restarting bluetoothd.

Finally, device-side and A2DP allowlist checks are made role-aware, so
that local Sink/Source role UUIDs are used consistently across
adapter profile probing, device connection filtering, and A2DP SEP
negotiation, fixing role-inverted cases and blocking disallowed roles
earlier (at Get_Capability/Set_Configuration time) instead of relying
on later teardown paths.

Summary of effects:
- AdminPolicy state is correctly scoped per adapter.
- admin.allow targets the currently selected default adapter.
- ServiceAllowList now governs both remote profiles and local
  adapter/server services.
- Allowlist updates are enforced immediately on initialized adapters.
- Device, adapter, and A2DP policy decisions consistently use
  role-aware UUID mapping semantics.
- Blocked A2DP roles are rejected at SEP negotiation time, avoiding
  stale role state and reconnect instability across policy updates.

v1->v2: Add new commit to fix outgoing connection by unifying device-side
 filtering with adapter-side profile-aware allowlist mapping semantics.

v2->v3:
- Drop the "profiles/audio: fix UAF on external media service
  teardown" commit, since it has already been merged upstream
  separately and is no longer part of this series.
- Drop the optional [ctrl] argument from bluetoothctl's admin.allow;
  it now always targets the currently selected default adapter, which
  also removed the need for the separate doc patch documenting that
  argument.
- src/adapter: map both a2dp-source and a2dp-sink profile probing to
  ADVANCED_AUDIO_UUID (0x110d) instead of swapped Sink/Source UUIDs,
  so profile probe gating matches the A2DP profile class while local
  Source/Sink SDP records still get filtered by their own UUIDs.
- device: rework device-side service allowance to use a dedicated
  role-aware helper (service_policy_uuid()) mapping a2dp-sink to the
  A2DP Source UUID and a2dp-source to the A2DP Sink UUID, instead of
  the shared btd_adapter_is_profile_allowed() helper, fixing a false
  block seen during host-initiated A2DP connect attempts.
- Add a new commit making A2DP allowlist enforcement itself role-safe:
  policy is now checked at Get_Capability/Set_Configuration
  negotiation time (rejecting blocked roles early), a2dp.c server
  role bookkeeping was hardened (explicit source_enabled/sink_enabled
  flags, cleared source/sink list heads) to avoid stale role state
  across dynamic reapply, and media.c now treats endpoints skipped by
  admin allowlist as non-fatal instead of logging an error.

Frédéric Danis (7):
  plugins/admin: make AdminPolicy state per-adapter
  client/bluetoothctl: make admin.allow controller-aware
  src/adapter: enforce allowlist for local services
  plugins/admin: reapply allowlist on policy updates
  doc: describe admin allowlist runtime enforcement
  device: unify admin allowlist checks for device services
  profiles/audio: make A2DP admin allowlist enforcement role-safe

 client/admin.c                      |  74 +++++++++++----
 client/admin.h                      |   2 +
 client/main.c                       |   8 ++
 doc/org.bluez.AdminPolicySet.rst    |  11 +++
 doc/org.bluez.AdminPolicyStatus.rst |   5 +
 plugins/admin.c                     | 131 ++++++++++++++++++++------
 profiles/audio/a2dp.c               |  38 +++++++-
 profiles/audio/media.c              |   7 ++
 src/adapter.c                       | 141 ++++++++++++++++++++++++++++
 src/adapter.h                       |   4 +
 src/device.c                        |  35 ++++++-
 11 files changed, 398 insertions(+), 58 deletions(-)

-- 
2.43.0

