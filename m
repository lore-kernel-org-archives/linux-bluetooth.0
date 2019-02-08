Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE469C169C4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00332146E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="dAwZwPum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfBHPb4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:31:56 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:34635 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBHPb4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Feb 2019 10:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549639914;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=cpsYvbs8COhD5SNcqEoPIzfI8TFO/FSjRs4665s4P2g=;
        b=dAwZwPumUKNTNbwd5o0tRca1XQ3+kt1X4ImApIuin1ikWgGHqnGwwBCoZf/InLP1ZS
        MyyRFzadXXBhsQ4TkjQVZDnQyvQy9BTLBHA29eoCQbWVTZCd9zcJwCjA1rfM3ZQESJiS
        IoT3NrYxj2ArLlx3982XI6bX7qnjZYLdJ9+JU8lXDTVZF61UcTRQBFMnbVnItEpyLie5
        1wnVn2/YZ2yjfpmbbNm+gmx86aYlBWl2Rzymw9QyUPxpHFb1E+/AD29A71h4W069Z/MY
        59vY9oMa2Qe+fTIlqaB1qXEvBl2ozDL/jbP/Yc1ImfGqlCklTWbzT10dPGa4mXPHUvIO
        dVMw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPUekEaRuJYlK+4Zv6s2ratDZ+mCAH"
X-RZG-CLASS-ID: mo00
Received: from josua.mayer@jm0.eu
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id V028b8v18FPs0Ao
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 16:25:54 +0100 (CET)
Received: by josua.mayer@jm0.eu (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:25:53 +0100
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 1/3] bluetooth: 6lowpan: search for destination address in all peers
Date:   Fri,  8 Feb 2019 16:25:17 +0100
Message-Id: <20190208152519.16181-2-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208152519.16181-1-josua.mayer@jm0.eu>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Handle overlooked case where the target address is assigned to a peer
and neither route nor gateway exist.

For one peer, no checks are performed to see if it is meant to receive
packets for a given address.

As soon as there is a second peer however, checks are performed
to deal with routes and gatways for handling complex setups with
multiple hops to a target address.
This logic assumed that no route and no gatway imply that the
destination address can not be reached, which is false in case of a
direct peer.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9d79c7de234a..553dc719afde 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -187,10 +187,16 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	}
 
 	if (!rt) {
-		nexthop = &lowpan_cb(skb)->gw;
-
-		if (ipv6_addr_any(nexthop))
-			return NULL;
+		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
+			/* There is neither route nor gateway,
+			 * probably the destination is a direct peer.
+			 */
+			nexthop = daddr;
+		} else {
+			/* There is a known gateway
+			 */
+			nexthop = &lowpan_cb(skb)->gw;
+		}
 	} else {
 		nexthop = rt6_nexthop(rt, daddr);
 
-- 
2.20.1

