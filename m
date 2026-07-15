Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260342F717
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107888; cv=none; b=WZGwUuE4Nvj5AdWXA7/EgdaGfoRPCW65M2s8Eu5zpREk1YotbV2pupDAu/v17E6iyhOxHBToqilnl89kBw9Q4DVvomI/fuQxoDPTPZskh+njrzf+197n41ACqGdpFpcb32bTEoQcyrAJ39aMf4KMiq1x8lYeoI5Z2wD5UB4JTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107888; c=relaxed/simple;
	bh=ZXlNv1kLbHUCKbCzGvoPukbPSGO5p14ta53KGyi0MfE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q4mR6sN4cVOg2+/u0tzyX/OiNi2InwkUenSldT1IyF6tMgAwx7y7upG+tthWgUDNfPDjJHrK8jdXKEmz9sBDjixmcbNTEyxhYVCeXIHR2POqUF5dc3JkI+ogcOL0li6LVetWr7LZ0R7y9WSTuiAW1tuVLBN5/2tpg+I+V4uoCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V75DFg/q; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V75DFg/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784107883;
	bh=g6XG9YwpK2kpLwtOdOyXrBYsiw1LhDdw9YzCj+ZYh/M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V75DFg/q1aobriQ/mT7FmbZxAyRaWo90YyLCkZmpxPdPA8A485e9uU+OYd8cZeBgE
	 wpcAalyWmdwSEcN+eD4RfA3FdZ/OsHgf/5FQbFwjvwpT8Fz+yNrUfhX/0Z+BYVwteF
	 nQuSab4u8umDwN0/wDJqdGHKC7E+wii+1T3Oso5A=
Received: from github.com (hubbernetes-node-eb39159.va3-iad.github.net [10.48.70.50])
	by smtp.github.com (Postfix) with ESMTPA id 19945800FDF
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 02:31:23 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:31:23 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128023/000000-22fc7f@github.com>
Subject: [bluez/bluez] 3a16a8: plugins/admin: make AdminPolicy state
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

  Branch: refs/heads/1128023
  Home:   https://github.com/bluez/bluez
  Commit: 3a16a8bfa0eb58b909f012dcfa44597d950b0cb5
      https://github.com/bluez/bluez/commit/3a16a8bfa0eb58b909f012dcfa445=
97d950b0cb5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

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


  Commit: 97cc14fb77695faa5a3306d4e62b3bb63772afcf
      https://github.com/bluez/bluez/commit/97cc14fb77695faa5a3306d4e62b3=
bb63772afcf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client/bluetoothctl: make admin.allow controller-aware

Teach admin.allow to target the selected default controller when no
controller is provided, and to accept an explicit [ctrl] argument.

Replace single cached AdminPolicy proxies with per-controller proxy
lookup keyed by controller object path, so controller selection changes
are respected.

Export controller lookup/default helpers and shared controller
completion from main.c for reuse by admin.c.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: e603f521f002ecb79e4663e9e478493dfaf20c31
      https://github.com/bluez/bluez/commit/e603f521f002ecb79e4663e9e4784=
93dfaf20c31
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M doc/bluetoothctl-admin.rst
    M doc/org.bluez.AdminPolicySet.rst

  Log Message:
  -----------
  doc: document admin.allow optional controller argument

Update bluetoothctl usage to 'admin.allow [ctrl] [clear/uuid1 uuid2 ...]'=

and add explicit controller examples.

Refresh AdminPolicySet examples to include the controller-qualified
admin.allow form.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 33aa9c2206a1f914d197f98ec3920deaad9e16ea
      https://github.com/bluez/bluez/commit/33aa9c2206a1f914d197f98ec3920=
deaad9e16ea
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

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

Assisted-by: GPT:GPT-5.3-Codex


  Commit: eb73f345e6586b40f15af64fea6659e06a167344
      https://github.com/bluez/bluez/commit/eb73f345e6586b40f15af64fea665=
9e06a167344
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: reapply allowlist on policy updates

Invoke adapter allowlist reapply after SetServiceAllowList updates
so runtime state follows policy changes immediately.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 8be82ab04298c95cd0f2249bfbe98f70a061e4de
      https://github.com/bluez/bluez/commit/8be82ab04298c95cd0f2249bfbe98=
f70a061e4de
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

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


  Commit: 2e9c479f65fbbf27f72d34871223cfdafae4f5e2
      https://github.com/bluez/bluez/commit/2e9c479f65fbbf27f72d34871223c=
fdafae4f5e2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  profiles/audio: fix UAF on external media service teardown

Keep media_app endpoint/player queues in sync with object lifetime to
avoid stale pointers during proxy removal.

When admin allowlist reapply removes audio services, endpoint/player
objects may be destroyed through non-proxy paths first.
Later proxy_removed_cb calls queue_remove_if() and matching by path
can dereference freed endpoint/player memory.

Fix by:
- adding media_app back-references in media_endpoint/local_player
- unlinking from app queues inside media_endpoint_remove or
  local_player_remove
- setting ownership when app-registering endpoint/player objects

This prevents heap-use-after-free in match_endpoint_by_path or
match_player_by_path during service disconnect.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 22fc7f30bb5ddfb754025ef73ed4fa6a9c96de1d
      https://github.com/bluez/bluez/commit/22fc7f30bb5ddfb754025ef73ed4f=
a6a9c96de1d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c

  Log Message:
  -----------
  device: apply profile-aware admin allowlist checks for device services

Use adapter profile-aware policy mapping when evaluating device service
allowance, so device-side filtering matches adapter-side allowlist
semantics.

This updates device policy checks to call
btd_adapter_is_profile_allowed() instead of directly matching
profile->remote_uuid. It fixes A2DP role-inverted cases where allowing
source UUID policy should still permit connecting to the corresponding
remote sink profile.

Changes:
- Export profile-aware allowlist helper in adapter policy API
- Reuse that helper in device service allowance evaluation and refresh
  paths

Behavioral effect:
- admin allowlist decisions remain strict, but now consistent across
  adapter profile probing and device connection filtering.

Assisted-by: GPT:GPT-5.3-Codex


Compare: https://github.com/bluez/bluez/compare/3a16a8bfa0eb%5E...22fc7f3=
0bb5d

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
