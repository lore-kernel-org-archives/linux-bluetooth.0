Received: from mx4.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370B2C325A
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849080; cv=none; b=Y/lVhQgSeQbGQmyEEkxHNo546+2+bnXLg6S73wkVhKff61H9oX2SOuUwJpzPZoEYix+QCblwnLfAG4hsEyadag/Lv/rXR+LBa4NUhzAEuPlIDRwbyXl/f+yRWXqGvd/FzhcnWBmguahKxhZodNtgveCJZk2axJWT/OZi/5rzuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849080; c=relaxed/simple;
	bh=3py0n09+JgSWtk+gGY72Plt3rDOltSyldPK4YRxN2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gutdgaymTUWsbQYpZnKbYEcvIbm2Z3YUtLDqNWNnU9QS6x07tQThwGFM1o4171CvR0sYufh0SYzfKWslkx+KHKr9aTjsmySyzZHtlHdLb50P3tgyOr2QC+FHb10EgimQzvjy6LdXpJwv/ivwA/3VFIfWe3sNUpja0sfkMd2Kyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=YbgnurnG; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="YbgnurnG"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 36AF0240005
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 10:15:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 36AF0240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1748848520;
	bh=BsPOPYBPx169ZuXiHhxB/y6zuQgp6GWLP+RhzDOuJfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=YbgnurnG7OhNpQNKnivySASCLIhUzGds9Y0Jkn54kJGtTPoz7IESRpQzit/9ttCny
	 I1DnX395t8kD9xMPyQZJ0CQAu9FvK2+TqAHBQc39Lhds7ZoHfXrKavvY6Mew9uBwgf
	 rzqmkPPGKmI8z/L76lDzoGCvLuq8AvRsICkIEVS2F8NbZu8/8/7cGrannP7xMkiSdx
	 mOY7pIH1wrabB1AgGhfW02eaykm6DbCMMljnlankHRbBQ/fwgcmcT0/pBsK0zW1Art
	 4K4P9GWF1lfOo/FE+m4GbCcy2HmHc9wibWag63BnFTe1aQRaIFxxcVzaINTR2w81xo
	 fSmon0wPy1P6Q==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 10:15:19 +0300 (MSK)
Message-ID: <a20d281e-5961-4d73-9285-76bb982b2ea4@salutedevices.com>
Date: Mon, 2 Jun 2025 10:15:19 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH BlueZ 0/1] device: Fix rare ERR_BREDR_CONN_BUSY during
 connect
To: <linux-bluetooth@vger.kernel.org>
References: <20250414115017.116579-1-ovlevin@salutedevices.com>
Content-Language: en-US
From: Oleg Lyovin <ovlevin@salutedevices.com>
In-Reply-To: <20250414115017.116579-1-ovlevin@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: ovlevin@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 60 0.3.60 6d88365a2e70c53a128ac88f235883e0110f9019, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 193777 [Jun 02 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/02 01:54:00 #27530786
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Gently reminder, please check the patch.

On 14.04.2025 14:50, Oleg Lyovin wrote:
> Hello everyone,
> 
> While experimenting with a device acting as and A2DP Source, I have
> encountered the following very rare case during connection to an
> external speaker:
> 
>   1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_28_2B_B9_40_00_1B: SINK_STATE_CONNECTING -> SINK_STATE_DISCONNECTED
>   1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_unref() 0x17c1350: ref=1
>   1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/a2dp.c:channel_remove() chan 0x17ac468
>   1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_unref() 0x17c1350: ref=0
>   1970-01-01 00:37:47 debug bluetoothd[240]: profiles/audio/avdtp.c:avdtp_free() 0x17c1350
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:dev_disconnected() Device 28:2B:B9:40:00:1B disconnected, reason 2
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:adapter_remove_connection() 
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_remove_connection() connection removed while Connect() is waiting reply
>   1970-01-01 00:37:50 debug bluetoothd[240]: plugins/policy.c:disconnect_cb() reason 2
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 28:2B:B9:40:00:1B type 0 status 0xe
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
>   1970-01-01 00:37:50 debug bluetoothd[240]: src/device.c:device_bonding_failed() status 14
> 
> Subsequent attempts to connect using bluetoothctl lead to
> "br-connection-busy":
>   [bluetooth]# connect 28:2B:B9:40:00:1B
>   Attempting to connect to 28:2B:B9:40:00:1B
>   Failed to connect: org.bluez.Error.InProgress br-connection-busy
> 
> The reason is that "connect_profiles" does the following check:
>   if (dev->pending || dev->connect || dev->browse)
>     return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY);
> 
> In the above scenario, "dev->pending" is not NULL. I have prepared
> the RFC patch that frees it when a disconnect occurs in the
> "device_remove_connection" code path. I'm not sure if this is the
> correct way to solve the issue, but with this patch it can no longer
> be reproduced.
> 
> Oleg Lyovin (1):
>   device: Fix rare ERR_BREDR_CONN_BUSY during connect
> 
>  src/device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
