Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F8CC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68BB214AE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 19:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="nKejQAWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfCLTSO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:18:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:24720 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCLTSN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 15:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552418292;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VPnYja39JbhBn6kM9obMLX4zwg5ShrmuKUc2vKNGe1c=;
        b=nKejQAWv6J0lgQ+1Y98gSeMpopNkcs2XG8LK6kGFyQqQ794naOD6FKARX3HWwzIHU+
        Tjlkmu+jGb51i0XZ8NFIHQmGyK8zXZjDMifaUjbhUXC2VNEUTb1C9jYA5YkWiXC6l9Fr
        F7NOGa9xkJCcuvYFWJLMQ2aCqpc5NrqpHNrTn9r8yDzNaC4wPt5FBcmmj5+09vUbKRus
        AdYaMA6M1XAffv1YCOHrUJrAiH46ktTm1/M+i+IhhzIJuqD2NIBHDIdlU0rXPDHuvJrV
        LJLhuKi5nuKWHkas1IxYvnHs8tls5wKLCrOyH0wpxPI4/AeBh+Wxmb7HRLRkjlPEXxOZ
        IwzA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBarUSiWB4vmvjrsnNVyh"
X-RZG-CLASS-ID: mo00
Received: from unipc-suse.lan
        by smtp.strato.de (RZmta 44.13 DYNA|AUTH)
        with ESMTPSA id u08fcfv2CJH3xaB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Mar 2019 20:17:03 +0100 (CET)
From:   Josua Mayer <josua.mayer@jm0.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Michael Scott <mike@foundries.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 3/3] bluetooth: 6lowpan: always check destination address
Date:   Tue, 12 Mar 2019 20:16:25 +0100
Message-Id: <20190312191626.20634-4-josua.mayer@jm0.eu>
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

BLE based 6LoWPAN networks are highly constrained in bandwidth.
Do not take a short-cut, always check if the destination address is
known to belong to a peer.

As a side-effect this also removes any behavioral differences between
one, and two or more connected peers.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 net/bluetooth/6lowpan.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 29a4f3d65348..0f64e9ef1a3a 100644
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
2.21.0

