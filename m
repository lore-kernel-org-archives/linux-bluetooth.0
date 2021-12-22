Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F632C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbhLVUWF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbhLVUWF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:22:05 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0130C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:04 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v11so3368159pfu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iixqtCE8mSUlr+WU/acbaYSkS3dqv9ZutjCvmeMVbTg=;
        b=jVDsbZDa1gQTwLwJ0OX12lI7KuCNFH69H/L4clFZ8aprh7dWA6H/dfulBo+jqmZA4b
         SKLI7o5pjvwPfXqsxpQ0JvYn3b0BZ69cooie/E/fd4305wqlXly18PvOa33nceCpmlgg
         UTVnt/iidHrR9ihKad0vChKyPYFj2/ACU+9sr1ZX1349hjMTF7+O14f9KBvsKy6p3I8u
         Y0vQ7NuuHAMj/eC2Ovdi5stfS687+yHYKJzmOUhADQbm92vdt84PU4TOTQ31upowpdYv
         eRZ1UYQIDegslrV32gWQ5fG9HTrvIbprOT8Z/+LO69I5OY+ROmQAwcxy1ZWMA1j0V+nF
         8kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iixqtCE8mSUlr+WU/acbaYSkS3dqv9ZutjCvmeMVbTg=;
        b=eCOG7kTmnES6bWaa7dtlD7RNwSvcXCjMKk/MaWEppLkj1/CDE/5Mqu0QJwQfBT2WBM
         ZTGvWhPX5jUACbSzRXXQE1rrfAK9NdgPRZGoh2vhFTpBtG0QyK4tuRaLvULFCH/kq/6W
         GNB/C5Molrtdr5TJ76Wn4teGRMb+HplM4oZzGHINooVZlyPtoe05DZHTxyID8cuPW69r
         NgZqY34CMzpU/B7VBnJKds0aESM5dkbdVRFkYzx+YYA4E0+fEdRod4CuvD6K5THCHR8V
         MpLNhG6aXUP+JoRvgqAQuFhwmBJzUO2z8sVDyr86QRbkgpBKYBL07ugUxkMoTGPl75qR
         XbHQ==
X-Gm-Message-State: AOAM530j5Ah5Xnt6rN/QPknIxy0godQcDlixK60dpMr/TjnGCANWqNRy
        apd67Gr4zp4uls1pB7QLfy+pkrzHUpA=
X-Google-Smtp-Source: ABdhPJyW/0jaavnf1TrkXmnjrb1IopaChWcO0lK/vpN8Sb53yk7aqzdgyexnwLYWe+9wr6wu/s4XPQ==
X-Received: by 2002:a63:43c6:: with SMTP id q189mr4171226pga.424.1640204524101;
        Wed, 22 Dec 2021 12:22:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x25sm1285266pfu.113.2021.12.22.12.22.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:22:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/6] Bluetooth: hci_sync: Add support for waiting specific LE subevents
Date:   Wed, 22 Dec 2021 12:21:57 -0800
Message-Id: <20211222202201.977779-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
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
index ca8e022a88e6..f1082b7c0218 100644
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
@@ -6464,13 +6463,24 @@ static const struct hci_le_ev {
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
@@ -6764,8 +6774,8 @@ static const struct hci_ev {
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
@@ -6849,11 +6859,12 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
index a3cf84873baa..334dc5f436a0 100644
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

