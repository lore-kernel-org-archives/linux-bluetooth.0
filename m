Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A41C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F532077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="Uug0WbKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCLTTo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:19:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27528 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCLTTo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 15:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552418382;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=++VWi84BcXU48qYaO1o2vAghdfGqt0P0JjQUALyDE+0=;
        b=Uug0WbKm8JnlmAHktGN6CoCZwhBI+sZH8f33CgSDS/2zhTrxgmTjEQA4PsSDglOkgp
        PKGxN6h+U+Aqltk75IeVCQBdJHZWRkhFTSwpsIft29kZoZAk+CFklxSbCLR8DmW7ag/V
        UoT/J2ajzMwTIkrIyyFNLTN1tvlskOb0AUqmkKa/bliAhQ/sp/4Sc5CGTx2YieOOOe7N
        MpHigH3Hqdf94HRq6uh+eHXLCMOZrAjKerYFmR27+1a44prhhEfAFcdkwEsJjnUlM69K
        Cn3ZSEJgts4duUzOMhtdJXx8AgEJDwnkL4K8c7Ip8KmU+8UyurED8POZ+HKsmoRhEcuu
        o9qA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBarUSiWB4vmvjrsnNVyh"
X-RZG-CLASS-ID: mo00
Received: from unipc-suse.lan
        by smtp.strato.de (RZmta 44.13 DYNA|AUTH)
        with ESMTPSA id u08fcfv2CJGwxa9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Mar 2019 20:16:58 +0100 (CET)
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Michael Scott <mike@foundries.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 1/3] bluetooth: 6lowpan: search for destination address in all peers
Date:   Tue, 12 Mar 2019 20:16:23 +0100
Message-Id: <20190312191626.20634-2-josua.mayer@jm0.eu>
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

Handle overlooked case where the target address is assigned to a peer
and neither route nor gateway exist.

For one peer, no checks are performed to see if it is meant to receive
packets for a given address.

As soon as there is a second peer however, checks are performed
to deal with routes and gateways for handling complex setups with
multiple hops to a target address.
This logic assumed that no route and no gateway imply that the
destination address can not be reached, which is false in case of a
direct peer.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index a7cd23f00bde..50530561da98 100644
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
2.21.0

