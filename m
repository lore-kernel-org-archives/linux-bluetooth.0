Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F538D;
	Mon, 11 May 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481018; cv=none; b=N9cLnC7AMk0xVYXXpg48ud7dYpyNUKEf9agx120oJrOowYaM6VxSs0emIL83ohfBx5dpGYDM75LkCIeoLMGUZ36KXGVU1BvJ3ptht2zfYWawgIGEAqIYB6/5u2758q/SmLNxGCdx39NbKqfsx4BoiotcvARl0EZB56vzPoov//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481018; c=relaxed/simple;
	bh=LKk49BYYahEX/ogTF3fB76enQeNUY+jlhggXzzuQoKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JlH7bjA4URMPc3MFX9mm4ODXGvpQcgcemyYRx4Fx9k7UafI17KufnyczWoxGreSxhciWjkJebpoWKGki0xczw/IxnmVVjV2ByzjUXMYdMOm5gZhyOe/iuRTlyfu7HTdIG0ra2OZ/Wzxy5GuFcFP7xRXBvw6fxci1w5yMSROV1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=l4dLhcjL; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="l4dLhcjL"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gDVFq0K5lz86L2;
	Mon, 11 May 2026 08:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778481007;
	bh=LKk49BYYahEX/ogTF3fB76enQeNUY+jlhggXzzuQoKQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=l4dLhcjLsUrRMeESiD8by5l8cbIpn5nZZ30jxNbCatV26LjjHvEYatv3kX91mk9jG
	 E4l3HNDNmL6BcAf0wTZmFbm5sx1zjhSBYMhxvxZFgMxl32G0eMrdQSETbKmjTzED/T
	 aeujt//+hJiId6NttkOW+oKGwPiXEU7NpBSFUMnW44AXodlpcKeDsAuq+BXhDu55e7
	 LXajUdcx+oqGdzJHfkKUcY3QyCPc99dFBYTDSgmntS5Leh97rYmxRAEDMxBZInmtoH
	 f1qic421jX0ZVuwI9WGGGrBLipnacGndKlWl/zYeKxPDgKthKiFdy/WrudU6THC8eN
	 cUu8Sl7dkPbWQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gDVFp6kb6z86GN;
	Mon, 11 May 2026 08:30:06 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gDVFp1vKvz8svf;
	Mon, 11 May 2026 08:30:06 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 9F3D061837;
	Mon, 11 May 2026 08:30:05 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
Date: Mon, 11 May 2026 08:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
To: markus.suvanto@gmail.com
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: linux-kernel@vger.kernel.org,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
In-Reply-To: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177848100600.3495226.3526253921001327380@mxe9fb.netcup.net>
X-NC-CID: u9b/F5+RGuLVrkiC2KntT5mHbEnDMX0DYPqupjqEls0GsAUhdqA=

On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
> Hello
> 
> I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
> hci0: Failed to send wmt func ctrl (-22)
> My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206

Thx for your report. FWIW, there are two proposed fixed for this change
floating around:

https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/

Given that this is the third revert within a short time-frame I wonder
if we should fast-track a fix (once ready) to spare more users the pain
of bisecting & reporting.

Ciao, Thorsten

> -Markus Suvanto
> 
> 
> commit 994246ea1eed9029d648b28a9828359f5046173e (HEAD -> master)
> Author: Markus Suvanto <markus.suvanto@movesole.com>
> Date:   Mon May 11 07:29:47 2026 +0300
> 
>     Revert "Bluetooth: btmtk: validate WMT event SKB length before struct access"
>     
>     This reverts commit 634a4408c0615c523cf7531790f4f14a422b9206.
> 
> commit 5d6919055dec134de3c40167a490f33c74c12581 (tag: v7.1-rc3, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun May 10 14:08:09 2026 -0700
> 
>     Linux 7.1-rc3
> 
> 
> Lenovo ThinkPad T14s Gen 1 (20UJ) AMD Ryzen 5 PRO 4650U 
> 
> Not working dmesg:
> masu@t470 ~ % grep Bluetoot dmesg_7.1.0-rc3 
> [    4.229749] Bluetooth: Core ver 2.22
> [    4.232923] Bluetooth: HCI device and connection manager initialized
> [    4.233081] Bluetooth: HCI socket layer initialized
> [    4.233227] Bluetooth: L2CAP socket layer initialized
> [    4.233236] Bluetooth: SCO socket layer initialized
> [    4.413060] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20251223091725
> [    6.142372] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.142384] Bluetooth: BNEP filters: protocol multicast
> [    6.142393] Bluetooth: BNEP socket layer initialized
> [    7.727087] Bluetooth: hci0: Failed to send wmt func ctrl (-22)
> [    7.727140] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> 
> 
> Working dmesg:
> masu@t470 ~ % grep Bluetoot dmesg_7.1.0-rc3-00001-g994246ea1eed  
> [    4.296358] Bluetooth: Core ver 2.22
> [    4.296385] Bluetooth: HCI device and connection manager initialized
> [    4.296393] Bluetooth: HCI socket layer initialized
> [    4.296399] Bluetooth: L2CAP socket layer initialized
> [    4.296404] Bluetooth: SCO socket layer initialized
> [    4.391514] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20251223091725
> [    6.087152] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.087165] Bluetooth: BNEP filters: protocol multicast
> [    6.087172] Bluetooth: BNEP socket layer initialized
> [    7.591891] Bluetooth: hci0: Device setup in 3127955 usecs
> [    7.591922] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [    7.657339] Bluetooth: MGMT ver 1.23
> [   25.883135] Bluetooth: RFCOMM TTY layer initialized
> [   25.883150] Bluetooth: RFCOMM socket layer initialized
> [   25.883154] Bluetooth: RFCOMM ver 1.11

