Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD1C169C4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94C92080F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="BGtEI/Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfBHPcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:32:18 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:14207 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfBHPcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Feb 2019 10:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549639936;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=q6JZbzYzrMEGL1rIsc6G7eJvbRGjHamdfuMVzsxW1s0=;
        b=BGtEI/MzyZ/ObxOuFmYX7//qG9MPC1v2EuPY2mzzWm0GaM4WIZo7sH10R9TXRhvfBX
        eJ5kP9lPpsVKlxtZj7e3dW7WnBBeplAU1uVng/0kJIUdXkrigapfyIWB2yxe7kFzeP/I
        /csJADndF1W2qCCcklsW2uPHHiHXtVqOUYQRwHDKTkB08bi017nUyfABXMXj5J1IIQFz
        C0tFWgox171a1pup5hauqFAJxOPLuQUH4PXtNlwq0/0g2mC+7rmp9Ic9hnmGtfW8Ep/s
        kvUaZmrge3qcIkJEn5mtcMTf1lXABle56GNEKCXa9rcuuVU9E+Gdm8OfLb2LsRXkbkDH
        GKKw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPUekEaRuJYlK+4Zv6s2ratDZ+mCAH"
X-RZG-CLASS-ID: mo00
Received: from josua.mayer@jm0.eu
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id V028b8v18FQ30Ar
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 16:26:03 +0100 (CET)
Received: by josua.mayer@jm0.eu (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:26:03 +0100
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3/3] bluetooth: 6lowpan: always check destination address
Date:   Fri,  8 Feb 2019 16:25:19 +0100
Message-Id: <20190208152519.16181-4-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208152519.16181-1-josua.mayer@jm0.eu>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BLE based 6LoWPAN networks are highly constrained in bandwidth.
Do not take a short-cut, always check if the destination address is
known to belong to a peer.

As a side-effect this also removes any behavioral differences between
one, and two or more connected peers.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e14db230793..62b57d3bc0c0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -175,18 +175,6 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 
 	BT_DBG("peers %d addr %pI6c rt %p", count, daddr, rt);
 
-	/* If we have multiple 6lowpan peers, then check where we should
-	 * send the packet. If only one peer exists, then we can send the
-	 * packet right away.
-	 */
-	if (count == 1) {
-		rcu_read_lock();
-		peer = list_first_or_null_rcu(&dev->peers, struct lowpan_peer,
-					      list);
-		rcu_read_unlock();
-		return peer;
-	}
-
 	if (!rt) {
 		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
 			/* There is neither route nor gateway,
-- 
2.20.1

