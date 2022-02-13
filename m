Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Feb 2022 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiBMVbE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Feb 2022 16:31:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiBMVbD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Feb 2022 16:31:03 -0500
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0EB53B64
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Feb 2022 13:30:56 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JMSHnpnUSSrXTJMSInbeiQ; Sun, 13 Feb 2022 22:30:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 22:30:54 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: No need to clear memory twice
Date:   Sun, 13 Feb 2022 22:30:47 +0100
Message-Id: <2f67f1c5ed7de38b78a296c798f3d4afe9e3bd63.1644787831.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

'peer_addr' is a structure embedded in 'struct lowpan_peer'. So there is no
need to explicitly call memset(0) on it. It is already zeroed by kzalloc()
when 'peer' is allocated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/bluetooth/6lowpan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 133d7ea063fb..8e8c07541153 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -641,7 +641,6 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 		return NULL;
 
 	peer->chan = chan;
-	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
 
 	baswap((void *)peer->lladdr, &chan->dst);
 
-- 
2.32.0

