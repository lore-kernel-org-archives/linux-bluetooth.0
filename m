Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 May 2022 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiEUULc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 May 2022 16:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbiEUULM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 May 2022 16:11:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38494A1BC
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 May 2022 13:11:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nsVRI-0006Q8-7B; Sat, 21 May 2022 22:11:04 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nsVRI-003kpD-Kr; Sat, 21 May 2022 22:11:03 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nsVRG-001mMv-8g; Sat, 21 May 2022 22:11:02 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: use hci_skb_event() helper
Date:   Sat, 21 May 2022 22:10:50 +0200
Message-Id: <20220521201050.424197-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This instance is the only opencoded version of the macro, so have it
follow suit.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 net/bluetooth/hci_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 42c8047a9897..73b32be03698 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -261,7 +261,7 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 	if (skb_queue_empty(&req->cmd_q))
 		bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
 
-	bt_cb(skb)->hci.req_event = event;
+	hci_skb_event(skb) = event;
 
 	skb_queue_tail(&req->cmd_q, skb);
 }
-- 
2.30.2

