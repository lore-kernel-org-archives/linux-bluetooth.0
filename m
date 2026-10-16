Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6F380FD8;
	Fri, 16 Oct 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162999; cv=none; b=rKWJESJQwz9dwto2kpNx3Bp8f1Jvfrk0xJMNZPoeqJuMbSPDKQzbcgfRBnZ7X0GugTvdAGLvrLR1wDWEyJH437OWNRR+/HDIXxi1I4J1AIBNHDCzB3hDd4JzEFfTI6BKiRcRC2bDd4ZIAg6+rP0N00s/Rua3956YpL4m2AC6fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162999; c=relaxed/simple;
	bh=2UCkk5QZd7OOvOW11MLETXp/Fl4/q3WV2UWxag3avQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb7G0tCnpuNzkrGHAxLhKknWjJULCF+ieDKGmQnIC1qDRvtNXwBaSZ6MdE7X6mfoJ6CMo7PJtzt6GGhP5NdSBXB/zINcOFy1hVxDIzyrGvFIKixyAfXM7aADOjZp8w7aPCxmVEdAovh8ape8sX161BjGbzIGam+t137wYTbGhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMnXZB47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMnXZB47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048941F000C4;
	Fri, 16 Oct 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792162998;
	bh=K5PoK08sZA1feeJziuilvtUVG7diIo9fmGgdCNu9PfU=;
	h=From:To:Cc:Subject:Date;
	b=KMnXZB479u1GZMwCFg0sWesYngWp+h8BqqMWhTTaHrJggsTGK1xcEuxZ7SEKpFDHW
	 dwVKbbn1KYzs1zODYk2G3bJteeIGRw/8yOOqZ6ROYRQ43Cixm2PJ6MCzugO6C5MMZD
	 +r6RqKiLZkpfSPgmMKesSLeUKsBS6Y26XiWhgPtCcnCUJNbyivYnb4GxWvkX2yMeUi
	 FxrG0d97AgblvE8YTDeXk1Z9t8/lBCp2xGgnSSw6CHH+LgDpDgeTzIU6fsHeOqJGha
	 qgBNxQyZdpXSDHY5jDSrlVZ40j1eEJCyEtkGp74oYYW5/hjvLFYiSNKIl3H3tgY7hU
	 5C6A+XT2uz3rQ==
From: Eric Dumazet <edumazet@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH -next] Bluetooth: hci_nokia: use skb_put_padto()
Date: Fri, 16 Oct 2026 17:03:14 +0200
Message-ID: <20261016150314.2832131-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_pad() does not change skb->len, callers have to follow it
with skb_put(), which is error prone.

Use skb_put_padto() instead of the open-coded sequence in
nokia_enqueue().

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Part of a medium term plan to get rid of skb_pad(), source of many mistakes.

 drivers/bluetooth/hci_nokia.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index be2923231e7128350156bd77ed3cd426c4b31b24..2866d4b54a537ba71a1c602d170debb3d2a697f4 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -531,12 +531,9 @@ static int nokia_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 
 	/* Packets must be word aligned */
-	if (skb->len % 2) {
-		err = skb_pad(skb, 1);
-		if (err)
-			return err;
-		skb_put(skb, 1);
-	}
+	err = skb_put_padto(skb, round_up(skb->len, 2));
+	if (err)
+		return err;
 
 	skb_queue_tail(&btdev->txq, skb);
 
-- 
2.53.0

