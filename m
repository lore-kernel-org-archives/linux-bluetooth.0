Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69D36308D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295182; cv=none; b=B42azrCKnd3ZoYXsvf8PjhxfkY0wLkhnBNDECgq6hse9OA3jaZKy/nEWtm0k1TWe1+eBinyjrBg4wp6h+rjajQeeB+88sWuF18Dv72f63KhAmX7/CAB5VmTG4gCLFs7mwIlIhLQO/MK6uyeIrYdEOlqqUzLaJZwGC5x6Kctg57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295182; c=relaxed/simple;
	bh=hPgvA/x2eYXtKJFQm6D5ukNoB84emVi5Php01kVT4FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSstcAPhE0+4C8ehp9Ve9rW0ec+j3LtFcezx2f4YYNxdgFwxKZzyLBQxiwW4WyYjqrWP/DXpEgAM+q2VqaUbd9D+NkGzKZq7VcggbQhbcBLJhlbaLAqnpQL6S0KkV/SP1NwlCuVNWDKqcFxSMH8PA+6wU0HR3NZ3+htX++1gBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=gK0rBskE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4hc2YHZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="gK0rBskE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4hc2YHZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DF0E1D000AE;
	Wed, 20 May 2026 12:39:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 12:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1779295178; x=1779381578; bh=Wn
	1Vbk8XFpqVt9BAPZDsEQDMB0kvcvJkKMJ+fbxhKyc=; b=gK0rBskE1/DzB5lQYN
	YgpnM2nuaTmRnQKl0i2wR8d3TV0OCjPXq5QELAtpu3xTx/8hoSMLqUoJmwO8YqMC
	I+oe14xWBpuHQLlKJsdDo5bmSzUnfLr9xYbom2pDOK/jnuQFNAUCC1JhHbAbOh9R
	xwIHDTtsiXMyg5EXiGd5GO0g8BV4WAMVrzdFC/y7Ut+Ff1tXRIesl1bfGsRsGuKC
	dq3Bl0yiaB5JmfR9OyyB2S7b2xd7UExxWX6x+qzpLTZ2ME9OtQBBEG7ct/afqfj6
	oHrnm/8ia72tscP7iTtkJwqG4IZox/QJmSV7dKtric3No5iAPjbHwu7DgcWQ7sgS
	EmVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779295178; x=1779381578; bh=Wn1Vbk8XFpqVt9BAPZDsEQDMB0kv
	cvJkKMJ+fbxhKyc=; b=u4hc2YHZgOi0OVBSNpYNwKTGvDsNjBgKwod7ZJVDYiEl
	xix4qQ/m89B8WDZ01xikmD0SBXYg8dXkTcbFJDOifA3EcRUQG79S6fOUgoIHfwyT
	NngbrzxmLVi3IzCMbBBoKbSGlv+MMhzun2J3rF2E0DTmEq43DDM4nlvBsIFFh9LK
	HrfpNNgh2XWOwcLVjLVWcbiofgc/KnNwrZXiIQevHgZThYuiT5g3g895LFl+GTfV
	P/OFK+v7hLIn8y20/aIDKmgEq40rS7eX+pQdkV11yNt0dEWXFk4mkdoR6vmo7JTJ
	lyVZyf1luFl0Jhs5SZQB0VI2hc2oDpOybvmkXlsDKg==
X-ME-Sender: <xms:yeMNanR28Y-a3UCe2peJX-wQSf97X66NAJSvNdhdsSKR419VHaGqJw>
    <xme:yeMNavqNWCDyYM4JyL06jyoGprZ_oDZF6TruDWvCJm2w8ePaPLFOIvuAy_4dS6Yxi
    M29CKF5RcAV7svJsGMgnMTnmnKhpiJ-w0NXqSECFBUq0Zxgtg7ETSU>
X-ME-Received: <xmr:yeMNalKizaYEvAaEYOhDY81FCh_aPwvZbCABiN69K0d_P7FFKhJApqLh7_z5iwBow2-O5i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepufhifigvihcukghhrghnghcuoehoshhssehfohhurhguihhmrdighiiiqe
    enucggtffrrghtthgvrhhnpeeuhedviefhfeektdeugfejhfekieeluedutdekudfhgfdv
    gfegleeikefhjeeiteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhsshesfhhouhhrughi
    mhdrgiihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehluhhiiidr
    uggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtoh
    hothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrfhgrrdhkrghr
    rghkuhhssehsvggtuhhnnhhigidrtghomhdprhgtphhtthhopehoshhssehfohhurhguih
    hmrdighiii
X-ME-Proxy: <xmx:yeMNairznAoPuY9y6aTAN5hJuqwedXLVseoMYI8cZNlF1sDWNUnzbQ>
    <xmx:yeMNatwBGVOrqqte8wentYuNZwGbMmti8edyn1hBIY0vihE-L2ycew>
    <xmx:yeMNamPMHVyxLQm-0cho5iaUQ8EzP4f6ISBdIJ1EgwFNrCeDxZve3Q>
    <xmx:yeMNai5Azpm-hw88X3IZZdr-BJMS-yrAgCYQw1f10Vwj8d58WdjQkA>
    <xmx:yuMNapD0BFP-zBuTbRshvpt1X17YGJ3Hihin18bP7zajoosmdCdmh-cB>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 12:39:37 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	=?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v7 RESEND 0/1] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_cleanup_listen()
Date: Wed, 20 May 2026 12:38:16 -0400
Message-ID: <20260520163859.2859782-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bluetooth maintainers,

A public patch covering the same UAF in l2cap_sock_cleanup_listen() was posted to linux-bluetooth on April 28 
by Safa Karakuş. v4 is here:

https://lore.kernel.org/linux-bluetooth/AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM/

I thanks for Safa's report and patch. I already reported the same issue privately to the maintainers in 
April 11th. The public patch breaks the embargo and I would like to resend my patch here.

Safa's v4 closes the sk-lifetime hole (sock_hold inside bt_accept_dequeue) but does not take conn->lock around
l2cap_chan_close, so the conn->chan_l list-corruption race in my report is still open after it.

My patch closes both: it drops the parent sk_lock, acquires conn->lock → chan->lock in the established order
to serialize the chan_l mutation, and re-takes the parent sk_lock before returning.

Crash stack and C reproducers are available upon request, only for the maintainers.

Maintainers can also refer to the email thread [Bug] KASAN: slab-use-after-free Read in l2cap_security_cfm
sent to security@kernel.org on April 11th for more details.

Detailed Timeline:

April 11th: I privately reported the issue to the maintainers and security@kernel.org
April 12th: Patch v1
April 13th: Patch v2
April 13th: Patch v3
April 14th: Patch v4
April 15th: Patch v5
May 2nd: Patch v6
May 2nd: Patch v7
May 20th: Resend v7 with a cover letter

Best,
Siwei

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix slab-use-after-free in
    l2cap_sock_cleanup_listen()

 net/bluetooth/l2cap_sock.c | 57 ++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 8 deletions(-)

-- 
2.54.0

