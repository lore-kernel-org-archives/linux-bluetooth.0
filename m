Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE70C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhLJAfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 19:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhLJAfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 19:35:38 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1FC061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 16:32:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i12so6963606pfd.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=awxVejejYa4M45g7dTtJJ9+n442lL5xwOEbuskHk9E4=;
        b=Rcq+Suxnrca6aE9sfGw6uGtcSe92/Vva6+//+Ng3lTMX4MJ0ezwdp/U5GY+x2n7r6g
         WEm363Sd3VB0X8KvM7jcyrWZAlX3iGQPBMeRa9kASNZ6fACjLKN8SshXZVzsG3yRW0Qf
         TdFDqK+4wWpqjEfsk7ukCks41UQfA5CBOlGDy/6RG4hokV81LAipm7QQaK3dAVjSZl0V
         70F8+xIFjJTyoeFGkebPFIIzz3IKp3G9rkJYi5/FIWAs34Soi7PiyTlR5k5BRksZSFj0
         Nggz+XqLLv/CSwZlJ8y/plUG6tZePIP8fSAWJ+HoOmbjL70vUHNK17hkhEN3DO82bdg3
         pJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awxVejejYa4M45g7dTtJJ9+n442lL5xwOEbuskHk9E4=;
        b=w4Ly+ONliVQzJAFQv1sFJFnS7uwyVeOpYwD7+olkD5r2odkQmDtQPnLX6Q/R0+6IoY
         R3qZYc3xV145Rm+14SMMTGdRl3c7zF5lj5xTz0MlOOPQ8D0yOnQv/1XvrMT3+HbjvES9
         yp+QtjLUO46C0o8H9po3/8L9kM/As8Z9eVrVKa0Q99ftMLhmZOd9AJtZKtOV5lqbUY+9
         a3klaiycwZFO0p9JSRugj+kjtEIMeMUtWKutjyEETK0BwRQcFpWWDgGeEvQefg2U4q85
         JcKYZ9fNWgCoMU/HdHdv0bj8J9v7OBDbYkROSVroiejFy8zKICQ9mTwSaBFb0MAhry1/
         XJnQ==
X-Gm-Message-State: AOAM53011WTVw4szCMpRUdTkrcOZI8WqdiOHli2GY/FhpdwMcLUPvMFC
        sJzGi3pcyWq4Q0LYhC/Loq2YMZBACH4=
X-Google-Smtp-Source: ABdhPJwhU3r4gwxkaZiqFHraqg4rQrGYwQIWlzjrpLt9rew5BEvBuev+6LL5gAAkT0f798lt56liPA==
X-Received: by 2002:a63:b60e:: with SMTP id j14mr36681250pgf.554.1639096323626;
        Thu, 09 Dec 2021 16:32:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t130sm745502pgc.9.2021.12.09.16.32.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:32:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: hci_sync: Add support for waiting specific LE subevents
Date:   Thu,  9 Dec 2021 16:32:00 -0800
Message-Id: <20211210003201.836706-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211210003201.836706-1-luiz.dentz@gmail.com>
References: <20211210003201.836706-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for waiting for specific LE subevents instead of
waiting for the command status which may only indicate that the commands
in in progress and a different event is used to complete the operation.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_event.c         | 31 +++++++++++++++++++++----------
 net/bluetooth/hci_sync.c          |  2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 77906832353f..4b3d0b16c185 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -412,6 +412,7 @@ struct bt_skb_cb {
 #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
 #define hci_skb_expect(skb) bt_cb((skb))->expect
 #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
+#define hci_skb_event(skb) bt_cb((skb))->hci.req_event
 #define hci_skb_sk(skb) bt_cb((skb))->hci.sk
 
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c15289b59c3c..6f6bdca4b9c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4038,8 +4038,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 	 * (since for this kind of commands there will not be a command
 	 * complete event).
 	 */
-	if (ev->status ||
-	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->hci.req_event))
+	if (ev->status || (hdev->sent_cmd && !hci_skb_event(hdev->sent_cmd)))
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 
@@ -6448,13 +6447,24 @@ static const struct hci_le_ev {
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb, u16 *opcode, u8 *status,
+			    hci_req_complete_t *req_complete,
+			    hci_req_complete_skb_t *req_complete_skb)
 {
 	struct hci_ev_le_meta *ev = data;
 	const struct hci_le_ev *subev;
 
 	bt_dev_dbg(hdev, "subevent 0x%2.2x", ev->subevent);
 
+	/* Only match event if command OGF is for LE */
+	if (hdev->sent_cmd &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) == 0x08 &&
+	    hci_skb_event(hdev->sent_cmd) == ev->subevent) {
+		*opcode = hci_skb_opcode(hdev->sent_cmd);
+		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
+				     req_complete_skb);
+	}
+
 	subev = &hci_le_ev_table[ev->subevent];
 	if (!subev->func)
 		return;
@@ -6748,8 +6758,8 @@ static const struct hci_ev {
 	HCI_EV(HCI_EV_REMOTE_HOST_FEATURES, hci_remote_host_features_evt,
 	       sizeof(struct hci_ev_remote_host_features)),
 	/* [0x3e = HCI_EV_LE_META] */
-	HCI_EV_VL(HCI_EV_LE_META, hci_le_meta_evt,
-		  sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
+	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
+		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
 #if IS_ENABLED(CONFIG_BT_HS)
 	/* [0x40 = HCI_EV_PHY_LINK_COMPLETE] */
 	HCI_EV(HCI_EV_PHY_LINK_COMPLETE, hci_phy_link_complete_evt,
@@ -6833,11 +6843,12 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
-	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
-		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
-		opcode = __le16_to_cpu(cmd_hdr->opcode);
-		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
-				     &req_complete_skb);
+	/* Only match event if command OGF is not for LE */
+	if (hdev->sent_cmd &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) != 0x08 &&
+	    hci_skb_event(hdev->sent_cmd) == event) {
+		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
+				     status, &req_complete, &req_complete_skb);
 		req_evt = event;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 57a96a66f007..8d732725b380 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -103,7 +103,7 @@ static void hci_cmd_sync_add(struct hci_request *req, u16 opcode, u32 plen,
 	if (skb_queue_empty(&req->cmd_q))
 		bt_cb(skb)->hci.req_flags |= HCI_REQ_START;
 
-	bt_cb(skb)->hci.req_event = event;
+	hci_skb_event(skb) = event;
 
 	skb_queue_tail(&req->cmd_q, skb);
 }
-- 
2.33.1

