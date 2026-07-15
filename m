Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F43E558E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106145; cv=none; b=HUvhTtZR465SMK87lv0giu/8TUr08Ms+87TrSGQ8+XF9dWMaaUfV+rSIxtsgMArd90CQzvNq3Zna8ynE0f9fVnH2Jaa1+fOr80gL6hgZpCe4r3xOOJ1JVJxhTfHqoHKQzpXZKbu/K6trP/ZPZ5t2sXIiJEt6wgRIRk39W2kd20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106145; c=relaxed/simple;
	bh=Ega7TF6iwrcr/GvMb+EBHY5NuOm5aF9WFkHprjfyKAc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=Yu70DNdKOn4Rr3crwz1bEZF5q4Lsjm3zOUnxnoeQgHVJskrKKFBpBNVhnTZd2Lff4mAXDz4xvGxIXQEUX9Ty98LiDXZh/Kg9QB1xI2fXvVCaUczAMoLBJNOUNvCLh83foo2ubF3Ut3hcLhd+ThodnHe5oO9gjeWH79it3LoBLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iEWpRYeE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iEWpRYeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106133;
	bh=Ega7TF6iwrcr/GvMb+EBHY5NuOm5aF9WFkHprjfyKAc=;
	h=From:To:Subject:Date:From;
	b=iEWpRYeEBBg1LmNXAjO0ToOWHFmo/r5afTJ3AklSfuI4bIVao5ivSoP+lYiluSwAr
	 W4dzRnh+e+4y7Vytm4CL2yfHta2uWIfu/8aZ58i51gdGtzb5nqew2087L79JOm+eQG
	 6WkFoPhLtPlGCdiYA4awFiEXsjpzCafpQi6Gop+Xrt/v08BuRmTe8ad8+Bw/vi5G1n
	 ekjiqThDiuVHRuVL8sS+C1+Edp6x1FwwlrC6Fb5UvIPjq5EWVKwYmgDr4ENs6dgxNA
	 VWHszwSgf965ZR+PRYeHrD4qkrH1PuXlkNb9C7mVIejoJuHqbWsuazYop5ZlXoYt6O
	 du1ubfXwDcxbA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B42CB17E0018
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/8] plugin/admin: Make allowlist adapter-scoped and enforce at runtime
Date: Wed, 15 Jul 2026 11:01:58 +0200
Message-ID: <20260715090206.212130-1-frederic.danis@collabora.com>
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
it now accepts an optional [ctrl] argument and otherwise targets the
currently selected default adapter. Documentation is updated
accordingly.

The core functional change is runtime enforcement of ServiceAllowList
for local adapter/server services in addition to existing remote-device
policy checks. When policy changes, adapters immediately reapply
allowlist decisions by stopping/removing disallowed services and
starting newly allowed ones, without restarting bluetoothd.

While exercising this runtime path, a UAF was found in audio media app
teardown when endpoint/player objects were destroyed before proxy
removal. The series fixes object/queue lifetime ownership to prevent
stale pointer dereferences.

Finally, device-side allowlist checks are switched to the same
profile-aware policy mapping used by adapter-side logic, so cases such
as A2DP role inversion are handled consistently.

Summary of effects:
- AdminPolicy state is correctly scoped per adapter.
- admin.allow can target explicit adapter or the selected default.
- ServiceAllowList now governs both remote profiles and local
  adapter/server services.
- Allowlist updates are enforced immediately on initialized adapters.
- Device and adapter policy decisions now use the same profile-aware
  UUID mapping semantics.
- Audio media teardown no longer risks UAF during runtime service
  reconfiguration.

v1->v2: Add new commit to fix outgoing connection by unifying device-side
 filtering with adapter-side profile-aware allowlist mapping semantics.

Frédéric Danis (8):
  plugins/admin: make AdminPolicy state per-adapter
  client/bluetoothctl: make admin.allow controller-aware
  doc: document admin.allow optional controller argument
  src/adapter: enforce allowlist for local services
  plugins/admin: reapply allowlist on policy updates
  doc: describe admin allowlist runtime enforcement
  profiles/audio: fix UAF on external media service teardown
  device: apply profile-aware admin allowlist checks for device services

 client/admin.c                      | 114 ++++++++++++++++++-----
 client/admin.h                      |   4 +
 client/main.c                       |  25 ++++-
 doc/bluetoothctl-admin.rst          |  13 ++-
 doc/org.bluez.AdminPolicySet.rst    |  12 +++
 doc/org.bluez.AdminPolicyStatus.rst |   5 +
 plugins/admin.c                     | 131 +++++++++++++++++++-------
 profiles/audio/media.c              |  16 ++++
 src/adapter.c                       | 139 ++++++++++++++++++++++++++++
 src/adapter.h                       |   4 +
 src/device.c                        |   5 +-
 11 files changed, 405 insertions(+), 63 deletions(-)

-- 
2.43.0

