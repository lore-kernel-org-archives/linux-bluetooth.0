Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6F1F237A
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271280; cv=none; b=DgmTO9t19OUeiNFkEloSpJzzeDq4+5ceDs71wXhG42pnt+CUDWMPKfScKnJqlxbHXzjAhW3kZazcgp4qpjg351CfyqGEMBJgGjN3zug5nD5nFmI13IwyBsl3bVixQerxtWIsPgTO2gNs512aWLFFWgDXmDPKRF0CFsWnSTXIs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271280; c=relaxed/simple;
	bh=H1EyLamlQUbLSaO5M4EkgMvq9cY5In2LDVsQai2Du5o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZFdLdWTV51YP8NhTr61JrGurSJk0WHZMLyN5PsZY1rm80VCTa24Adzp0mSD5nWfg2nXc879NLOufWnDIjDC+U/sHc8WbAvd8+TyR0WM5LpTQBbjcokvzAGPWWFv/DvXRpmlSorH6ELQddiYzIXNAqaiHu6IYgYUMX2lptbFhg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XcTCdEpi; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XcTCdEpi"
Received: from github.com (hubbernetes-node-aac89a5.ac4-iad.github.net [10.52.167.42])
	by smtp.github.com (Postfix) with ESMTPA id CC39B2112E
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751271277;
	bh=cZEBArOd+vbBxfNDpUmeWyiRzAx6sV8WhMs/fpP6NE4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XcTCdEpixaSDNCpfg23U8GAtTfN6eir3y1LrdU4Kz3OoKeuv0ZZN9yuYcIFs5vNJl
	 clHSHmXDO1amMNwNpC1BDpMaR+dL/ciDJTUtB/oPCLHRKIHCnbYONpBuefoUPl0ybh
	 WvciPZbqofdmouuQYswIY/Lu5K74GwtSOQpRQtNU=
Date: Mon, 30 Jun 2025 01:14:37 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977201/000000-baedb6@github.com>
Subject: [bluez/bluez] 4f3600: shared/bap: Set stream to idle when I/O is
 disconn...
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

  Branch: refs/heads/977201
  Home:   https://github.com/bluez/bluez
  Commit: 4f3600f404743a00dfa8ca8558e84a1526d694db
      https://github.com/bluez/bluez/commit/4f3600f404743a00dfa8ca8558e84a1526d694db
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-30 (Mon, 30 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Set stream to idle when I/O is disconnected

When BIG sync is lost, the stream status transitions from Streaming to Idle.

  > HCI Event: LE Meta Event (0x3e) plen 3                #3189 [hci0] 118.870863
  	LE Broadcast Isochronous Group Sync Lost (0x1e)
  		BIG Handle: 0x00
  		Reason: Remote User Terminated Connection (0x13)
  = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0..   118.871183
  = bluetoothd: src/shared/bap.c:bap_bcast_set_state() stream 0xdf..   118.871227
  = bluetoothd: profiles/audio/bap.c:bap_state_bcast_sink() stream..   118.871258
  = bluetoothd: profiles/audio/bass.c:bap_state_changed() stream 0..   118.871307
  = bluetoothd: src/gatt-database.c:send_notification_to_device()...   118.871384
  = bluetoothd: profiles/audio/transport.c:bap_state_changed() str..   118.871452
  = bluetoothd: profiles/audio/transport.c:transport_bap_update_li..   118.871509
  = bluetoothd: profiles/audio/transport.c:transport_update_playin..   118.871555
  = bluetoothd: profiles/audio/transport.c:transport_set_state() S..   118.871610
  = bluetoothd: src/shared/bap.c:bap_bcast_sink_detach() stream 0x..   118.871660
  = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd25..   118.871689

Fixes: https://github.com/bluez/bluez/issues/1343

Signed-off-by: Yang Li <yang.li@amlogic.com>


  Commit: baedb651f920e566a84ced04183dea1cd220894e
      https://github.com/bluez/bluez/commit/baedb651f920e566a84ced04183dea1cd220894e
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-06-30 (Mon, 30 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add stream state check in stream_disable

Add a state check so that stream_disable() is a no-op when the stream
is not in ENABLING or STREAMING state. This prevents unexpected state
transitions or redundant operations during cleanup.

Signed-off-by: Yang Li <yang.li@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/4f3600f40474%5E...baedb651f920

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
