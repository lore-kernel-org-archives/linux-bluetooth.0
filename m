Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782529ACD7
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286224; cv=none; b=dQIriqFNf6YB12aCjuA0yFcZ5urTyJTAKt1RjuDFOuCZVd6YaNF3MDXSrd/r943+E24zVU8ycMIaQdU6oZMtqUvVR4o7l8hDnsDbSWDjLEJI0pwoFTLpdK9y4Obaa3BAshOEn9EWDum7aWvTJTBMDEeGNnl35hpZ8Qyl8Tw1Y8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286224; c=relaxed/simple;
	bh=Oe43T+YW5lLrSQ0RKjPY8cyHfNpIXLUyRc7NcLTLbM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhjPKBeeTbcx1/BYNFcLPZZslTjW/W6HGRhqiSzeY25i09Ksm68g7tWnN0KDNn4AtAllxus8lOLX98X/wYlyYJ1euc9qeOBrxVpW4zxplSK4+usvA+o8W49fBzyjQ659cMam1oj7vamWcysIWHM1shoZeAhkSdkTjGFA4onRO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=EVDLeg1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3LskyNY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="EVDLeg1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3LskyNY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5706C140007D;
	Wed, 15 Apr 2026 16:50:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 15 Apr 2026 16:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776286222; x=1776372622; bh=Xv71GjvUlLU9kOGVnbLVQ
	f+xVk6z5fgU7NPenQsLNjk=; b=EVDLeg1pOC41bcUdej10MMFTGJrU0Deo0DouS
	KwNC8+MYWGcjiHatJ8APeRSEDKBxpe/RyDJ1I9umW2WJVyo1C270wRA7O/k2pY55
	jGbTgklIUOB0W8AKx5FhNeL5qVEvh3Nj5KvnERgTLn6dYtLduCfdJPAsnzAaexCy
	pBmYL26FNKSMJEYdvCUFN3rJ/hJCIask0JbL2VCOCT1nR6GlaTVD1DCo21w728xM
	LjzFBzd1hW5mFgd4X4nHb7pNr/xtJs9YsCjMTW6PQTnFwGnjdFFzzawWY6wPTQE4
	pPJvwIBT98IPJcsmwEyVSiGGPkPu0d9uqPo/dR/iG3TwrIbGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776286222; x=1776372622; bh=Xv71GjvUlLU9kOGVnbLVQf+xVk6z5fgU7NP
	enQsLNjk=; b=C3LskyNYsP1WYrgc/j1DMLH+PhDANHTgH30vWl6xyRcaDoXSRo/
	j63XnX5YwWUVwG3i9PKII+H+bHvPRpgg+OnyBJlPH65HPqSPV6yYfhooDY6Vwz7B
	5yyV6yVhHYpiDJdNDA49atiQ4iwY+2sw49sGBytx6+ZuCRorg3D6ziw1PV6VLdN1
	xG5tRAu+GLVV/h53PZgcsa47YBoyAEDpFWwAqvtHkC+eRURbGwSudmNLJ8C+EV+b
	r5r+AgVODOx/3ffeLC81KZAPZVqkYwdfD336F2C6nj1QWtRZraKZh14F5OWWy0pT
	RgLMm7nQfl6KwBFvnYmj0gD1ZxbpYWIhC1A==
X-ME-Sender: <xms:Dvrfaamzt3CNup2cbUevFagKx7ppMAQXS5Z5p0DONaTii5elsP6PCQ>
    <xme:DvrfaY0VnJr7BX501hnIuzwGPZ7FUBp_dnA_Eh0AKorl5TspEEp-B8GyknIvST7pw
    IC0Eki6Ib9wtO2pUNbQerYDCXGCJu7NXtr10JvpJ_SVM5nrSnLM7pA>
X-ME-Received: <xmr:Dvrfadrot6E6lM7Y8c9q-tkCyplVVf7sraBKIVT4TKnhdoo-ta4D-UJJdAFZY4PzUSSd9LM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeghedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepufhifigvihcukghhrghnghcuoehoshhssehfohhurhguihhmrdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeghedujefhtdelveeugeduffejffffvdfgfeeigfeujefftedv
    tedvuefgveffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehoshhssehfohhurhguihhmrdighiiipdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorh
    hgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehoshhssehfohhurhguihhmrdighiii
X-ME-Proxy: <xmx:DvrfadcOmqRzP_Jo-W8uAGtsevBsgw-p4EUYmfi6rBgJWMTdcM5FtA>
    <xmx:DvrfaUqxYkwdDHG9lSAsKd1KPQckfimHnfMg-qVU2A-iQ2yDVo2CQg>
    <xmx:DvrfaWFGHBwvSQ9HE_ssYuuDs_4PNuIySPUuXFzZsB3n5yBBtR_mcw>
    <xmx:DvrfacswnOaQYomNxjwiDddp7D-C8bUASMxqgcJcTQptyewfP3VeWw>
    <xmx:DvrfacYCLCaYdI-_C26nACMBuLncGxYlgmOdKQbGKN71dVfsansu1dNi>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 16:50:21 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v3] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
Date: Wed, 15 Apr 2026 16:49:59 -0400
Message-ID: <20260415205008.2365697-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the same NULL guard already present in
l2cap_sock_resume_cb() and l2cap_sock_ready_cb().

Fixes: 80808e431e1e ("Bluetooth: Add l2cap_chan_ops abstraction")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..8994e9c5d179 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1498,6 +1498,9 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
 
+	if (!parent)
+		return NULL;
+
 	lock_sock(parent);
 
 	/* Check for backlog size */
-- 
2.53.0

