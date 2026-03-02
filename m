Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED637C110
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440640; cv=none; b=mSMAxgBSISCVmvdjCgkqyWgnvrqNlwRP+P2HEB7JbfgJtYI7TAotLmCdnqkUKWihdRJLv5lrEZNK37txpHQhYQXZxaEIj3EzZu8DevZaPwqtNtIQyyICLXY4c2TTpJhVk4jf44KPxs5FttDOLWsdPWPekGFgG2cHLa79QqAGMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440640; c=relaxed/simple;
	bh=hA7DOXs5zyuDimjhXxA7C85+MSxHX2pkz9YlNHCp2hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVTfPMPRh03NRWasvVaYTiD+Uw3JEjBGR5B02fGvWVjQ8Zjz6qXw63Cl1u7Ll+cvzjEC/wB+IpvfuhsUHKckpbsHDbgimm+JL0kuFtwE3Auuty/7+up7k6Llscj+8JEqZ2pUGN5h4tQpBF7FIYuiKux1aXN6uXU6OpC7q9IwpMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HVhkVn4i; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HVhkVn4i"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fPX9p0Z4Wz62Qn;
	Mon,  2 Mar 2026 09:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1772440062;
	bh=hA7DOXs5zyuDimjhXxA7C85+MSxHX2pkz9YlNHCp2hM=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=HVhkVn4ioX2ozGnkXLqlsekDHqgn810QQoYB1BAg3bXviAbzytnTxAA8Vxd4vCiKV
	 RI4PRIvxcPtOLFLADY0sVZBgo5cWyiJAPTQBbIjZkm2ikvmHjd3xihh8ocvhkZdxQP
	 I5LEoWpsBACVnXS5WQjFQydZvj3PRKPV2b+qw2f++Cr6tsQwRtr+i+iJBb2T48PY+D
	 +Z13bMuaez0l3J8rGkKi2GPPfeBuzQnBMTUT33fRa5rfGdoA6GgOh8nZ99vOzrSjlL
	 PK8/CC1KSt4YezJS1A8znABftFvpHGPEwbQpU83FH+Ii3u5ZDAFoZQVSGcPVTujp6G
	 P8I6WXfXKM6Lg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4fPX9n6y5gz4xSB;
	Mon,  2 Mar 2026 09:27:41 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fPX9n1H5pz8svW;
	Mon,  2 Mar 2026 09:27:41 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id C0829632C5;
	Mon,  2 Mar 2026 09:27:39 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <2107aa63-ac31-4e46-831a-21411962330f@leemhuis.info>
Date: Mon, 2 Mar 2026 09:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX
 ident
To: =?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260126175340.3576865-1-luiz.dentz@gmail.com>
 <20260301233619.1807980-1-joanbrugueram@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20260301233619.1807980-1-joanbrugueram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177244006004.2159236.16752863118894184995@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: C0829632C5
X-NC-CID: lLD1MOv0PWUG9QGXj8pMgwaOHls+QRdVWz+G+jsxs6ZDirmN/pI=

On 3/2/26 00:36, Joan Bruguera Micó wrote:
> I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
> and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it.
> 
> The symptom is that when connecting the headphones via bluetoothctl,
> it either hangs or appears (in pavucontrol) as if it's using the AAC
> codec, but there's no output. Sometimes after some time, it disconnects
> and then re-connects successfully but using the MSBC/CVSD codecs.
> 
> I haven't had time to troubleshoot this further so far, mainly posting
> if it can save someone a bisect.
> 
> Bluetooth chip: Intel Corp. AX210 Bluetooth (ThinkPad T14 Gen 2)
> Device: Bose QuietComfort Ultra (bluetooth:v009Ep4066d0167)
> Bluez 5.86-4 (Arch Linux)
> Kconfig: That of the linux-mainline AUR package, plus UBSAN

FWIW, someone reported problems due to that commit in bugzilla, too:

To quote https://bugzilla.kernel.org/show_bug.cgi?id=221120:
"""
Bug 221120 - Bluetooth headphones stop connecting properly after commit
6c3ea155e5ee3e56606233acde8309afda66d483

Bisected to this commit. Before this headphones can be connected using
A2DP music profile or HSP/HFP for bidirectional (headphone and
microphone mono). After this dependig on the model of the device it has
only one of options available(Marshall Major iv keeps only HSP while
Chinese no-name keep only A2DP ). Reverting just this commit from
Linus's tree restores normal bluetooth audio.
"""

Ciao, Thorsten
