Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F87185B48
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292979; cv=none; b=NnqNVlFufxS0iCJcvv9NSCU6Ue7u0K2YURNhHyh8/HJ6LXRbCgqTtbox7xPAoKAkJspejsyHLSnd5SOhszUaSVeiUpnja+6+/78GB6VMaKXeqJduuXDuRe6uWdyEUfw8h86ChrWmxTsIsEmPV7RY77SGG2yfrL8d28aiDM0sKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292979; c=relaxed/simple;
	bh=5+ugy2UavkJSALdXTZwsp/MuxaHU1p2bquwd0fZf9DI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XN5zfhQwTRMLz4pq88iAciN/1tBWOHoiS+QCfVV9ds+kOabyX4+dWsm8Z3Ghj/9OfEriD7AxFqdNONghKLxOxLdaXD8WqHUMmpQH/itmbdLHOUUQZCJ+Zbz+1WUv1Bxpt2xY8K4teSzeO11Iv6lIRZtA7Q7jprsD2Qki0h2qYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dRVY8AsF; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dRVY8AsF"
Received: from github.com (hubbernetes-node-deea9a8.va3-iad.github.net [10.48.167.51])
	by smtp.github.com (Postfix) with ESMTPA id 10A0F4E06EB
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751292977;
	bh=fJoFJvsf1na2JbA7w8WZn+bf2pZzfN0xrbpmtjdZE60=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dRVY8AsF0rRebVj2EJD8LvulFdaMAqiVAkMPiIi92WIN+dcTxS4VKROkJRSD1jNiF
	 bVX9inBR8iMcsGVUUGC7gmDrrVB5WJxd1yyiLzv6lJYLTHh6tNIqvohoYYHPmKwCxL
	 WrclkuX+KI6c6ogsXPL7/RvXihhp2lq3EdtQXlJo=
Date: Mon, 30 Jun 2025 07:16:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8e2425-822037@github.com>
Subject: [bluez/bluez] 822037: shared/bap: Set stream to idle when I/O is
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 822037fe74503fe87c3dc0b11dc69f2e9efa2376
      https://github.com/bluez/bluez/commit/822037fe74503fe87c3dc0b11dc69f2e9efa2376
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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
