Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF50C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EB620665
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="MSWkI28h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfGFQBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:01:00 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:22032 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGFQBA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 12:01:00 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jul 2019 12:00:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562428858;
        s=strato-dkim-0002; d=jm0.eu;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OXj6KRhUsG6EBfcR/v95Lx1R9sdG8aD9r1PIplsG9HY=;
        b=MSWkI28hFICRJTi7fDqL3TUyj/Ckks5ZRtZ530496m7qjR5sc2bDkP0df3MrSPpg/0
        URD2j+ZlU63XdZIXGVS3A6nWQhdzfEIHbivWzurFOy2znw8fx1OTbdmjkrxZSah/D2I/
        VYS8vEaRMgMjNpFJ9Nz+oDPD8q4cZRGU6JSVFnNoW9OlDnpnnsD/Oc61ob7HroiHIKxh
        3Gw7SFtGscQnls+AIW1DucVqeij+CNhkbj1CpyJHkIL3Zeo3ycD/Da3/2KQg83jzXgpG
        0uawcSC8Eyru5upLSieWTC5FvqiPgq49nqnMyWuWZjA44jCNedgKbwAxMbBUQllTayUI
        QpDg==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPWe8EZQbw/dDJ/fVPBaXaSiaF5/mu26zWKwNU"
X-RZG-CLASS-ID: mo00
Received: from linux-1tvp.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v66Fsx6P0
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 6 Jul 2019 17:54:59 +0200 (CEST)
From:   josua.mayer@jm0.eu
To:     linux-bluetooth@vger.kernel.org
Cc:     Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 3/3] bluetooth: 6lowpan: always check destination address
Date:   Sat,  6 Jul 2019 17:54:48 +0200
Message-Id: <20190706155448.13382-4-josua.mayer@jm0.eu>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190706155448.13382-1-josua.mayer@jm0.eu>
References: <20190706155448.13382-1-josua.mayer@jm0.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Josua Mayer <josua.mayer@jm0.eu>

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
index f4e548e7b985..9d41de1ec90f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -168,18 +168,6 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 
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
2.16.4

