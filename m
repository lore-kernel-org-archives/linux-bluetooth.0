Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854721A459
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731696; cv=none; b=JIx7/9uZgp0TBn94sfn4QCNmlKec/syJqWHHCjXaBIa9RjNVld2ZDsJtSqpeTVGhgQLDT2nLRTs5mPCyLcnPCXwBnL1KUveuT53u/oJ12IGjsNH8yeaCxzxctIGZhHXQAKm9UAv+WmeoesIVnuJ72N1NM1T0cZQbHRx1isDw2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731696; c=relaxed/simple;
	bh=E5GDAnAVtiPBKrbcL8pX3d5VvRgjR0V3mNJL/8ebhPo=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=G3gee7IjB1ECA3SrX5CGPpWGVeQa+ikJJCiAnTSY2Zz9pUIOzXY4Zln5xlYq08WV5m74aCkn1Xm7BgbvRMvEMc6G3JUW7f2HZBn7iTFhctQKuCis3FdH4c+Hk9e1MBce3ZDh1WUJytfSWOFcJEkbMaK96KoqH2xpVB7Us9p7Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=BoHJDuQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcBUGd6c; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="BoHJDuQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcBUGd6c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CD7741D00055;
	Thu,  5 Mar 2026 12:28:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 12:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772731693;
	 x=1772818093; bh=Po5CjjKqU9WPKhiO1bZML6kXmFi791C74AnDmJwMKlM=; b=
	BoHJDuQ/BUa+39y1JUcIG7zWXLJuvAFURaJaH7rnktkascEemnDVHJthQQ3M5o10
	5O74Dbl85kloiXiKOIhXCrSHr8XGylcP2mMK0goBcKTSdh4I+/CCRzBmhb2aJTaH
	Srx/s0x8fWoNthEA3RydutEupp0rY9wNYbBx5WR8YDRRaNKLgIfRg7ju64DwJ2/z
	2Da38Q1YVSONyapvr8UwpbHd9w+yO0GrcGKV6ge+1/aHDYOC1TuLYsOaFA4HZ2nC
	sg7WDs5WNAv3IvM1SiAlAxFds2Y4j2uAo2TGoXOvunfhBC+FqIj6lSuM1/ynM5gY
	I1xi4heGPLGT7XPJUcirsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772731693; x=
	1772818093; bh=Po5CjjKqU9WPKhiO1bZML6kXmFi791C74AnDmJwMKlM=; b=t
	cBUGd6c2I0TvsDCak9O2Uf71wmLhtgMxqx2sLx692BbglEileWwBbQZ/vJQMi+VU
	kvBJgYUGMsIsugVm7RSVwlFFvq+4+umzULeVfKyBMToM3hGrjNx1dICLDyyqWMq4
	9Wgr8983s96YRcqoPIuNqJ+jIoziXcNerbsvYIgxCXn2afSom+QzfN1Lvz83Q3lp
	Gr/jOQN1m0DhDZQwi64kU/EXOEFdOySR58fyZ2yC4ERUuxejy7l1ikWzfo53JkQo
	PV8WK0w//b5B/SO9FyRAOlEy0Xytdin4VRU6D1qZH36yewNeE0qpgDJAXktmvJCD
	id+TIH+1q8VM/fxeBH8Fw==
X-ME-Sender: <xms:Lb2paVglr8X0Jh_XLZcOmObz6wG3fYtH5HpRlU_HbA_UmhbPWpWrHQ>
    <xme:Lb2paU3Kzh9otw0RD_k9a2DqlMCVj27q_YBaFns4a91LDjGCjVWSioDnn1gjJIVLU
    UI-76nfUjLKJ_4p9H8ahIsL91z3j1CjyyNGYNV89-LfSoM55tXpBu8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeefffduleefieelgfeiuefhffeigeekkedvhfevfeejtdduffeguddv
    ieefffegheenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhho
    shhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthho
    pehflhhoshhssehjvghtmhdrmhgvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhooh
    hthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lb2pae_9dwANA9179zSQxcRf9GlCtNeDUn313ZmIxkWy2LDThFyZxQ>
    <xmx:Lb2paWdcWkTeekd7HxGMeTi6ItEI1QkhJtFL5za1OQTy0viiNFEZDQ>
    <xmx:Lb2paXFd0zQnbeoPjBET6A8B4AY6zAj4HHorh7hndmJZ7d5KgjHZNQ>
    <xmx:Lb2paUfQr5DBOIhJthXEi1GrezKBnVZhb-kaKA7EntvGzK-vnQTsUA>
    <xmx:Lb2paRYmoaP5fE22AsX8iIYu_ghVu80zWRLzDqpWJxXDFtaw5hSeTceH>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 12F6E1EA006C; Thu,  5 Mar 2026 12:28:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 05 Mar 2026 11:18:12 -0600
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add USB device IDs for MediaTek MT7927 (MT6639)
Cc: Javier Tia <floss@jetm.me>, linux-bluetooth@vger.kernel.org
In-Reply-To: CABBYNZL6MOoCE7Ft6tQLLJtUqs_uw5o-D5OSHTWC=Q_PE5kjdg@mail.gmail.com
References: 177272816248.352280.12453518046823439297@jetm.me 20260305162930.E1A171EA006B@mailuser.phl.internal CABBYNZL6MOoCE7Ft6tQLLJtUqs_uw5o-D5OSHTWC=Q_PE5kjdg@mail.gmail.com
Message-Id: <20260305172813.12F6E1EA006C@mailuser.phl.internal>

Hi Luiz,

On Thu, Mar 5, 2026 Luiz Augusto von Dentz wrote:
> Is the lsusb information for these devices present in the links? We
> normally require that to confirm these ID's are real/valid.

Yes. Here is lsusb -v from my ASUS ROG Crosshair X870E Hero
(0489:e13a):

  Bus 001 Device 005: ID 0489:e13a Foxconn / Hon Hai Wireless_Device
  Device Descriptor:
    idVendor           0x0489 Foxconn / Hon Hai
    idProduct          0xe13a Wireless_Device
    iManufacturer           5 MediaTek Inc.
    iProduct                6 Wireless_Device
    Interface Association:
      bFunctionClass        224 Wireless
      bFunctionSubClass       1 Radio Frequency
      bFunctionProtocol       1 Bluetooth

The other four USB IDs have been confirmed by users on their hardware
with lsusb output in the tracking issue and bugzilla:

  0489:e0fa - Lenovo Legion Pro 7 (kerberos272)
  0489:e10f - Gigabyte Z790 AORUS MASTER X (Thex-Thex)
  0489:e116 - TP-Link Archer TBE550E (marcin-fm)
  13d3:3588 - ASUS ProArt X870E-Creator (samutoljamo)

Each is documented in the GitHub tracking issue [1] and the upstream
bugzilla [2] with lsusb and dmesg output.

> Ok, this is especially valid if AI assisted, otherwise we would
> probably need to ensure the agent has access to every board to list
> its IDs, etc.
>
> Regarding the use of AI, there doesn't seem to be a global policy.
> However, for Bluetooth Im not inclined to accept any patches that
> hasn't been properly reviewed by the author

Understood. To be clear: I wrote and reviewed these patches myself.
Claude Code was used as a coding assistant (editor-level help, similar
to copilot), not as an autonomous agent. The Assisted-by trailer
follows the kernel coding-assistants policy from Documentation/
process/coding-assistants.rst.

I tested the patches on my own hardware (ASUS ROG Crosshair X870E
Hero, BT 0489:e13a, Arch Linux kernel 6.19.6). The USB IDs come from
real hardware reports by real users, not generated by AI. The patches
have been running as a DKMS out-of-tree module [1] since January 2026
across Arch, Ubuntu, Fedora, NixOS, and openSUSE.

Your feedback is being read and responded to by me personally.

[1] https://github.com/jetm/mediatek-mt7927-dkms
[2] https://bugzilla.kernel.org/show_bug.cgi?id=221096

Javier
