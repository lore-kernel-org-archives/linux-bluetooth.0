Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE40313522
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286344; cv=none; b=KajDQdyDGB2LzT8QMY9pE+OfW0DkI+MhGEUVPnbNYLTMha1oFpXYHUkMQQgdmexZnMNlDTtLHIPZszkQDwT4iK0d3cNPMBtvh913Gu+m09rlpXbAE8nbk0LAJy3xeTWRgT4tDqoq3RbVKCcGmVI0AhH4UeRy/U0xha0L7XEjE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286344; c=relaxed/simple;
	bh=/DbqZRe/i07gyWu0jzUubvMAQOJPPUKc54gs+8v5zdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuN1voPHFm3LpS4kk/+Kcuy1GSyPKeFefDF/55krCivtFJX8yKY9n0YDhpDruzE5s1UtI0FRH/GKV/7QBw6Jugldjl6ltqhUGF3yS8NRTdHGXGnTDr6vAhlpF79CEj2dti87AZLGmPeGYM3FU5mOQa/mlZ5NYa7vIXC5JUtIUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=kPNRhcCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIL2MhCx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="kPNRhcCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIL2MhCx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BF671400065;
	Wed, 15 Apr 2026 16:52:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 16:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776286342; x=1776372742; bh=2Npa2p+K4w8WbwOC9de1D
	yzkroLcD6J9wuu7wZi0HKI=; b=kPNRhcCxDrV8IneEs46RUnDRbIJeV7re5S5f4
	VMZETknNt/JVyCjoq6aTLt5MJaW3VY7/VJ7XSfb0ZDxsMi0QQjL8FCZATQWSw2pO
	Sd8qgBr0hal5x/T+QYZsiqwZpK0k7rIgrZ3JT9pgAQ47hSsbTxPJPEGl4O9R2t4D
	+pcIJtdMfMw07mvppY4KtXGIItW6mTUAYqzX9J24sY3idQnVzQ1F7l+18CiFDERu
	KvJJBrp6DBT5P/y1+Ur+bix/ny5nXO10J1KmmukDAiH1zbaqqNuilcWxx18b/quO
	ns9JnOM5S5kglSEELX6f6rr43p2jkkc+PBAJnbDv3obm/zDlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776286342; x=1776372742; bh=2Npa2p+K4w8WbwOC9de1DyzkroLcD6J9wuu
	7wZi0HKI=; b=WIL2MhCxeV9al6f1Dg7jO740LqeBboxqgVKfyQHp/FITKSK2KBZ
	Dmw+fa7mAexTP7BTl8TJKpVf7jtvIGgaRr1SazGeieTCDy5BqURGXsPkOsf7+uJn
	IokidE6HU+VpDcOp8aWpv2phkZQT66v4cOyXNBfTke3bu2WuiykWZU802TtcwO/Z
	kQB1HV48fiBB16mEpFoiO549Ey9WjpcgDYeuybe8wJiqXLb61IQ6aGBS6FkImbqs
	W7ft2+vDZYKNZ9MlL69wpl1PbdiV9MkRHUxQM+mcntmF8vMK0FlPlqb0Frvu1uSh
	+KYhIDGyEbApU1bUG5VT57el53pASxDNSjA==
X-ME-Sender: <xms:hvrfaaAO9tTxe01wqxyEFdlJM0n4kx95fV5-4IL211dXkwc_LUSLNw>
    <xme:hvrfabi6llw0x96KXdA3lro9OYYGdLCFDM6oyWN82Peiag_Rjovkpvr0f52ZUmbW4
    k0p04h_meDUw4NP8oD7Pkq_HO1QCmFsEVhoae1KvBwVrskFyYXLG_s>
X-ME-Received: <xmr:hvrfaSneePf4r4KLmYT9OrfcJq_Ni6eVSMW1vNilUqoaxjSRcay6r1x0pAiqtaqY3842aP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegheduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hvrfaXp7-yq4j35lToM3qV5mdT-MTVnCIusDMleI1Wn8y301SUpO3Q>
    <xmx:hvrfabFkvIs1_9pxdVVR3gvZFzL3U7nIwMKHVVgXRVvPpnsfP0lsHA>
    <xmx:hvrfaTwzcGHam2E1IuP80SYaDdBOoxQ26kChKpw7EPEZD5ujXPodQQ>
    <xmx:hvrfaQrMCBbux_eXHsWI7Iq-Jt0xyn4gMY_w41P0-HgbWvApVHpx2A>
    <xmx:hvrfaWymQMGhsIRvpfneCase_UOoB6lifahlCL9H_ObcehfyQ4urAN7E>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 16:52:21 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2 RESEND] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
Date: Wed, 15 Apr 2026 16:51:36 -0400
Message-ID: <20260415205205.2366630-1-oss@fourdim.xyz>
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

Fixes: 89bc500e41fc ("Bluetooth: Add state tracking to struct l2cap_chan")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..fb3cb70a5a39 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1657,6 +1657,9 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	sk->sk_state = state;
 
 	if (err)
-- 
2.53.0

