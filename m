Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E731AA87
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286450; cv=none; b=lttiSaJvixsXXCIv7TWr0ByNlGclkJYlmyidE1Du7UhEJsX08R0i/+y9AsErhLLF0DQ2RbF8/YekavgwkGY5pKTu2AfXXARimQr+nvtTcttkIop1J4dYTTcrpWvHWdCY7r1y1vu3upcPRhbm6a7KswZ1SxqvkG5PZq2KmldmK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286450; c=relaxed/simple;
	bh=5LuKKDDYD18agFFUuW6IDj+eqiisvUfQDI0nXpezae4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNoRBrvZxWGfBd5nOnJGOaMX0yIVi7USjTZHGcSKfafyJDFlUf0xJoS7WWs80DK2j5spsWx5y6RueLwsMqo8QemBAWm+vCslpIJOFNwggwLuzhFS0abQFOzuhIe2jUGsTrmaIbRwVAGG7UzZsbRFzOy9p5cQa/gVoTLp8BO7bDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=p4Mloaei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLlUB48i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="p4Mloaei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLlUB48i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E44CEC00C6;
	Wed, 15 Apr 2026 16:54:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Apr 2026 16:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776286448; x=1776372848; bh=uXzKEhf3LHBF+X4lWGJH9
	IhU3L1pkW+Z5HQ6+JPO96s=; b=p4MloaeizDhGPmww5oJDMiHeaCUiOkOlI3AjG
	hb9ho4ZEDClf8X7aX7Gp14ctPvYxLZr/ls9VfgAzpfxuQuFQAKiQ7p9j7eLDK2od
	6aZNCElxwMoBjY07BumSOULJkIZsT2huy6ve7xOXPsmy8bXrfYVkOmcIVTUg5Hmm
	6wBAs1ZaFDyMWagOFcKoQuHR5z7R7PqQuY1oHD4LWwoa5zCN9VHVOdN/KjfYQUlS
	JJR7qe4jMYt2vUxwkdZDL9zL/NBtJNH+PAYeVGt7m9TLtBuYx1d4QoeTSyHVUFY9
	bRO+G+z/z+lYz+7tsarMS8GGLPNWkHxU8/pCqYO8AekYh8K6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776286448; x=1776372848; bh=uXzKEhf3LHBF+X4lWGJH9IhU3L1pkW+Z5HQ
	6+JPO96s=; b=lLlUB48i7PIzghdwF8xMQrpQxodF7vI4fT1ODpJ8v49trjiDxfA
	wkzPDUucIZ86m24p0Vj4OniLjnFqjFyk+Ny3q8/BVivxeGmly4DRBAnSXgw4rdPr
	1+pVbOmav0DQGiWBfrpXUohHn5R/oFSz28KjTWZrJD0O+Kf1atNv6TERV+LmggO/
	9ZVNV3Nz63QM5q14jT/enRay4d43AHvyss1xYUv4B4P5I/e+4gE4rW9DCeF3TTXG
	8jfP8ZOXtN9+JR0tZqxkl8IR3+c9Z91dv+A8ube9NrFlshw8CmO+H+CZJl1QqIbO
	ZWfpFrcmoXS+Ggmi28q8VFic5vbBpd+cDRA==
X-ME-Sender: <xms:8PrfaXguUcIkcq1abvGORNJihJu331vnGE3-bBT1ywSypioIbZ-Nxw>
    <xme:8PrfabBZH_Zytp4MlFM89I7if8NkvrhTBOowAitif_s_c9RMimwVGQVCUnbo-A7UX
    pRWiNAPJ7Znwrs3Qdq3orhgQEPDKrtQxcckLtf5B0YKGz3NCgxr7gU>
X-ME-Received: <xmr:8PrfacFdF7KgKE1i9rUBpA71ZCd9xRB6JysXh5JjX9eUC3nJkpX5C-HJpL2yr4_Y1QitdTs>
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
X-ME-Proxy: <xmx:8PrfaTJfOncjbGxjWH1GdeqTHBaz-vWrnoo6AhtArb01cp2bwNYqzQ>
    <xmx:8PrfaQmqugD5bTALYeW_2dDmp8ZDUp94Qhq-jkfmPRHEc-b5xEj82Q>
    <xmx:8PrfabTJIOFSJQoYvzmBcRN0gKQXcAnk_J-mrci1bdO0MhlyAXdLtw>
    <xmx:8PrfaSKtCOKmPDJ5ECetZJ8gaRcahIvI-oZHg4c_ZVq2CjqpKB8OSQ>
    <xmx:8PrfaWRSH-dPtYsw0KJ4SCbdo5-HBAqvXpf7PJkipqG20fINBm8HzJLS>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 16:54:07 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v3] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
Date: Wed, 15 Apr 2026 16:53:36 -0400
Message-ID: <20260415205344.2368172-1-oss@fourdim.xyz>
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

Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
Cc: stable@kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..ac48148a7628 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1758,6 +1758,9 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return 0;
+
 	return READ_ONCE(sk->sk_sndtimeo);
 }
 
-- 
2.53.0

