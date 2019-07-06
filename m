Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A266C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30DF20665
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="qCvircq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGFQBG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:01:06 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:12436 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGFQBG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562428864;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=c3KOiJkj+iG2POPwSV2BV+Z/scTGBMqLoRx7+hQm97Y=;
        b=qCvircq4DVmglsMSZd25lOoNHX4/8wmMEOYhd9vpTD+c6P/XLRinCXlPXTzg4bP8XV
        v8QnoZtxHnl8OiKtSIGgloVpfbYnFbrscbKWJiecbrFUAC0TwCs821VcIlwtx/d7fgiV
        TEHHF4A0M+P8WCzdpKZr2toxLeGVnqCSA1noleM7qPKtmlv5pTVUHVoWIu8jLhmjD3X2
        Mmth23BK0yu5WsP71t+LotfvYAN8LePn91xhfELgVgI04wHr29SMfP0B3kLKbrOyEVRH
        I80P0jCJ/TMzZhcpJPngj+nuw2q7Cwv0QK98gjfNTKlR2kRhDZ5d3RWwLVM8c/6KF0mN
        UgSQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBaXaSiaF5/mu26zWKwNU"
X-RZG-CLASS-ID: mo00
Received: from linux-1tvp.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v66Fsx6Oz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 6 Jul 2019 17:54:59 +0200 (CEST)
From:   josua.mayer@jm0.eu
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 2/3] bluetooth: 6lowpan: check neighbour table for SLAAC
Date:   Sat,  6 Jul 2019 17:54:47 +0200
Message-Id: <20190706155448.13382-3-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190706155448.13382-1-josua.mayer@jm0.eu>
References: <20190706155448.13382-1-josua.mayer@jm0.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer@jm0.eu>

Like any IPv6 capable device, 6LNs can have multiple addresses assigned
using SLAAC and made known through neighbour advertisements.
After checking the destination address against all peers link-local
addresses, consult the neighbour cache for additional known addresses.

RFC7668 defines the scope of Neighbor Advertisements in Section 3.2.3:
1. "A Bluetooth LE 6LN MUST NOT register its link-local address"
2. "A Bluetooth LE 6LN MUST register its non-link-local addresses with
the 6LBR by sending Neighbor Solicitation (NS) messages ..."

Due to these constranits both the link-local addresses tracked in the
list of 6lowpan peers, and the neighbour cache have to be used when
identifying the 6lowpan peer for a destination address.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9001bf331d56..f4e548e7b985 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -164,6 +164,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	int count = atomic_read(&dev->peer_count);
 	const struct in6_addr *nexthop;
 	struct lowpan_peer *peer;
+	struct neighbour *neigh;
 
 	BT_DBG("peers %d addr %pI6c rt %p", count, daddr, rt);
 
@@ -215,6 +216,20 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		}
 	}
 
+	/* use the neighbour cache for matching addresses assigned by SLAAC
+	*/
+	neigh = __ipv6_neigh_lookup(dev->netdev, nexthop);
+	if (neigh) {
+		list_for_each_entry_rcu(peer, &dev->peers, list) {
+			if (!memcmp(neigh->ha, peer->lladdr, ETH_ALEN)) {
+				neigh_release(neigh);
+				rcu_read_unlock();
+				return peer;
+			}
+		}
+		neigh_release(neigh);
+	}
+
 	rcu_read_unlock();
 
 	return NULL;
-- 
2.16.4

