Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582F366567
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294058; cv=none; b=fl239kSb/tebr02tkiIIkEACsuZcw4yAqt9N5IrJbHLkMu37HVcb93BvZLPPTP06oA6B0G3LUeqGqD4LdfG1wgTBEbhWiwduONv1ZguNMAzH8pax6vvHUiFlNWLVJmMTTatXryQOt8dV11/IE3OWubn/Gj+yIjEuU/r5FCQyswc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294058; c=relaxed/simple;
	bh=GhvRNVAvAzN0ZOdNodfAGXQblo48hOBfTbE76rO0r5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCsy+Dh+CJOfDsV6dVSAitmtbT0LyElsqa8sUMdqKK0YBybTZlfnAExeqvvxQQWrgOViwhnDoQfAMnpYA3j6X4bzxOrh2I48TummuU6lILIw0TFddpoG6yCOO/YqKeaK5Ty2b3JkbAbybozCGPWuphpCM0eZtX5KK5nQUn6UIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=IOi0K+y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bopOEwEp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="IOi0K+y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bopOEwEp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 15ABE1D000D5;
	Wed, 20 May 2026 12:20:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 12:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1779294054; x=1779380454; bh=W7EoR2WsdW3eDcA+wqkCe
	UXaz/RpCLrQCsMa9E4CJY8=; b=IOi0K+y2MgoFgl1eHN517dT1ICeT6duOFBBzZ
	4na0SyesEiPkmcfusS+Mbbp3w9rENrvI0FwpskJWnCvlVeJdKbf8vgFY5o9zKQDP
	JXH27FDqPO9XrMI4lrSDTEiHLPJc1gIoQaKGXP8F15D5FSyZm41o514LI6yNWyGH
	fAVCG2uURkO259jELI5cWScQgu0dkZYELL1ktmtwVKylQporPunsC3lSSaDtLiGt
	gthEp/SFq2r0JIA5lFe7CMzlevbsBJn+gUnc88/zYvBJPMhLvwf2c0Dy5VYljiSA
	kxIxl6NlZF5IILOeYDxRixyqIkqOIxn5IP7oSjtNpsiX3MoOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779294054; x=1779380454; bh=W7EoR2WsdW3eDcA+wqkCeUXaz/RpCLrQCsM
	a9E4CJY8=; b=bopOEwEprNA6enVrG089ev2g6rpYM67PZGGlxV7y5UjRJ05U0AL
	lotp8etZMArPbe3vKXObKWDm1/Vfy+9IbBLLojSLsaluziKBcRnIEWhikkjja42T
	KDor7SU3QmYEHSsM1Bbr5hpfLjUnQTzkaoEUFArR0ibGILarTirKkxUHzIzD3/rd
	Be3CZlGx+Kh6s4syeinSH8clOGTohHhBHNd07jqDQPGwNxA9k+83uZU9oILT62AG
	Ue0l5QfWlhTxPVxZ0aPUehjctK+31FJfXqsjbX2ncuyq4tWcDuPR9BCaQFh5e17U
	b/TRw3OrjHv0vOW5ezTLljT+Vvb0xiPImZQ==
X-ME-Sender: <xms:Zt8NausZfkonbOc3y-7j5rPQoZAi2WvH0bSpsf6tVGmL0pJXJXJtcA>
    <xme:Zt8NaqfrzBS-PRL0WKkrI1ZHz0bcdY3gfOuaDBzbPKHl3sAgVpClSouRgpfE6KQCI
    NyCUt5-pJfOfIDMEnD2gwlEIoIF5ozRG5b1zaKT568HBuK7bE71R-4>
X-ME-Received: <xmr:Zt8Nauxt1nSo7ZLyl4vZV3fdpUZ_Yxsie8-y-qqkFG0WIsBbUwIYLmfGAJceItyPTnPSGhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehuddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Zt8NaoHjvjwe7ruMBdlUyrQwxuU3QoUrd4kUDrzxz4pHGieFUE32uA>
    <xmx:Zt8Naqz52aM5QBjEZubRfd6R0WxjvtrWs_XtsFo2aZdLpJWcxyRnNA>
    <xmx:Zt8NahskRjtxFM5iKdJianSkGAR2VfyywOU8lcRb-GxEPh-ijVNuMg>
    <xmx:Zt8Nav20HHwtzUhmiOT_jQthGnNjMu-DLAV2GWbdgIGp8sxg0jHqWw>
    <xmx:Zt8NasglTq_PicMtbKRlK1sVDlJ7oN50jWii6RQ9fQVZN1ALqzhdwrA->
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 12:20:54 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v5 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Wed, 20 May 2026 12:20:09 -0400
Message-ID: <20260520162030.2842543-1-oss@fourdim.xyz>
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

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  8 +++--
 net/bluetooth/6lowpan.c       | 14 ++++-----
 net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-------
 net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
 net/bluetooth/smp.c           | 13 +++-----
 5 files changed, 91 insertions(+), 50 deletions(-)

-- 
2.54.0

