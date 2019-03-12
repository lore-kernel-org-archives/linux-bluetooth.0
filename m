Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AAC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AAB2077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="JezAqx13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfCLTTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:19:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:14761 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCLTTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 15:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552418379;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NBCi+0Ng7AfggJLsadd7N3Ce1LysjwEvZj5V3vQZ1ig=;
        b=JezAqx13G7sFVUbHBg0gNGlrZ2H9ou3Olvs1LJ8nPciBJTEgkpJR6NYOHJOdTmoe8Q
        yEFF1xy6wZTsbyD6iJUpQZz7Kf684U73zalz/3+dclF24ix9tLOZdcgvYB3J+0hc+HGE
        9czgY8n9HTBW0ZgZaXqf1tlXBBBCDcnDDHCOoNek8u5hzwcNrHVr2EXtlXW11/fuEz3w
        QcIy0q9FNuTAXwhzvSJBgUWnZxXuNuSaXMv69M8XtsfgH4hyaOGE/Q9K8M6rJc1nlQXy
        yQ6wI13TxUZpjNlPwiqhHR9fpIcINgY4+nLhgnlI3whm1HwUdsHjIDDXOKiSbj6KURwx
        2ciw==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBarUSiWB4vmvjrsnNVyh"
X-RZG-CLASS-ID: mo00
Received: from unipc-suse.lan
        by smtp.strato.de (RZmta 44.13 DYNA|AUTH)
        with ESMTPSA id u08fcfv2CJH2xaA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Mar 2019 20:17:02 +0100 (CET)
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Michael Scott <mike@foundries.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 2/3] bluetooth: 6lowpan: check neighbour table for SLAAC
Date:   Tue, 12 Mar 2019 20:16:24 +0100
Message-Id: <20190312191626.20634-3-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312191626.20634-1-josua.mayer@jm0.eu>
References: <20190208152519.16181-1-josua.mayer@jm0.eu>
 <20190312191626.20634-1-josua.mayer@jm0.eu>
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

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50530561da98..29a4f3d65348 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -171,6 +171,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	struct in6_addr *nexthop;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	int count = atomic_read(&dev->peer_count);
+	struct neighbour *neigh;
 
 	BT_DBG("peers %d addr %pI6c rt %p", count, daddr, rt);
 
@@ -222,6 +223,20 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		}
 	}
 
+	/* use the neighbour cache for matching addresses assigned by SLAAC
+	 */
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
2.21.0

