Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A551157A5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469508; cv=none; b=IWYLMNHUPdTYBvPCV9LRmc8y7vfFNKNWSZvKcfF/g0NWX5xQJOLTz6PyuVOnsTjrTt73JgfSFim3Kn3lf3hi4Bv34RiT6/JS8EMmzi2upsVtDHFgmAC6H1iW99uaa6o4oxt6iPp0A8b/7it3hbN3VPaRaEjhg42t9fHUZrcsBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469508; c=relaxed/simple;
	bh=joYMNc9VmsQ28H2lqpQjzthno2xPqRFvUXkzv7Orczk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raFY7KI/3DtksswLJ5W0C3cTIcbF7zPWFzOQJ7oeK/5Sic3JAldYO1BUrrzraE+J/iBjjhSKMJxOTyXEjL8InDpkat+xuqrxuUuYiGL0Ab+zi59IicEviVibOakD1JerDJeL2kQ6yryu8DAxqDCaejSsxxWEWE2dPfqghca4Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=R2MSrrPO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iK9J778G; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="R2MSrrPO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iK9J778G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 253E01400054;
	Sun, 10 May 2026 23:18:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 23:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1778469506; x=1778555906; bh=nE6Eknn/jw6ms3TEFBH71
	XelYTfNOYsuwhljfNOMSGQ=; b=R2MSrrPO7YBqWjj+e+9FpfdxKP3xlI8IyvYLX
	Ejf/0YUeBr/jLBSQthHkqNmpzDqvdc6HtVjJJzyIMqy2NqEzRwK5e/PLfD9CmfdP
	QdqBwfnPZOcQyykpgL1y+b0gJDeg/W/LupJEaviCjG/J5jUpgrag05v5yGpj59Ql
	MWix+zgd31BHIa9RemmLB3c09QBfuBdFNxfTSmB0xjxZD5Rqb/IAlWSAKGrvreaa
	R1UVJ4cSKAdMtw+ijEndrfKrJYPkWxWeVVrVIWFoUn/13mYEA1PD2KCO+uU1FMTl
	4k9NhnHz224m6UYEzjF/rUsTkks5MV+sOp85olOepNVOu7y0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778469506; x=1778555906; bh=nE6Eknn/jw6ms3TEFBH71XelYTfNOYsuwhl
	jfNOMSGQ=; b=iK9J778GXgg3Y8naJXCycU+BLBycrD0J1Xtuk/Xw5azly8wd/2a
	FaVOVmF4kg3MYPufyt2PMv4y9D4pXwzbW37+dZmxWpW1OFIMVyQY7dsm6On6dzTF
	w4hyl5kZ/A3xiOYXJDD8ckBBliuL89Ty4IDFk8QW2MiZcW+uPMaMXAN0bU2IolfB
	BGa5iUcY9UiaXn+3aBsXbtRMlV7cGDLvm8w5cNy/AvKWzigzQ78ctTysEJoe+Ewy
	z9yDtNPrldtk6vXbggDsUp8M3xHNxb3Yn3sMOWmROWJuO9kqd4+mt0dIhi6+SscJ
	njNmJ38neP7KEfASc3MB71i0GyGjKh/KBYA==
X-ME-Sender: <xms:gUoBavZbrbJDrxom0u3eJqKM51yUElumrjsqVs-GphRBtw4F68pA0g>
    <xme:gUoBalbsZVIEmvaQZ8cwNsTCBbxgtiUA3zXkuAhN7rc_mPe4wtL2LQjxHrRGQf-gC
    ZinnZL1RU0ag3BUvZ9yF3dt0CRyiIIqueO9tuwk9w1T06McWLIV7ps>
X-ME-Received: <xmr:gUoBam_y7IjIrVBV9-B2LPMJdbT4fQe_Cmy6S6K6agu8NIw59mwFmViKZI9QdFVQ8JqOTg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gUoBakgBJ8jU1IViX19xYRFvAO3m5CGgSzkd77FghzTj3y6g7TYybA>
    <xmx:gUoBamdxY486O6mU31hm-wkOGb3gtbdAlFfboYGO-ldo_0jwypdQFw>
    <xmx:gUoBarogxJDwuJp-bBrNMUo1tWMTy-7SpMM8OUw9-kzIGaPqPfemzA>
    <xmx:gUoBarAeTNi2MtqTb3oCYsrSOtry9SDlUnBA6VCj2rTPY_sVs6Gwgw>
    <xmx:gkoBavMRMecSmTFerjMZ7rPLK-axqqS3moQ45hqFByc4Y2h_aTvjmhe0>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 23:18:25 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Sun, 10 May 2026 23:18:25 -0400
Message-ID: <20260511031837.221778-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addresses v2 comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .


Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 net/bluetooth/6lowpan.c    |  5 +++++
 net/bluetooth/l2cap_core.c | 12 ++++++++++++
 net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
 net/bluetooth/smp.c        |  5 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.54.0

