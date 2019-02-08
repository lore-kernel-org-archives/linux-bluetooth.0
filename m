Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D13C169C4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5443D2080F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="mEnfonLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBHPcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:32:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:30787 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfBHPcD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Feb 2019 10:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549639922;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DR5CkDKSWCvi6NwIWLOROk81ldMAQENH3NjLxMSRAdA=;
        b=mEnfonLcE5HSl7TqFANo6DTp0cdcys7M5MTAuF1CWfNX/WMLCkoVsePXkJZN8p3Brq
        3pKxjNL26dHpuijBqPc4/mAo7rENESc6uu0EBhyzdjr2PW4QxshiGt7wOwUT707d7HxK
        r3C1UvcPUwqN3Qh1I2CyaGHWHHpFiCCvMvcJFYEEGqaW0b5w8723TIzNpGRP39yfhvV4
        Ssc/0Y5T2Y5UjWMJPorMF5GDYClBHFGYnBRXg/vCVgOBkyeA/fk1pMve8sgAxmCDKcPU
        pQoTsVRqRScQ1YhoNQKUAWgxNYEExt2QDYP3iQuR334jQJm8u58bjBcft20FCQOJXAm8
        Nd8g==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPUekEaRuJYlK+4Zv6s2ratDZ+mCAH"
X-RZG-CLASS-ID: mo00
Received: from josua.mayer@jm0.eu
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id V028b8v18FQ00Ap
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 16:26:00 +0100 (CET)
Received: by josua.mayer@jm0.eu (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:26:00 +0100
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/3] bluetooth: 6lowpan: check neighbour table for SLAAC
Date:   Fri,  8 Feb 2019 16:25:18 +0100
Message-Id: <20190208152519.16181-3-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208152519.16181-1-josua.mayer@jm0.eu>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 553dc719afde..4e14db230793 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -171,6 +171,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	struct in6_addr *nexthop;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int count = atomic_read(&dev->peer_count);
+	struct neighbour *neigh;
 
 	BT_DBG("peers %d addr %pI6c rt %p", count, daddr, rt);
 
@@ -222,6 +223,19 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		}
 	}
 
+	// use the neighbout cache for matching addresses assigned by SLAAC
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
2.20.1

