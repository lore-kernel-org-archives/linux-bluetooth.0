Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A604D8D82
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138426; cv=none; b=oxHmf+4ZdUqCxAGIC3BRzwkYpkncXzOUMGeVdrot54v60ZRD4y6LVbbDtp9XmVoz/rbZalZoSBCKo1m1lXeb+Vzwh2WOSo99DpCGvWOWkzNTHH1bACO9nRLfboDcHHuDIV1lXm0s/38XfIhbXKoNCGqBypT3d3LYW6miA/WCw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138426; c=relaxed/simple;
	bh=FyKLJ1TWNfcFYgNj/5ALK4TaWwvPuMiUdnId5rpgj2Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W8UY4rn412i6yg9d2nXfF8wH2AaCnZeV+rFkHAbUHb+uaWfkId5TuX7Ne4/mTRmY5p0nqK9ld0oClBxrG1p3RCJuni2EBqpcIh/fM9PmBhWcQYv3DTrr1oY7dlS2iT3+qq4a/87zL72v3vrtBaau6tGGkMNPHuhEgWwHH2423Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CgkpEYcO; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CgkpEYcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784138420;
	bh=pBoiVTXX14fvdSsaFNSjrp7Gl5M4eE82v/C+Sg76dXY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CgkpEYcO9jzLlEFoFTD948gdVk5WfDwOIAESmEqQIwkAyKC+qTC5m5VYI4zFmq849
	 +vg74OfEjaiFxUelL8avM8ptwuApaF+gk9nXZW9F4p12rNDYRqYt1lyg56e5aqt28y
	 xwxv5GF481b5FaQ/lU3vEDzfZPBcEABJEHhCL/Ag=
Received: from github.com (hubbernetes-node-1358d6f.ac4-iad.github.net [10.52.168.35])
	by smtp.github.com (Postfix) with ESMTPA id BC7E47411EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:00:20 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:00:20 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1309d5-30db66@github.com>
Subject: [bluez/bluez] 7482ac: profiles/audio: fix UAF on external media
 service ...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7482aceece7044e688f20f113263b50c21d69fb6
      https://github.com/bluez/bluez/commit/7482aceece7044e688f20f113263b=
50c21d69fb6
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


  Commit: b0abe23f58f1ecc44d9d0b6b328be72d2d2113b8
      https://github.com/bluez/bluez/commit/b0abe23f58f1ecc44d9d0b6b328be=
72d2d2113b8
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: 30db66dc971bd1cd95d4a7b0eea296367ab65b3b
      https://github.com/bluez/bluez/commit/30db66dc971bd1cd95d4a7b0eea29=
6367ab65b3b
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M Makefile.tools
    A doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples


Compare: https://github.com/bluez/bluez/compare/1309d5f9305d...30db66dc97=
1b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
