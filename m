Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601581ACA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475079; cv=none; b=lw7aR8hv5ZIpG4kgKmJr9WfLCVl9qzpKG0n+t6qTYFpodCNvaGj9OtRORoWqVBVLFxrrYB4tw6uChvO/3zoJ6pRSEcPPsNZB7i55kNUjCQQaLpcJWVX2DqSefgCDZTVx0qbJ31jceOyLUoC1vorFR6iXL1Fft2xtK0FaMRkWdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475079; c=relaxed/simple;
	bh=RnH6wI8AZi7PRTMjYPV4pbJDBTl1/wdidIPOCs39Lpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxvauIB3VaX+1nTzBO8dDOImGHk472XF4bMmJhxXboI3raMiTvdik0iT7Mdvz1roNqNxjlHjyO1QSusxc17lI0KFQ1q5YdaRvbV4JLnU1mOGKDTEmcMhtYoTmjgO9P9meWnEl9lZUoIMWGO9WqCGh9+hZnQ10SztT2s0i7bU1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=o/OKEvOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iF7y6SmX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="o/OKEvOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iF7y6SmX"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 61479EC0073;
	Mon, 11 May 2026 00:51:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 11 May 2026 00:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1778475077; x=1778561477; bh=gDQ0YHr1h6qIQK4+iqt1Y
	lLPEKVlcSacu5ozhRgy1t0=; b=o/OKEvOuphCoF3xDdZlBxJJr4rUky+fZR/KoO
	YZV+vjCeFSHjigVZ47takzYfEbwliaoBZKR64MKAvzxYdw4ZzsjaiXqh8GfKvOn2
	vtGmKQBWSjS0IH151kScA5SYVus8NzkdCgBN/L38ZyKhFyppIFkSX52CQLl8hN/F
	tNfuYadiSlmUJoKQkbNlo62/5iH/cAFVi8PkCYI7LTr0DlDFbq/16eBwd3iF72GX
	2haWcJgiRIg1EuTb2reRKmN0QnBZGXDjqQX9WCz4JQTn6OAW51yC8YiYZ6ZNglKK
	SD4R5hc0Gq/qFuP/j6EIzmtImeakmR4oK/QdJCmnEUXKM5ZOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778475077; x=1778561477; bh=gDQ0YHr1h6qIQK4+iqt1YlLPEKVlcSacu5o
	zhRgy1t0=; b=iF7y6SmX4s/yyjPsHOp+y1wwZvZYP86eMnlhunGlNPesZz2HT8m
	GUjd62+6Vjw0Dx0lgaMfIaIX086fLqQmhuz3aCto+fLVMceybVhEClNDALi2BK2v
	QAiX3DarEK8FFvrNhu0N5c26QcoLNChnxS+No4ekk590WB9c2GMNza7IlS3w98xQ
	raG/3ospagBbbn4E80t/0FNFmfQA/Irty4j27Uy9rhZY63IMxoLPv0M9mt1PJjYk
	qOixJot5YwMzcD91VReTutnQyk80sMRwgkVCe/yvYFL1zv6jmPGUqRdvMTsbFs57
	5hVg5xkjwD+QziG28BKxuDbUhWYd4JodMJQ==
X-ME-Sender: <xms:RWABaj4N-5atYzjB8yXm8wOCFA9TYkZ0doCCAzj9LJP0WaHqErxWWA>
    <xme:RWABav4XITNikrtrHxJJnq-dDyNtRuR7cs49MCEZJUM-TPJVuCFAzFuWiQqqLYSP9
    jzZsxYZdtBgwFUaM2437zpSxxyPPbf4kVv369Ox3MVflQQPYnayglU>
X-ME-Received: <xmr:RWABavd4t1BAXZ160AltxAOlu4cDB9hy9j3ZX3qrHyi5FDzmHoT_1Pp9Vbha0Yo99ClN4Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudektdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RWABajB5oMPc-dcvghJPhd_fhuv9u3iXc5V8N32kU2w_4PQ4HBoO0w>
    <xmx:RWABai_vtX26YhxZ66BqR320EXrajgnF5ThzXVf9YQT6l7ngigfu5Q>
    <xmx:RWABauJeRYvViswDwLfb82w1MakIop2S_6HqdZ7QHwd-2h3mELOMAg>
    <xmx:RWABariFC5ztvLnMyBWnjcXJ9rvWvGzhv1RI70-YUZjL9Ow4S6F2gw>
    <xmx:RWABajtOw_zB7_smiXotqZzzZJdqiVp96-lpzgMqFi4g9HCemT5p2h7s>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 00:51:16 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon, 11 May 2026 00:51:06 -0400
Message-ID: <20260511045124.298319-1-oss@fourdim.xyz>
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

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 net/bluetooth/6lowpan.c    |  5 +++++
 net/bluetooth/l2cap_core.c | 12 ++++++++++++
 net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
 net/bluetooth/smp.c        |  5 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.54.0

