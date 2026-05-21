Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A452BDC32
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330685; cv=none; b=K+OJV++ZdjxWBevAqa3B5/ctbuyXLqyP/xjYniOvd+cX8uxMF1YZfnTFj8AtWmo/iMH6b2K3LtdxQ747rFkkY/EsGJtotp/NpPB24ZQ7UB0jP1CIKkSAUibVaGc4HhFjxuW3JM6eOnxLLErSeRmpVF6H3nLQRQIT9i9DSwuGmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330685; c=relaxed/simple;
	bh=8tVG0Rsy1ooaqIHWZZLJdVLiFTrCEXTvl4lkECweKbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/0klGJYtHZ6y0qOCO9tV8cMhOKVywX0Tk1OKgK9Gooj6Asy5uCYU4i7ltBx7ytk1qtjGbjpbq3powfLy2aVXlkCurmqfZnjjs3IszAR60XKlZnkMbOc98/cGs4zQ5jXnqx/Hn6//tzYOU9bsm/nMH/hAx+XheZScACyAJcyiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=V7WVBbhr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxrT4i70; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="V7WVBbhr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxrT4i70"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BF27EEC00AD;
	Wed, 20 May 2026 22:31:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 22:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1779330677; x=1779417077; bh=U9AQ8Sj0X/k6TNOl8gQ99
	DBJlkktlMzzHjfVT0Qojfw=; b=V7WVBbhrA/+sAOFSIk5j2H5UPXwSHjCMAxSUP
	kHPMd9vjlOJ3CBfbiBAp+HI4l++exmHgrTQ8zVUAyVuXzg8uJyRGJY6FPWpat5tw
	HoXxKZdSQkF3tvtPtOJ0FNlo5uH4wUGMPRAEB0moMR3DU+ZxlFj/ML71HZpMdCcp
	u9xQSumtHkeru7rSC24DbncMjhHJgF+0KSMNCgfKz7WqgAQgyyHqHmdZz4AhO931
	ytnS44jH/HoEzSwchz2z6MaeJqgQRqclUayguvE0HU+jOv/YlNs65pLto52+gEXw
	LXx2P4DG/6x3QFKbWeM9DFr5s3QrXVL+eS4zDBALDSmwJ24ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779330677; x=1779417077; bh=U9AQ8Sj0X/k6TNOl8gQ99DBJlkktlMzzHjf
	VT0Qojfw=; b=qxrT4i70oXJUuyoY+idAcub11UbB2ag2wOX6nCe17X+GNOU1LK8
	NOz+oFNmx/GQqk0fyppO1sf7atXXhDGN9+3VF7TrcC1tWtYTkIrMJJS8RUrdY9b/
	QAvLfSSQdkCvBmWrosky+lbgLswWkeF+ezPxrhKOKLkvzinmNCITZ9O7v3LO83ny
	nSxtgat9yCiQZPs0n10zAeKuHauzNeIPJPDCsoJGek2gggQqWaaFMWF9Qfrg9CWv
	k86OeERx1RA9T0cDl7wYSxYR+/Cswe6y/ndOSp8dHB7rdYckv466q6ENLub7cT8b
	GWB8Uy6h2pnM3PjLCz9EeFC1nXEQoEpQBeQ==
X-ME-Sender: <xms:dW4OaixaPUGdi6_I-WJAKRZKyVZX_87eC3bxv9D91PMhUWTtNsrUSQ>
    <xme:dW4OalSt4ZF4HoOAutyI0hSYX88fiM8Zzlz3yY3d-PPTwp4YQuEeAVnqZIFGmoaoI
    F2yip50ogCc9pKkgNzugDOu59Af9k7bhpSfSeWouZ8LgCSTFbLzIHbp>
X-ME-Received: <xmr:dW4OapVSKu535b6PsFpmPRsGnNfj4xi0d8YiBpFNha0q8OIGaSm60V4QsMjLgzqNY_4r64o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgeehudejhfdtleevueegudffjeffffdvgfefiefgueejffet
    vdetvdeugfevffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdroh
    hrghdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphht
    thhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepohhsshesfhhouhhrughimhdrgiihii
X-ME-Proxy: <xmx:dW4OanYVs56vAdEEA3kVISQw2KcnCf6ww2QrO-XG5IHzv_lOUK3QgQ>
    <xmx:dW4Oav1ckUEpRcAdKWBOdFJ7q_CaxlAqmCjS_GGp2Uo90Slg5ad-wA>
    <xmx:dW4OapgzQvJHXngKFQ2K6lMs1Ieyljn1AWzCfHEO_f9NcckTllNrCQ>
    <xmx:dW4OajablYiechgyogoTJuKVE6HFEXSf1mu_uWfnBkbAKOCnbLvhng>
    <xmx:dW4Oamlw2Eoz9YQp2aFGM7hBzxmGICQXMm5bXLGZ0MEqSIDxBiSB-tcc>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 22:31:17 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH] Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
Date: Wed, 20 May 2026 22:30:36 -0400
Message-ID: <20260521023055.3272712-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__set_chan_timer() takes a l2cap_chan reference via l2cap_chan_hold()
before scheduling the delayed work.  The normal path in
l2cap_chan_timeout() drops this reference with l2cap_chan_put() at the
end, but the early return when chan->conn is NULL skips the put,
leaking the reference.

Add the missing l2cap_chan_put() before the early return.

Fixes: adf0398cee86 ("Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..5668c92b3f58 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn)
+	if (!conn) {
+		l2cap_chan_put(chan);
 		return;
+	}
 
 	mutex_lock(&conn->lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
-- 
2.54.0

