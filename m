Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331942E013
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519365; cv=none; b=GOeZXDGAviLsxHghcERPz18dSLP6OD0x9Qp0auh+eydT0PkR82Ieeya5TJ8Gsnh4kKIEuOmIGy2GmJKFQG9zOaVtobMZZ7Cpgk6M7VWj2L2Itloon99KSGstntkUwIp/FOSLefik23MRNZh4INtYplo/Eo4hpfRB0bBTQ1TK6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519365; c=relaxed/simple;
	bh=ThFSJGKh1BJqy0NFhD/6DxFuWQOhrqGvMzxjuaiy0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StLEQR5uVMhbGsnQTkwUzyIKP8Qt3ea72f3wtYD0pMKXYbsK6nvycdkbkxMCNVQDLG8UPCb/JRfL5ICMI85FS2NrnFJ+hjqQ22YYtV9eaBMu337y1w/dvSaEq3Ziis6AHhwy6lI3v/QqBgzkzObSdhOrFLD3GTrx7nSKe5jLqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=UDmvMdY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CA68jrhW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="UDmvMdY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CA68jrhW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35DE51400165;
	Mon, 11 May 2026 13:09:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 13:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1778519362; x=1778605762; bh=QTDShmGHesZCihxSDbtBp
	2At+wlwoVYr6ZYkHvdZ//w=; b=UDmvMdY4JcurhziFpmAb2Q/S8bWiuXGopp6UT
	tpu+MHd66ph3PRVdpIv30jgm1E11/4Ocpo7yBGv2RYUdYNQeHcGkbD515qIb+QSB
	TbhjnFv1M67gocLHJpKlkgBzExrVrRws1q1ntowPMQWPJwRM6dhgLBUo6C7N/ehc
	Da4ly2hMHsCjkEYDMCPRSHEEMt83M8cY/ryy7NuG50Hw/AKXqoSxGUkAz2lG9bag
	DN2+4dKVAlq7rUW6FNCkEB6D40M64CiMvqmedWkbuGbnp78b0paQXpV/4iJ1lxFR
	JPXnPjC342oRh5yGH8Yix6/7ZFnf7S82HnelbE3ZK49qvHgbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778519362; x=1778605762; bh=QTDShmGHesZCihxSDbtBp2At+wlwoVYr6ZY
	kHvdZ//w=; b=CA68jrhWvFBNqGIUeZchoYVHm5woG36n+IJ7rKp3ZfNViDVBzGK
	HJpBsG+Yrc/K7homntYGYofWt7mMm2ZqDM1TkMvtKgvUDW+cmzIwoBm0Jwt9ODZW
	mYdWYNCgwnBK0qmBVPFCka33gvuPAwUMuNwMniQbVoMLgocw27zbDpFFqKFhh7tb
	FBsf+brg8k/5Q7UBBZyAgv7TRyoQT1JVMQP+gCeaTosNSET864QB8/aBoU7Qz2F1
	oYHnEQm7cNXTsavSk4LGkKWLdsdwee8hvdIGT1Bs1UYUjESWASbGqqC7RNRQiJJM
	+A6Fxorg1zFG6RFbRJf9d7FtEBipbRuAAbg==
X-ME-Sender: <xms:Qg0CahwJtJJvlzIbgjNQvF_zoL6HmxshBskm7hZM2OyMtjjGFmqQqA>
    <xme:Qg0CaoTJ1UfsUc30pNuVr1kCCpXsSpP3Eal0ueL6hqybPnjHLcfEibU-hVyTb8Xtt
    Xj2BLaYZHi1L6BODYSGKuzNyheIUB_KPDpEI4FD0xIRicmTXbDNYk64>
X-ME-Received: <xmr:Qg0CagVzrVQEollCGGpIEwpHaKQohUpCbIZ4fQnVxi10MjyIi1lhMov6KgxIE-psCcsQrvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihiieqne
    cuggftrfgrthhtvghrnhepffefvdeuvdeggeehheekhfegvdeiheffkeeljeehieevffeh
    udekfeelhffgieefnecuffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhsshesfhhouhhrughi
    mhdrgiihiidpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehluhhiiidr
    uggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtoh
    hothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhr
    ughimhdrgiihii
X-ME-Proxy: <xmx:Qg0CaiaF7Bpcbd-zMVrt_LmFlKuHOoJVMW5BEniMCwOgsYl0mpnYAQ>
    <xmx:Qg0Cau0KnlZkBn07ZtpITIS-5xVap3fr8tLMjELWpKKiflDk7g8Czw>
    <xmx:Qg0CasjiLcbv9_IaBBQZDKklpegN70EdcwemkXDTDWaZG5MVxyrqjA>
    <xmx:Qg0CaqZSlKMkzoXLGMQZj8ff2QmhKVZd3675deZzgdobU3a3FNzlZA>
    <xmx:Qg0CalmZV92blTat6t6ZcXUr-YEvzRUFOKZsMIRKdnjkg5omBHWMe-pw>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 13:09:21 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH RESEND v4 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon, 11 May 2026 13:09:17 -0400
Message-ID: <20260511170929.709823-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addresses v2 comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .

Compared to v3, rebase against bluetooth-next.

Resend due to the missing version number.

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 net/bluetooth/6lowpan.c    |  5 +++++
 net/bluetooth/l2cap_core.c | 12 ++++++++++++
 net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
 net/bluetooth/smp.c        |  5 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.54.0

