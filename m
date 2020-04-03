Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D8C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47B820CC7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 19:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgDCToP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:44:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52239 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgDCToO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 15:44:14 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9B946CED0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2020 21:53:46 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Add support for Read Local Simple Pairing Options
Date:   Fri,  3 Apr 2020 21:44:04 +0200
Message-Id: <20200403194407.784943-8-marcel@holtmann.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the Read Local Simple Pairing Options command it is possible to
retrieve the support for max encryption key size supported by the
controller and also if the controller correctly verifies the ECDH public
key during pairing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---
 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         |  4 ++++
 net/bluetooth/hci_event.c        | 21 +++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9ff2f7a9e131..086a9e9d5d03 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1275,6 +1275,13 @@ struct hci_rp_read_data_block_size {
 
 #define HCI_OP_READ_LOCAL_CODECS	0x100b
 
+#define HCI_OP_READ_LOCAL_PAIRING_OPTS	0x100c
+struct hci_rp_read_local_pairing_opts {
+	__u8     status;
+	__u8     pairing_opts;
+	__u8     max_key_size;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct hci_rp_read_page_scan_activity {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3cb0f82d0c83..2f3275f1d1c4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -312,6 +312,8 @@ struct hci_dev {
 	__u16		conn_info_max_age;
 	__u16		auth_payload_timeout;
 	__u8		min_enc_key_size;
+	__u8		max_enc_key_size;
+	__u8		pairing_opts;
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ef0ee3a3d9ed..589c4085499c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -827,6 +827,10 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[29] & 0x20)
 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
 
+	/* Read local pairing options if the HCI command is supported */
+	if (hdev->commands[41] & 0x08)
+		hci_req_add(req, HCI_OP_READ_LOCAL_PAIRING_OPTS, 0, NULL);
+
 	/* Get MWS transport configuration if the HCI command is supported */
 	if (hdev->commands[30] & 0x08)
 		hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2803beaa1c44..51e6461f0b71 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -747,6 +747,23 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 		bacpy(&hdev->setup_addr, &rp->bdaddr);
 }
 
+static void hci_cc_read_local_pairing_opts(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_read_local_pairing_opts *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		hdev->pairing_opts = rp->pairing_opts;
+		hdev->max_enc_key_size = rp->max_key_size;
+	}
+}
+
 static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -3343,6 +3360,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_PAIRING_OPTS:
+		hci_cc_read_local_pairing_opts(hdev, skb);
+		break;
+
 	case HCI_OP_READ_PAGE_SCAN_ACTIVITY:
 		hci_cc_read_page_scan_activity(hdev, skb);
 		break;
-- 
2.25.1

