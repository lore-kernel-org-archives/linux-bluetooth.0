Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F719F11B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546944; cv=none; b=AV9Hm6akb+iEQk8rb1FHH7SA6IQnnDry3sAQbUXZIRwEGI4TSEfiNu2V5gJsy1qooQEL1F6OfvZ0zj5w6/KSXuNgGJY+KbJ+FqBkgzmVjmw8tjW27tIfkVl6RnqhjfgrDQ55E1CgLmTlbGF5f8lBF+ThkS6tWNc3d/bCLKIqieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546944; c=relaxed/simple;
	bh=mMtgPsEVQRv9zyyCA+LgPIw31NIb/ec3IqMD0bQx3yQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lJ/vSStl/N2HR/RsHvoRgFrFMaOrqVB3EIzGc2SsAD6FJBcNzoV4i9D6+D3oocU/oLZRRydNQGXHrVm9P4lulTlb6TSok97SEwwx07OqJ/gVrIjYreX0l05VtrPU+qG8hyE8ce7QgsaTDk6RH6+0Tf7+8QzM8cuECLmyWHVLhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EozaK/o7; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EozaK/o7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781546942;
	bh=sUsJFRIPtwhLW43weMa1mivBIx7N5hDp5cC5YF2qz50=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EozaK/o7YFIV5zntwR8B7F5uBarvmKwlOjiTpIbabcFLJ22mBv6yVaw4kNPb9b2f6
	 65UtLO9uCRjlDZPGljeKh98f1wG+RHVMexPIHOuz3Tg+ESP0LWhnBD+JL112hZdgxG
	 Y71+bYSCk6ZDBZMuhnezfz7NYXRP9QRgxnqJULdc=
Received: from github.com (hubbernetes-node-d206f49.va3-iad.github.net [10.48.15.56])
	by smtp.github.com (Postfix) with ESMTPA id 7D39C280151
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 11:09:02 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:09:02 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/40f2e3-9c36e4@github.com>
Subject: [bluez/bluez] 237d4d: shared/bap: Transition ASE to QoS Configured on
 CI...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 237d4d5d20a556ea11f6cf5d0013884a0a70962e
      https://github.com/bluez/bluez/commit/237d4d5d20a556ea11f6cf5d0013884a0a70962e
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Transition ASE to QoS Configured on CIS loss

stream_io_disconnected() only handled the Releasing state, leaving
Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
unexpectedly.

The ASE shall autonomously move to QoS Configured on loss of the
CIS and notify the peer

Fixes PTS test BAP/USR/SCC/BV-167-C


  Commit: 986e220b77ea7803af0279200db7b011667302d7
      https://github.com/bluez/bluez/commit/986e220b77ea7803af0279200db7b011667302d7
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit/bap: Add CIS loss test

Verify a Source ASE in the Enabling state transitions to QoS Configured
rather than Disabling when its CIS is lost.

Assisted-by: ClaudeCode:claude-opus-4.8


  Commit: bd9eac15a27ac2eb14f9b2f69d046088d687bfa3
      https://github.com/bluez/bluez/commit/bd9eac15a27ac2eb14f9b2f69d046088d687bfa3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: use custom DBus timeouts only when remote side is waiting

Under high system load (VM instance on boot) it's observed the 3 sec
timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
Wireplumber, as these are set up immediately on startup together with
any other setup (eg ALSA) that may need time.

There's no actual need for using a short custom timeout in BlueZ for
this, as in this case there is no remote side that is waiting for a reply.

Fix by limiting custom timeouts to cases where there is a waiting
remote, and use separate defines for A2DP and BAP.


  Commit: 9c36e4189e32f4b8ab1376749dda4b97e71af9af
      https://github.com/bluez/bluez/commit/9c36e4189e32f4b8ab1376749dda4b97e71af9af
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Prefer notifications over indications

When both notifications and indications are enabled (CCC value=0x0003)
we will send notifications by default.


Compare: https://github.com/bluez/bluez/compare/40f2e34b3739...9c36e4189e32

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
