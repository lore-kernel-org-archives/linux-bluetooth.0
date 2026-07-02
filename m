Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8023C5DB6
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990442; cv=none; b=lYPIuNJFTo0kOSNaL6iJuJmVCJXgV9YHjGEnfAKZPMwYSV1LhEoI6OuKkdR4bV0O4XiER7VhFD9wSlu5/rTBIdlfyCYRTlZJGhVdBulVfcK60OhbNkmUupPbjAVMRYcOuTjVimDFIIPdmIz47c8GkeTr4BVD9CAyxkkYuofQA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990442; c=relaxed/simple;
	bh=yFPaJIo4KO8w30F6r8CzuUaUiwQJ5osqqphdTalDtwc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HiWy5Xj4Ha1OVzZqfkjG39U9uDfLaxH+Xfqe1byfApv7jom9dTxy0Ye7a8Dj44Lo1Od7G6ACNSdyzLJ8/sVcjyOKkgZVorF0dYaAzie83nQz3dcrjuSC7aM1+yfyuaW80DpQdxIgQBdn1rLgwY9Fzfq18nJw3QMjoc2VlTjikzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OC5Q5C8C; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OC5Q5C8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782990440;
	bh=Z3z59QHME6fZztwQjamT4QzZQ22latjJtp+oDFqen9A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OC5Q5C8CMAxU/a/OV3kouUbqYxPU+APoA44g2y8zOQ2J/VqBfU4gX6LSEmEc+6q5Y
	 nrX7BZVZn2hGosXaCZVvNjXVT1RmypJPBLsXKxh/4y0AxCN3v8Gl7rArQsE/ti2sDo
	 HeRl7Le4wMdERwp8i0uhc1Rpg69Ph18qDv1ePSxQ=
Received: from github.com (hubbernetes-node-dd8d134.va3-iad.github.net [10.48.178.47])
	by smtp.github.com (Postfix) with ESMTPA id B7213808B88
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 04:07:20 -0700 (PDT)
Date: Thu, 02 Jul 2026 04:07:20 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120331/000000-f4465f@github.com>
Subject: [bluez/bluez] ef4bf7: plugins/admin: make AdminPolicy state
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

  Branch: refs/heads/1120331
  Home:   https://github.com/bluez/bluez
  Commit: ef4bf764309bef21dc71fbd658c87e03107c5aac
      https://github.com/bluez/bluez/commit/ef4bf764309bef21dc71fbd658c87=
e03107c5aac
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


  Commit: 683e390e26c8c21db486f076fad149019e111ed2
      https://github.com/bluez/bluez/commit/683e390e26c8c21db486f076fad14=
9019e111ed2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


  Commit: 8ab7554018b328deb0c8fc00b520745772834e27
      https://github.com/bluez/bluez/commit/8ab7554018b328deb0c8fc00b5207=
45772834e27
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


  Commit: be8945b213da9eb8b6646714773b364b87d430d0
      https://github.com/bluez/bluez/commit/be8945b213da9eb8b6646714773b3=
64b87d430d0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


  Commit: 49945eaf7460503e97844a7d726cd75468cc7956
      https://github.com/bluez/bluez/commit/49945eaf7460503e97844a7d726cd=
75468cc7956
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: reapply allowlist on policy updates

Invoke adapter allowlist reapply after SetServiceAllowList updates
so runtime state follows policy changes immediately.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 42edbdf1bf416a071502a3babc18defabde82b18
      https://github.com/bluez/bluez/commit/42edbdf1bf416a071502a3babc18d=
efabde82b18
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


  Commit: f4465f5c88ec013a45fda7c08a1a6fce56288441
      https://github.com/bluez/bluez/commit/f4465f5c88ec013a45fda7c08a1a6=
fce56288441
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

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


Compare: https://github.com/bluez/bluez/compare/ef4bf764309b%5E...f4465f5=
c88ec

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
