Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A2C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB127611CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhDOIuC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:50:02 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53137 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhDOIuB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Apr 2021 04:50:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UVdfbcR_1618476570;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVdfbcR_1618476570)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:49:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] Bluetooth: 6lowpan: remove unused function
Date:   Thu, 15 Apr 2021 16:49:28 +0800
Message-Id: <1618476568-117243-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the following clang warning:

net/bluetooth/6lowpan.c:913:20: warning: unused function 'bdaddr_type'
[-Wunused-function].

net/bluetooth/6lowpan.c:106:35: warning: unused function
'peer_lookup_ba' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/bluetooth/6lowpan.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cff4944..49c2612 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -103,34 +103,6 @@ static inline bool peer_del(struct lowpan_btle_dev *dev,
 	return false;
 }
 
-static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_btle_dev *dev,
-						 bdaddr_t *ba, __u8 type)
-{
-	struct lowpan_peer *peer;
-
-	BT_DBG("peers %d addr %pMR type %d", atomic_read(&dev->peer_count),
-	       ba, type);
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(peer, &dev->peers, list) {
-		BT_DBG("dst addr %pMR dst type %d",
-		       &peer->chan->dst, peer->chan->dst_type);
-
-		if (bacmp(&peer->chan->dst, ba))
-			continue;
-
-		if (type == peer->chan->dst_type) {
-			rcu_read_unlock();
-			return peer;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
 static inline struct lowpan_peer *
 __peer_lookup_chan(struct lowpan_btle_dev *dev, struct l2cap_chan *chan)
 {
@@ -910,14 +882,6 @@ static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 	.set_shutdown		= l2cap_chan_no_set_shutdown,
 };
 
-static inline __u8 bdaddr_type(__u8 type)
-{
-	if (type == ADDR_LE_DEV_PUBLIC)
-		return BDADDR_LE_PUBLIC;
-	else
-		return BDADDR_LE_RANDOM;
-}
-
 static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 {
 	struct l2cap_chan *chan;
-- 
1.8.3.1

