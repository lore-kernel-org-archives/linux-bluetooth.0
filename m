Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E552836A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537953; cv=none; b=cBt9jT0lkFdUqimmOJPFgPSlfDgQt28rsTXG++OdoE27XHF0FZ3YMfEl9B/y0eOUI62xstaayAnFhNpiT4AsUHDzOoFiPaQzKKqFbZ8gcMlBHQ/J14nWpRebVgeTUnCITIp6/ro5TZGQlWS7lf8fG4SlOda3E/RwbpAi9qahTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537953; c=relaxed/simple;
	bh=wtjud2YtOQ2UE50nHquHvVJmMIfCTsaJMdHf6PrrDKY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PjVcyOb/bfFKy9x1EfT8nSDcqnUiL1sXP9W9XvcoHWkLdlvJlj13wjKTR2W7JXSO+8LJPPwiSv76krAjKNKXaQh7FscLuzqX90NSql/JPa8l6Tc8/znNNWlmiZ+AHFi5V25UQG5bdXmBC3lT+yPPsDcl/gYjNQMowB1OsM/JwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kWsc3GmY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kWsc3GmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778537951;
	bh=OK2gAIWS2UlE29QjesifRFAvvLMRkLeIMIa7Xj+tZCA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kWsc3GmYpC1g26jbHY218vltjcmMw9N0f5loeBG7kohHc2zZsf8CtIyUYNFDe3mQ5
	 D3aM7NzJBQ/TO+gGYDOJM7Gonb8yDJSU99xUlOuax6EkOtcRNFXnnt2oi5CpwLEJNg
	 HWUdgUVuxLsUMAopZsQL9K8iDssLatZ5K61/4d1w=
Received: from github.com (hubbernetes-node-5433c44.ash1-iad.github.net [10.56.179.14])
	by smtp.github.com (Postfix) with ESMTPA id 41EB1360B6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 15:19:11 -0700 (PDT)
Date: Mon, 11 May 2026 15:19:11 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093117/000000-2c6d6b@github.com>
Subject: [bluez/bluez] 2c6d6b: adapter: add BCAA UUID also when seen device is
 no...
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

  Branch: refs/heads/1093117
  Home:   https://github.com/bluez/bluez
  Commit: 2c6d6baaf29b7b7cf6cc44e9d26a0239bfbd3e19
      https://github.com/bluez/bluez/commit/2c6d6baaf29b7b7cf6cc44e9d26a0239bfbd3e19
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-11 (Mon, 11 May 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: add BCAA UUID also when seen device is not discoverable

BAP v1.0.2 Sec 6.4 specifies Broadcast discovery uses observation
procedure (Core Vol 3 Part C Sec 9.1.2) which makes no reference to
device discoverability state.

However, if remote device does:

1. Send Advertising Data for some other UUID with General Discoverable
2. Send Advertising Data for BCAA UUID with no flags

then adapter.c:btd_adapter_device_found() creates device in step 1. but
in step 2. it ignores the BCAA UUID since the device exists but is not
discoverable; the monitoring=true special case applies only for
first-seen devices.  Consequently bap plugin fails to pick up the BCAA
stream.

This sequence was observed to be produced by BlueZ + btvirt.

Fix by monitoring also previously existing but currently non-connectable
devices with BCAA UUID.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2812#note_3467783
Log:
--------------------------
@ MGMT Event: Device Found (0x0012) plen 17
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000000
        Data length: 3
        Data[3]:
        02 01 06                                         ...
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
...
@ MGMT Event: Device Found (0x0012) plen 39
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000004
          Not Connectable
        Data length: 25
        Data[25]:
        06 16 52 18 56 db 55 03 03 4e 18 0d 16 4e 18 00  ..R.V.U..N...N..
        ff 0f 0f 00 04 03 01 01 00                       .........
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 5626710 (0x55db56)
        16-bit Service UUIDs (complete): 1 entry
          Audio Stream Control (0x184e)
        Service Data: Audio Stream Control (0x184e)
          Data[10]:
        00 ff 0f 0f 00 04 03 01 01 00
--------------------------



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
