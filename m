Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94A3DEAE6
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731699; cv=none; b=k83k5l07n8HTBMxB6c1pgi0e1xIGZpn3lv0miGDIbzR/7kH5MbJSo+0t7v4qPtV3wpwxsvmuQ7GwNe9PzNU+zAYHdyu9Gaff19GHFxi1FVGu57gKByZyXNk8v6nX8ED6iJ0cPZdHzTJkfoLjBlMJ2TAruG6Vk7odZGJSvEb69zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731699; c=relaxed/simple;
	bh=A8/Tet9efscpEtLDgxSYvfR0/v1fQ1sXQMD+qmKFwdY=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=vC7IKaSFJNKokDRD+JVqKam2jd4I5+/fnBx4R/EGlFVGRUJLs1W/v2Vl0Frrpa5JnO1uDBBaEjhcG9nOmxOMNXWXCg42efQByauQ8CXS4a6YXwPWxj3omXgE8huoo/Rp8aVjKIDjddA3jwI130iB3Umr7/cd5Jvx7143eSzyq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=Qiu+bRoQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rOgwI3V9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="Qiu+bRoQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rOgwI3V9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCCAA7A0164;
	Thu,  5 Mar 2026 12:28:17 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 12:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772731697;
	 x=1772818097; bh=TQXDiP28JRv5Nfadl0wsix5nPqRMoqHns0y0Gax0+x4=; b=
	Qiu+bRoQWebrZCbpNJHBWjTz3MUP3+C8FICqebIA4qqge8HJ8FCdDJfJAaIDmBNv
	WeJd6LpaCD/zuLcpZM/IdcZpKDwLTHYmQJHM6zCNHPmx8gYEZwfzESXPM4Mbxd3t
	XhWKiik9JQsDNjIgcbIi2+Qi6I4rUG94R3cKK/q9pnjgm4tCDSACTYtmHnM6mow5
	l5hgComxIfxWClPBaw9cEjQFFJ0wbH2/XHHtzuyBSSWDxHg9gCR+pBbCPIb+k9Z7
	LikfWOz+pkWG2msqqz0yZdBVOkOdDVBUi16OF+6I2QPNpFR2yYigzMi+yFdZctdt
	e11niDt1mAS4oXNhy0Eo+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772731697; x=
	1772818097; bh=TQXDiP28JRv5Nfadl0wsix5nPqRMoqHns0y0Gax0+x4=; b=r
	OgwI3V9x62UvtQ6E5o5tbwVsnXRi7guVfssKJmodTBq6ZURVkiqzLl98WZQwAKVg
	T9tfYY7+DKVmZ5MaG2GYaeXGDS9AK7hKEBH83XXjqsWCU5usX81ewq8gcYIiQT3I
	JJNbxeSIG97m/QhzymwdKCpnBAtZ1KXVrbVsJ3+O1dC4YxWNEwnzBSJU4/zOfK9i
	LRMujSUXXnKOlTXBrY59ebNjRPB0vDasBzERg9WGSVvAXg/AIH/MkexTHYQsHqqt
	DoKqxYznVwtg/UaXVpHg5RaeY9ZkIH1YzhNMsKhlJeuSitIHA7putlmohHdUJWR+
	PTMZgQ+VAqvKYzvCM7DXg==
X-ME-Sender: <xms:Mb2padK8NS6q61x7OMWaT4ys1Das7qkfY8W4WhBMGiN-CvpHfOfjwA>
    <xme:Mb2paT_lrP1JhqLwP_koSYVtZuZaIkV-rBsbxi3E_FxQhP5KxTe7QGEbxK3T6eJBC
    aspNjTbxEeWRAmByGCTOr0q0CM_M2uIOgjTUxXr8_TjzFL3xC7IV98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpedttdeuvdefueeukefffeekgffgffeigfehjeevffehkedtueehveeh
    udeggeelgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhho
    shhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthho
    pehflhhoshhssehjvghtmhdrmhgvpdhrtghpthhtohepuggvrhgvnhdrfihusehmvgguih
    grthgvkhdrtghomhdprhgtphhtthhopehmihhnghihvghnrdhhshhivghhsehmvgguihgr
    thgvkhdrtghomhdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmvgguihgrthgvkhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:Mb2pac1am73L_sU4odAEkAIher-V6PtUenYj1AkFTQ5BjWvdMs1-jA>
    <xmx:Mb2paQZHo60aLxCV4wQQCwK_SqyqWofnUGwUB3Jb8x5nFOo3SMIzmQ>
    <xmx:Mb2pacJwUrQGC6UNFrKEnFH0HuCV4jTnAQAjWd1S9oQQy0QQMvWBVg>
    <xmx:Mb2paXFtcJampha0J9JxWXygWqzsuizM0F9-fRDweKZPlTVobhPHtg>
    <xmx:Mb2pacXRw0uQ2TGwtH59jbal177KBr5q5W82Suj6BXfIi7A99NGsbvXh>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B8F51EA006B; Thu,  5 Mar 2026 12:28:17 -0500 (EST)
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
Date: Thu, 05 Mar 2026 11:18:13 -0600
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
Cc: Javier Tia <floss@jetm.me>, linux-bluetooth@vger.kernel.org,
 deren.wu@mediatek.com, mingyen.hsieh@mediatek.com,
 sean.wang@mediatek.com
In-Reply-To: CABBYNZJj0i2aNQdH2DXEnn+JBwNn+xkJU901vLFnnAzdtxtFDQ@mail.gmail.com
References: 177272816248.352280.12453518046823439297@jetm.me 20260305162928.5E8F11EA006C@mailuser.phl.internal CABBYNZJj0i2aNQdH2DXEnn+JBwNn+xkJU901vLFnnAzdtxtFDQ@mail.gmail.com
Message-Id: <20260305172817.3B8F51EA006B@mailuser.phl.internal>

Hi Luiz,

On Thu, Mar 5, 2026 Luiz Augusto von Dentz wrote:
> Ditto, we will probably some evidence this was actually tested on
> systems e.g. dmesg of the pre/post change, also in this case
> specifically we need a mediatek engineer to confim, with a
> Signed-off-by, that these changes works as intended.

Here is the dmesg evidence from my system (ASUS ROG Crosshair X870E
Hero, 0489:e13a, kernel 6.19.6).

Pre-patch (vanilla 6.19.6 btusb/btmtk, no MT6639 support):

  Bluetooth: hci0: Unsupported hardware variant (00006639)
  Bluetooth: hci0: Device setup failed (-22)

Post-patch (this series applied):

  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20250606201235
  Bluetooth: hci0: Device setup in 8287370 usecs
  Bluetooth: hci0: AOSP extensions version v1.00

bluetoothctl shows the controller is fully operational:

  Controller 78:46:5C:9B:C2:C2 (public)
    Manufacturer: 0x0046 (70)
    Name: jetm-rog-crosshair-hero-x870e
    Powered: yes

This has been tested on 6 different boards across multiple distros.
The DKMS package [1] has been the primary driver for all MT7927
Bluetooth users since January.

Deren, Mingyen, Sean - could you please review the btmtk changes in
this patch and provide a Signed-off-by or Reviewed-by if the
implementation looks correct? Luiz requires a MediaTek engineer to
confirm these changes work as intended before merging.

For context: the BT firmware (BT_RAM_CODE_MT6639_2_1_hdr.bin) was
extracted from MediaTek's mtkwlan.dat combo blob shipped in the ASUS
Windows driver package (V5603998). The extraction uses a Python script
that parses the container format and pulls out the BT firmware
section. The firmware has been submitted to linux-firmware as GitLab
MR !946 [2].

The driver changes (firmware naming, section filtering, persistence
skip, CONNV3 reset) were developed by studying the Windows driver USB
captures and the existing btmtk code paths for MT7925/MT7961.

[1] https://github.com/jetm/mediatek-mt7927-dkms
[2] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/946

Javier
