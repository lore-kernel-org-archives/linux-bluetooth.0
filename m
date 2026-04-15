Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207A24A078
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286146; cv=none; b=jt9GCdy7wRwM2q7rKLYFFSzhetHrmTrtN9U1mod0Y6RhGlUtyIA/LH+3e4zZjaLN0Ga0pmCq2TCMDWt4P4FicfSi+NaG3hiVZ5LM7Iu2ns8hJuspPoaJEQxYn8NqcORg1ZAaSLAgkf2Lem2Vy/T4Y92qVWR9jtXekOqtyZPlqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286146; c=relaxed/simple;
	bh=U/IL/10Zyjh/ODAUq0O8i/nDReanLDf+z5x0kyp6l6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8NfjEs6fIswCtmsa+LgR6N56mzLVaQBr80eFsBVO/tYBUqsAt3/0PCgoyNTPi7RRzaMPqexaRtXp+eXBd5ryf40jOssKAh9lJO9Ub+WXpvjvg1eUreLe2pqF1CxWu1Vdzi/WuO54OuBYwlh4o4iw5aGdEtKhaXLUeyJ492/ebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=HpL/oN3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2/kuD9+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="HpL/oN3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2/kuD9+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDE5014000BB;
	Wed, 15 Apr 2026 16:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 16:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776286143; x=1776372543; bh=XXYgQHFB5Ia1g/3uCv3zW
	trmY2GLFjWR3ar3w9oK7mQ=; b=HpL/oN3kRVB7fBqjAWhFwI7ZJ+kdsefpmdTgY
	VtPmcE0Q1hrTnuJCx3lSrXGC4jiW5vcRGZxuu1g4QzieOcggipOiGzbOOh6igj/x
	1stHV6jxZ8mL9n4ZwIZ9+WinTUxQmNqpK53i/zqzXNjhlXU1J78MN7rm4af+GfPQ
	KmU3rhCMpynN3vdVoskC2yQlXrFfD1NMucI9LtR38TSYW72Vgv8p04k8fcpD+YU9
	BNc3F7aIBernJjSTDdoV25MmiZv1dBBEGd2R4Zu/HnwzpP3PIc0nIxNY7ICLJFE2
	9lNjxlcNb5s42owcWgKGqbV3zoXu9bFe4gplSfCnv114Wusyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776286143; x=1776372543; bh=XXYgQHFB5Ia1g/3uCv3zWtrmY2GLFjWR3ar
	3w9oK7mQ=; b=G2/kuD9+3CvZlVduvwDoc9e8KQNj7Zam8aAUV/dTWR25yOsENn2
	cpUCfgQutuWE7lNHvRRWu9VBdY2R/7A3h6zncRY6JXMBczeu4lAyH7R4WUHup7N8
	PENoXkpQE2uxAnclQukBoqlMXbCrKofB4k/WTln+KFsWqVn7g/6dWk7WnCXJunc6
	f8+TGbHN7W9E0hGRBozl/BN8ipHVi8O0ioJD+xSyxKugfenTBcQLNnEbQyiphmUC
	5LsrwMUf6kYDIT69Xz1h9uZfcyzdAk2jX1w+IGdN+AxaVFBbIZ88DHPh/slWPE84
	hm3n3uC/Kd7wn2D3EIzFhPXiBKlg6h0S0YA==
X-ME-Sender: <xms:v_nfafY-ElaxGHIBFyr4Jym4AQ9ddfjMgtz2G1hfix74cO6xYs6M0A>
    <xme:v_nfaVaTTMzoK_9k_2rU86CgbfWWjJOg3nypKquEw5CfLvugSsjtE_LkElHdKf1Pi
    nPNCpaMYpONYPH21LOFJ4gERCXbUthtmfL6cyWhFFm9M1unTIq5scem>
X-ME-Received: <xmr:v_nfaW8NLJ7lHFZpQ4aDbuISj_zz-PZMz5B41eIMb4u2jyi1mSnnr0e_J3UJ6lCXWfbb5Kg>
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
X-ME-Proxy: <xmx:v_nfaUiAR2qPSmtu6jM8EbOS7LaFBMEH2p09ztvshYm3uWCny9975g>
    <xmx:v_nfaWeEU90EsAG0UD5YBRfbHY1d5RGN76QZQ6HVN-hSKGlQWuhKIw>
    <xmx:v_nfabo3DvU23admFf3Yg9C8jIhVFFdF3KB-rlhwaxyXqrNiJkBOJw>
    <xmx:v_nfabDpgVBwx8gqlS0UyL2LMHU1H0E-ZTvM0kUVVXi1xwGXpHP4og>
    <xmx:v_nfafMUgd9l89XohaLG1BGd89jHwuQR3q3CnxE1Pp-J0aic02GnkhCX>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 16:49:03 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2 RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Wed, 15 Apr 2026 16:47:54 -0400
Message-ID: <20260415204842.2363950-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is released, the child
socket sk can be freed by another task.

Save the channel pointer into a local variable while the parent lock
is still held to prevent this.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..1625e4fc38d6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
+	struct l2cap_chan *child_chan;
 
 	lock_sock(parent);
 
@@ -1520,9 +1521,11 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk, false);
 
+	child_chan = l2cap_pi(sk)->chan;
+
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return child_chan;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
-- 
2.53.0

