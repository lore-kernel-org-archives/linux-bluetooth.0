Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3382DBF4B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647842; cv=none; b=a5wV7LNvLovrWu3l/oyGK+PHMnTkvRdC/HJdlymmwdp2WhLCUtL8/bXZ38QY+0+ZpK/2/xiLRUxnQgirtLFTjI/ODIVYuIFJXPAHKpYEQ8piU2CN4xKA8QY5GILq+lfTgmBvyG5N8fu+JyN0MpGMdULoO3NZtX9xyFxUu4eWNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647842; c=relaxed/simple;
	bh=YeBW0NGqO7N1FZrjCNLElMJLQmHkaxWSnGGb+26xoow=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lIGIhHnmn3O3w488aXFXqM75LWpY8cIxeFhG1X/OBYFbEI0HsO9SyZjAGkGIAgFyIwS5BNAt3PXcwcMcVJuJ5Hw58aMssNesKq6lEU8TuCYVVQ+nUuquOysguv1V4HPNQrQ63Mip2347ADRKBF8HwXHJtyJcziibWUZ/HJabboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kdhWjm8D; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kdhWjm8D"
Received: from github.com (hubbernetes-node-ed34f81.ac4-iad.github.net [10.52.81.28])
	by smtp.github.com (Postfix) with ESMTPA id 06F0D401093
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767647840;
	bh=NwazwscSbEcRhYp72W8t8+BZZDk2gQyp9HNHkaB/448=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kdhWjm8DxzufcdqTItnxbXbh5t0pKXlTPAP93NKtcDGFN/lPJuB4fEZGDwsVSH77d
	 +zyVflfVAs76glp+Y5qbnns+AL5aqPugM/n25o742s7R5Stq15f2FKo4qHmMsKz3Ce
	 6vB74wrXOGzsttWHgTNcI9pa0UZZBaQv/tntbEwI=
Date: Mon, 05 Jan 2026 13:17:20 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038698/000000-246e27@github.com>
Subject: [bluez/bluez] dcf8b8: transport: clean up volume set/get for A2DP and
 VCP
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

  Branch: refs/heads/1038698
  Home:   https://github.com/bluez/bluez
  Commit: dcf8b8eb4d9c28c8c40425503d2885e27f674073
      https://github.com/bluez/bluez/commit/dcf8b8eb4d9c28c8c40425503d2885e27f674073
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c
    M profiles/audio/transport.h
    M profiles/audio/vcp.c
    M profiles/audio/vcp.h

  Log Message:
  -----------
  transport: clean up volume set/get for A2DP and VCP

Cleanup uuid comparisons in device transport volume set/get. These are
unnecessary because the transport->ops already do the equivalent check.

Use separate functions for set/get AVRCP volume, to avoid mixing up
AVRCP and VCP volumes.

For VCP send volume update notifications on all transports, since same
volume is listed on all.

To avoid interspersing #ifdefs for A2DP/VCP in this code, define dummy
functions in headers that behave accordingly.

Fix the bt_audio_vcp_get/set_volume to properly indicate when VCP is not
present.


  Commit: 246e2747d7ccc05945269ae267299377f9227124
      https://github.com/bluez/bluez/commit/246e2747d7ccc05945269ae267299377f9227124
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: distinguish BAP mic and playback volumes

BAP Unicast has two kinds of relevant volumes: playback and microphone.
Client Sink and Server Source generally correspond to microphone volume.
Broadcast Source and Sink do not have microphone volume.  Microphone
volumes shall use MICP, not VCP, but currently we confuse them.

Fix by distinguishing the VCP / MICP cases. The shared/micp
implementation is incomplete, so leave those volumes unimplemented also
in transport.

This fixes setting volume on microphone transport changing the playback
volume.


Compare: https://github.com/bluez/bluez/compare/dcf8b8eb4d9c%5E...246e2747d7cc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
