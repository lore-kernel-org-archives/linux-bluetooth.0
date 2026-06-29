Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1014305057
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741073; cv=none; b=tEiDLgRejoKaoDzJ8xWCCF3EBK3aUJcLdKlsLYn9II3/YoHpDopozIMiLksslm8UD82A5D8CFfktN+Mnto1j/1qxH1sUXBVgVszVNfp4fj/hntDSLS/NP4vpXBaPjBlk3S1j7GOFzu9FtfQFsT64LFuQbaaRaWKzpO89HqPzVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741073; c=relaxed/simple;
	bh=aOasvWeVtyoaYrqHzmJFcm8Hs9hOETEvjwaNulTBTpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCKF/CQDn4SgiQ46JIcyHpVrc31KQ20MuogzkhpnzAlLFOgL4UGL7hOvc7/Y6roiy0cTPGypP9+Nk/FKIxB9ds1nMiUdd4YFrTnPVgM0rOQGDSLM7MVs9axnVJ1CVG5IWoZrmAAnI3eLWDpk1qqpBbJmMPyOhI3jAP5cHwPISkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=j0I604ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YeDH7eGK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="j0I604ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeDH7eGK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D41B3EC01A2;
	Mon, 29 Jun 2026 09:51:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Jun 2026 09:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1782741070; x=1782827470; bh=hF0lrpdOBou7i12Pkt3Vw
	qWQGq4Yqy21eMb/mk+8Jdk=; b=j0I604ovQJrmARjZBHSi/BSntlUkdy6a6Ou3i
	jh9Hj5t/wR39b0ZAXM6v/PI1KTwMwZgaIdV7rzpuHwBHJWpLg1MRGSLtfO7p1d80
	g/otAe5irz42Rt3W50wMICNU/cqgOgXGB8rjPKyzg811U+wwv77WDl4EumAIrul0
	7MFHIHB5uzA7qqelfdbGgH+z0zFD5Wbjygl5ucmCo6X8Y4noxcDNfcfnNSqzZMYy
	joIpGnT+bQugbSjTtrORgZmv0kMN4gaXsDKG6rwfzJgCDrN21yrUADcwLr4UBcss
	VzOl5dXfuXBEiLtWWLoc041smWJ5EW1YW7gGZh10yoRfr/vog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782741070; x=1782827470; bh=hF0lrpdOBou7i12Pkt3VwqWQGq4Yqy21eMb
	/mk+8Jdk=; b=YeDH7eGKaAMnWeMJe4wtsRxZz1DIV6hfkZfxXN9Ou2mGjtgh/ZC
	hkcg+lC5VENeGKWJcZbylF+9C/Y5y2vN1Fkr0t9oDGxafwtbjqPXUWstb0/tgB0v
	bHu6VbTsr3lr27NX97f+ygMs1z3T0joRulSe+oWmgy+Xn7wBAiPaHN2saSq0pB9O
	qNxJDXm9yTuuScyVi9vqV1Zkr8X08i0Z25b2vqqC9pNFMiyRt+egFFGK5ju6PKUD
	BgH2Em136ngJUQSJi1C6DFvG6lBakFZPFjk0A9BV9IuCaTzfG34iwMK9Az4UqtEx
	WgVnCrMNo7uy2rlPquN9aI5/GhsrIxXHdQw==
X-ME-Sender: <xms:TnhCao_6ANIXDyLXeXXYFRme-z6QZNEavsuzlGwVfB1BINET_-319Q>
    <xme:TnhCaoIgLftYV-fSfDGoP8VszyKgF6ngxNq-Y8Fm_1yUWE86MRbOEsHbM5Qhavaul
    y5fioKprhj9td734FCSKWfYIp4EgUdXephIT0WRlZ8jLKMaAArE-DE>
X-ME-Received: <xmr:TnhCararwWWC3_yOv2YPB70BYzbg5K8ABwpEwIDX6dqV9PI04rCKC8LDKzgt0X0PUYTWILo>
X-ME-Proxy-Cause: dmFkZTGf5P+HyuLHoiF1KQ560xJ+b1SWNKpPzcRY9mIvULmE9iePn4ie25NlU/tN5YHd+w
    J3dfcGUBGZwy5oA9TpLEd9cumNhp95nlm68UgaPlxhLudcvlkMpQ5nRIYn2SSt5MAB/fEP
    aLse3PniYSjAkYQe3uKgY8VNALNW3lvskogZxRZuYFQ3iMBbd3t6ylHXZtLBU6knsXEMIv
    EFpM/2jrJ01i7horagCh9imLj3pITwJKxW0UBpWspZGvSm1U6xGt2M5PAFdsy6ZtHChhjg
    iifFprmwodWgZPEq09KqqjzEE0Hid+aLP7ek6hcMDIWVUrjrFgW0kCbWUWQffRRtyk6vjn
    Fo41TVnsVngCA/qqs7YA4MJDUR4LFpa4LkpkHs94RI+t14Y66jDidaJlgaM41ASgc6F9UW
    02Vl6GXGsflrJCHMpqR1YmOlCTilZeGC8El8ZRfbxC8gMVDVuQ85wwAZx7y5y6B1iQj5uH
    fDUSk+DoMwy+CP0gTZQ4ngul8huQZ3LTBelNFukBNsPYCxGX6LpIU77goDr2cKBBLC0EIJ
    jiffXsmNt5nnS3HX/MoHM/W8DJRfnDlIX9se+Ov/gKETPv5jZ+bpaTNT+L+nKoyAAn1Amf
    SiWOk4XspWxqdi9mh+5uhQM+V2Lp3kzhX909e2IkM1cN7Z2Q7dF6bkTIijtQ
X-ME-Proxy: <xmx:TnhCaiIkTly3QjKtO4YZvHQ9EC8e8kJJCR9GvHOUv_8e1RDIVtzxnQ>
    <xmx:TnhCahBqdbe7JPPHxD5ShPEn9r9ZXAKc9wYWVNTkEdRTdtgixky2Ww>
    <xmx:TnhCavoJmktdJGYL_F7yKa2GoFvMnZrabbNchxbkzsKMbXx9r0GT8g>
    <xmx:TnhCakjl1wFdui95gZ5Z7LosdhQQ9EpI-j4Q6s7cOO6L5f80XLk8yg>
    <xmx:TnhCakLBFWdUCc3EApp4fxYJuRpF8Sib3xAaS7a-8Qo9L6e_BbW_IIpE>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 09:51:10 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v12 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon, 29 Jun 2026 09:49:57 -0400
Message-ID: <20260629135044.2302753-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to v2, addresses comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .

Compared to v3, rebase against bluetooth-next.

Compared to v4, allocate the channel outside the function and pass it in as an argument to avoid the use-after-free.

Compared to v5, extract the channel init to a separate function.

Compared to v6, balance puts and holds on chans.

Compared to v7, rebase against bluetooth-next and refactor the chan refcounting.

Compared to v8, adopt the philosophy of one assignment one reference. Make refcounting easier to follow.

Compared to v9, rework on l2cap_chan_set_defaults so that new chan's default comes from pchan and
can be used by __l2cap_chan_add.

Compared to v10, rebase against bluetooth-next.

Compared to v11, rebase against bluetooth-next.

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  10 ++--
 net/bluetooth/6lowpan.c       |  18 +-----
 net/bluetooth/l2cap_core.c    |  78 ++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 103 ++++++++++++++++------------------
 net/bluetooth/smp.c           |  27 ++-------
 5 files changed, 127 insertions(+), 109 deletions(-)

-- 
2.54.0

