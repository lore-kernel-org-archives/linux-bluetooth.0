Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B35C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818EC208CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCEP2r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:28:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52465 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEP2r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 10:28:47 -0500
Received: from localhost.localdomain (x59cc89fd.dyn.telefonica.de [89.204.137.253])
        by mail.holtmann.org (Postfix) with ESMTPSA id B5023CECED
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2020 16:38:12 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix calculation of SCO handle for packet processing
Date:   Thu,  5 Mar 2020 16:28:39 +0100
Message-Id: <20200305152839.92437-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When processing SCO packets, the handle is wrongly assumed as 16-bit
value. The actual size is 12-bits and the other 4-bits are used for
packet flags.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..6a88954e67c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4387,13 +4387,16 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr = (void *) skb->data;
 	struct hci_conn *conn;
-	__u16 handle;
+	__u16 handle, flags;
 
 	skb_pull(skb, HCI_SCO_HDR_SIZE);
 
 	handle = __le16_to_cpu(hdr->handle);
+	flags  = hci_flags(handle);
+	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x", hdev->name, skb->len, handle);
+	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
+	       handle, flags);
 
 	hdev->stat.sco_rx++;
 
-- 
2.24.1

