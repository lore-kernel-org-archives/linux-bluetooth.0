Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D74C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352620AbhLAS6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbhLAS6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF3C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id l190so24576549pge.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fPIfCP+f2YQy1I1YODv32kv9aALly5W7RjMOlxfRVJk=;
        b=TnUGGaPyflDB8FFNh5nCQ0JKnWACD1WpRVKmvCtze6GWCO0cECHMuzJryn8zakED6Z
         8UtQZ1U0fMiJlZw6YNu06GSdcJshAApetjaP8BfgePppQ7W6N8B+JjaaQrq0ommmuWU8
         djMDgYvUBV7dO0OWiHLEwQh0/MPGBnU5PUDNTvsQANQ2JgXEekOMY/Z55B1+eCqNB83I
         jy+ZL0YAASbWpJk/hWbzJU4ocdCUr/rkdEWH7D1bmr93CProOb+tqHQW3gyDJniG5/Dk
         a86b2snwWNOaIEAC8gCzuWsFz5yAxdUBtdCaGKAyVrB4e8cMOXtiLs95L54DQ78YtfNk
         U18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPIfCP+f2YQy1I1YODv32kv9aALly5W7RjMOlxfRVJk=;
        b=nyzCSfgBSuYv/fF92LaHe8NsEkIIa82Z/Bauzqpi9ATsCZBg8q6xCP9sdsIvuQhdkX
         IasDgCEh+oW+alSWRBlI8jzBIC88ngUgnBXc6a9kyyW9fGQYEFc66sQoI/aFjrObYjhu
         SAqb6zoIR/Iy5E6RnBmBDXHfjdhHly37hNZwhDCYLldm4tyj/IYz1mK2M/bDioRA4fgX
         964qK0NIA6cnGkY91IAwZmnqW+QGhFAVsof2jpTN2rpx++lTnSSFEBp9ztNqPi14dhkz
         EifOnwjD4/8WF0WFpO5494dezQzFG5ApIXt+ZgDoG3e1Sf8y3Hx3yYkwFL0LhsqxCvvA
         LLuw==
X-Gm-Message-State: AOAM531Ii/wNQBBW8jaIrqJxtpC+F2V2xzY+hQVk+sZFEIIIG+XmRQAV
        yozm6noBF3pPgqX6nXufBdA3jmKdHrY=
X-Google-Smtp-Source: ABdhPJx0i2xhobqpx2C8maHH6E+mTae3a/wE8u0QyJWcVp2qn5H3ejgFkZ3E0UXUjhWxH+cLtVNBww==
X-Received: by 2002:a63:90c8:: with SMTP id a191mr6173779pge.400.1638384919598;
        Wed, 01 Dec 2021 10:55:19 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/15] Bluetooth: hci_event: Use of a function table to handle Command Status
Date:   Wed,  1 Dec 2021 10:55:06 -0800
Message-Id: <20211201185506.1421186-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This change the use of switch statement to a function table which is
easier to extend.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 152 +++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 93 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 313b7b79d5b5..df1aca5f28da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2195,7 +2195,7 @@ static u8 hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, void *data,
 
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (status) {
 		hci_conn_check_pending(hdev);
@@ -2210,7 +2210,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_create_conn *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_CONN);
 	if (!cp)
@@ -2220,7 +2220,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 
-	BT_DBG("%s bdaddr %pMR hcon %p", hdev->name, &cp->bdaddr, conn);
+	bt_dev_dbg(hdev, "bdaddr %pMR hcon %p", &cp->bdaddr, conn);
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
@@ -2249,7 +2249,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 	struct hci_conn *acl, *sco;
 	__u16 handle;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2260,7 +2260,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 
 	handle = __le16_to_cpu(cp->handle);
 
-	BT_DBG("%s handle 0x%4.4x", hdev->name, handle);
+	bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
 
 	hci_dev_lock(hdev);
 
@@ -2283,7 +2283,7 @@ static void hci_cs_auth_requested(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_auth_requested *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2310,7 +2310,7 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_set_conn_encrypt *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2446,7 +2446,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_remote_name_req *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	/* If successful wait for the name req complete event before
 	 * checking for the need to do authentication */
@@ -2489,7 +2489,7 @@ static void hci_cs_read_remote_features(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_read_remote_features *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2516,7 +2516,7 @@ static void hci_cs_read_remote_ext_features(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_read_remote_ext_features *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2544,7 +2544,7 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	struct hci_conn *acl, *sco;
 	__u16 handle;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2555,7 +2555,7 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 
 	handle = __le16_to_cpu(cp->handle);
 
-	BT_DBG("%s handle 0x%4.4x", hdev->name, handle);
+	bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
 
 	hci_dev_lock(hdev);
 
@@ -2613,7 +2613,7 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_sniff_mode *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2640,7 +2640,7 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	struct hci_cp_exit_sniff_mode *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2669,6 +2669,8 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	struct hci_conn *conn;
 	bool mgmt_conn;
 
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
 	/* Wait for HCI_EV_DISCONN_COMPLETE if status 0x00 and not suspended
 	 * otherwise cleanup the connection immediately.
 	 */
@@ -2802,7 +2804,7 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_create_conn *cp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	/* All connection failure handling is taken care of by the
 	 * hci_le_conn_failed function which is triggered by the HCI
@@ -2827,7 +2829,7 @@ static void hci_cs_le_ext_create_conn(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_ext_create_conn *cp;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	/* All connection failure handling is taken care of by the
 	 * hci_le_conn_failed function which is triggered by the HCI
@@ -2853,7 +2855,7 @@ static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
 	struct hci_cp_le_read_remote_features *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -2880,7 +2882,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	struct hci_cp_le_start_enc *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	if (!status)
 		return;
@@ -3948,92 +3950,56 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
+#define HCI_CS(_op, _func) \
+{ \
+	.op = _op, \
+	.func = _func, \
+}
+
+static const struct hci_cs {
+	u16  op;
+	void (*func)(struct hci_dev *hdev, __u8 status);
+} hci_cs_table[] = {
+	HCI_CS(HCI_OP_INQUIRY, hci_cs_inquiry),
+	HCI_CS(HCI_OP_CREATE_CONN, hci_cs_create_conn),
+	HCI_CS(HCI_OP_DISCONNECT, hci_cs_disconnect),
+	HCI_CS(HCI_OP_ADD_SCO, hci_cs_add_sco),
+	HCI_CS(HCI_OP_AUTH_REQUESTED, hci_cs_auth_requested),
+	HCI_CS(HCI_OP_SET_CONN_ENCRYPT, hci_cs_set_conn_encrypt),
+	HCI_CS(HCI_OP_REMOTE_NAME_REQ, hci_cs_remote_name_req),
+	HCI_CS(HCI_OP_READ_REMOTE_FEATURES, hci_cs_read_remote_features),
+	HCI_CS(HCI_OP_READ_REMOTE_EXT_FEATURES,
+	       hci_cs_read_remote_ext_features),
+	HCI_CS(HCI_OP_SETUP_SYNC_CONN, hci_cs_setup_sync_conn),
+	HCI_CS(HCI_OP_ENHANCED_SETUP_SYNC_CONN,
+	       hci_cs_enhanced_setup_sync_conn),
+	HCI_CS(HCI_OP_SNIFF_MODE, hci_cs_sniff_mode),
+	HCI_CS(HCI_OP_EXIT_SNIFF_MODE, hci_cs_exit_sniff_mode),
+	HCI_CS(HCI_OP_SWITCH_ROLE, hci_cs_switch_role),
+	HCI_CS(HCI_OP_LE_CREATE_CONN, hci_cs_le_create_conn),
+	HCI_CS(HCI_OP_LE_READ_REMOTE_FEATURES, hci_cs_le_read_remote_features),
+	HCI_CS(HCI_OP_LE_START_ENC, hci_cs_le_start_enc),
+	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn)
+};
+
 static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 			       struct sk_buff *skb, u16 *opcode, u8 *status,
 			       hci_req_complete_t *req_complete,
 			       hci_req_complete_skb_t *req_complete_skb)
 {
 	struct hci_ev_cmd_status *ev = data;
+	int i;
 
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = ev->status;
 
-	switch (*opcode) {
-	case HCI_OP_INQUIRY:
-		hci_cs_inquiry(hdev, ev->status);
-		break;
-
-	case HCI_OP_CREATE_CONN:
-		hci_cs_create_conn(hdev, ev->status);
-		break;
-
-	case HCI_OP_DISCONNECT:
-		hci_cs_disconnect(hdev, ev->status);
-		break;
-
-	case HCI_OP_ADD_SCO:
-		hci_cs_add_sco(hdev, ev->status);
-		break;
-
-	case HCI_OP_AUTH_REQUESTED:
-		hci_cs_auth_requested(hdev, ev->status);
-		break;
-
-	case HCI_OP_SET_CONN_ENCRYPT:
-		hci_cs_set_conn_encrypt(hdev, ev->status);
-		break;
-
-	case HCI_OP_REMOTE_NAME_REQ:
-		hci_cs_remote_name_req(hdev, ev->status);
-		break;
-
-	case HCI_OP_READ_REMOTE_FEATURES:
-		hci_cs_read_remote_features(hdev, ev->status);
-		break;
-
-	case HCI_OP_READ_REMOTE_EXT_FEATURES:
-		hci_cs_read_remote_ext_features(hdev, ev->status);
-		break;
-
-	case HCI_OP_SETUP_SYNC_CONN:
-		hci_cs_setup_sync_conn(hdev, ev->status);
-		break;
-
-	case HCI_OP_ENHANCED_SETUP_SYNC_CONN:
-		hci_cs_enhanced_setup_sync_conn(hdev, ev->status);
-		break;
-
-	case HCI_OP_SNIFF_MODE:
-		hci_cs_sniff_mode(hdev, ev->status);
-		break;
-
-	case HCI_OP_EXIT_SNIFF_MODE:
-		hci_cs_exit_sniff_mode(hdev, ev->status);
-		break;
-
-	case HCI_OP_SWITCH_ROLE:
-		hci_cs_switch_role(hdev, ev->status);
-		break;
-
-	case HCI_OP_LE_CREATE_CONN:
-		hci_cs_le_create_conn(hdev, ev->status);
-		break;
-
-	case HCI_OP_LE_READ_REMOTE_FEATURES:
-		hci_cs_le_read_remote_features(hdev, ev->status);
-		break;
-
-	case HCI_OP_LE_START_ENC:
-		hci_cs_le_start_enc(hdev, ev->status);
-		break;
-
-	case HCI_OP_LE_EXT_CREATE_CONN:
-		hci_cs_le_ext_create_conn(hdev, ev->status);
-		break;
+	bt_dev_dbg(hdev, "opcode 0x%4.4x", *opcode);
 
-	default:
-		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
-		break;
+	for (i = 0; i < ARRAY_SIZE(hci_cs_table); i++) {
+		if (hci_cs_table[i].op == *opcode) {
+			hci_cs_table[i].func(hdev, ev->status);
+			break;
+		}
 	}
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
-- 
2.33.1

