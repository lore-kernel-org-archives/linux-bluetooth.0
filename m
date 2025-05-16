Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CE149DF0
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376198; cv=none; b=MrPZH35urgpUuwA3BI1Vla4GXq5RnciLBv5K9mtCxWD0wzeVQsBf3xyv8UWTVny2fdGlbUS5rB90vdnqK4/Te1IydW3rMJMcak+JLCuf2WjATcsBR3udXxVDoDcmEbz7ZoTGOlzb8xepaEO8VCh775lkV1zwG7q/1L2tmcCdRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376198; c=relaxed/simple;
	bh=3py0n09+JgSWtk+gGY72Plt3rDOltSyldPK4YRxN2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z4noeLjXorUIcZWMAukaL3aEbI0x2kQ65dSh+UUZ7K/olMCF0u2ZM8Q6nz4QqUR0Rfm0w5YbMf9mmcB4Z72fPRhYPF8K5KsWK3HopW8DPPNPgvGFUZKnO3wJkr+3EEh3nUUSC6BihPGP/vhkuctmSHtqbZWc+SR/8uaUfXKWyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XIFRop+9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XIFRop+9"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C8459100011
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 09:08:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C8459100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1747375688;
	bh=BsPOPYBPx169ZuXiHhxB/y6zuQgp6GWLP+RhzDOuJfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=XIFRop+9w73dX3x4J3sXPD7mU5FK+GbiSfG9AWGgkZYUEpzdikCcHRDV2Es3okeX2
	 ugZhHl5DNbceghyPWFd/cyY6K4BvhFJxdjdp65gPfu6e7fWq2gljl4PiejJCPoOTsE
	 eFrIeTMu8rpVAPU0oZx3YX/InYEPM3q++puRd3aOOUsl0gPz033u6P/ugYsLrHAHKn
	 uUPTNGufb71Q+TxeSpMf5K2vLuZqCQmbfb3hakrbav5sA49aPc14m/EDqN8MmKXzPF
	 hmmqWwWJ/BMiRJg7QrMjoYo9FPhlr41x33zOAFRxXuPssHPh6ceEcfP7TPbuM1m4BT
	 pzt/Qj+rghnEQ==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 09:08:08 +0300 (MSK)
Message-ID: <7f3919de-819a-4df8-aeb2-e17a97b3d604@salutedevices.com>
Date: Fri, 16 May 2025 09:08:01 +0300
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
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 193371 [May 16 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: ovlevin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 57 0.3.57 4d40b83f2d84157cf8cb531aa833108d098dc3e3, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/05/16 04:50:00 #27984378
X-KSMG-AntiVirus-Status: Clean, skipped

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
