Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57471C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 19:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbhLMTXm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbhLMTXj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 14:23:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B7C06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so14153150pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EDD/jxhe3EkPSnNelMwpELi0EojYuEBZHe+QDEAPMTE=;
        b=PTwSqhiucpSq3+ZBxxjMmBXfV3gy1mIlFJ1X9sCZm0rCTuqlSZ0w2lS+vG1VZsU1nz
         5kCjklP7IoLkeoD7Y23tSYhBjMcSDmDxy5F1CMuGKN8fFX0TGcsjdUDnPQ/X55qh5Z6H
         wAKz6p0lTWKdy1bxa//p5GzlbtaFI1s8bmm1rvZ2arXkwT7kCwbeJkeWFgl4QKo+fC+M
         2+jcvhsiRC7ha4k/QV2XATjhtiZbiODUfncpUGqT/DkzBXgv35Dnw+EuA74Y/ejAAK6R
         FEhpvplqEV6KnfujxK23Km1u3NNiRxBthTCq9sbpHPBKx5NcT96UHbxXP84vLkEC8FHg
         MAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDD/jxhe3EkPSnNelMwpELi0EojYuEBZHe+QDEAPMTE=;
        b=fIN/OwEfRoenfz3y6ttHgHE0sQ2eIeY2+h3RWcScToPIymP6n1qgyllb5bEOqPTPG/
         sjaa3FUvEAyRzxA/5FWY5jA1sBRtAWID7Xfmo7WRdqKKnBX0svw7uLHlSAeYtK7ivX6e
         jImEFyuH5+epmbDopSIAOHsSknNu/nSFy05/U2MGFxRPwanx1S9kjM4DxbDH83+ci1MV
         WO7A9r4vA/Z/gSFJ6iiN16PqjqP7TnNKabSY9EvhOJmx/NtwFeZDDAQ5F4ncCYnjhpvM
         9dwcC/hiuP8yVgv8R6y3NEugMwbwAT1komKW3KvS+B7srVvKWpYB2z4kLoAoYfjRnRMr
         CkSw==
X-Gm-Message-State: AOAM530VBfDgmagyYqv09EOf/XmBuqJ/Aua1o9/0nGnrSIBKAzYbj4pE
        AYy8qGZIhQyCdW9YFjMinHFn/Bx9uzE=
X-Google-Smtp-Source: ABdhPJxR0g/VfrMwGAJ34EJwMYHJ2E6GEjyTyG8cLt2ZIPC4zUJcph3gKNc/sqeeS/cWJ/zVPL0FEw==
X-Received: by 2002:a17:903:245:b0:143:c5ba:8bd8 with SMTP id j5-20020a170903024500b00143c5ba8bd8mr440182plh.64.1639423418059;
        Mon, 13 Dec 2021 11:23:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n71sm13512938pfd.50.2021.12.13.11.23.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:23:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: hci_sync: Add support for waiting specific LE subevents
Date:   Mon, 13 Dec 2021 11:23:33 -0800
Message-Id: <20211213192335.2024621-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213192335.2024621-1-luiz.dentz@gmail.com>
References: <20211213192335.2024621-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for waiting for specific LE subevents instead of
command status which may only indicate that the commands is in progress
and a different event is used to complete the operation.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_event.c         | 41 ++++++++++++++++++++-----------
 net/bluetooth/hci_sync.c          |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

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
index 7632f3a2a292..9151d70b36b0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4038,15 +4038,14 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 	 * (since for this kind of commands there will not be a command
 	 * complete event).
 	 */
-	if (ev->status ||
-	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->hci.req_event))
+	if (ev->status || (hdev->sent_cmd && !hci_skb_event(hdev->sent_cmd))) {
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
-
-	if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
-		bt_dev_err(hdev,
-			   "unexpected event for opcode 0x%4.4x", *opcode);
-		return;
+		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
+			bt_dev_err(hdev, "unexpected event for opcode 0x%4.4x",
+				   *opcode);
+			return;
+		}
 	}
 
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
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
index 19d9a95b305a..917652b67194 100644
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

