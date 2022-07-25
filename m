Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101AC43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 06:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiGYGxu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiGYGxd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:33 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055AC11C0B
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 23:53:29 -0700 (PDT)
Received: (qmail 23557 invoked by uid 990); 25 Jul 2022 06:53:27 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Soenke Huster <soenke.huster@eknoes.de>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH Resend] Bluetooth: virtio_bt: Use skb_put to set length
Date:   Mon, 25 Jul 2022 08:53:15 +0200
Message-Id: <20220725065316.6942-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-2.923892) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -0.023892
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Mon, 25 Jul 2022 08:53:26 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

By using skb_put we ensure that skb->tail is set
correctly. Currently, skb->tail is always zero, which
leads to errors, such as the following page fault in
rfcomm_recv_frame:

    BUG: unable to handle page fault for address: ffffed1021de29ff
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)

Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
 drivers/bluetooth/virtio_bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..fd281d439505 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb->len = len;
+	skb_put(skb, len);
 	virtbt_rx_handle(vbt, skb);
 
 	if (virtbt_add_inbuf(vbt) < 0)
-- 
2.36.1

