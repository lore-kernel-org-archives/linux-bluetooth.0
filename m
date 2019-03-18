Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBEC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D420850
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 10:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRK3V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:29:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:27212 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfCRK3V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 06:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 03:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="132530937"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2019 03:29:19 -0700
From:   SpoorthiX K <spoorthix.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add support for LE ping feature
Date:   Mon, 18 Mar 2019 16:07:05 +0530
Message-Id: <1552905425-24048-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: SpoorthiX <spoorthix.k@intel.com>

Changes made to add HCI Write Authenticated Payload timeout
command for LE Ping feature.
As per the Core Specification 5.0 Volume 2 Part E Section 7.3.94,
the following code changes implements
HCI Write Authenticated Payload timeout command for LE Ping feature.

Signed-off-by: SpoorthiX <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h |  7 +++++++
 net/bluetooth/hci_event.c   | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e..ec37c19 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1130,6 +1130,13 @@ struct hci_cp_write_sc_support {
 	__u8	support;
 } __packed;
 
+#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
+struct hci_cp_write_auth_payload_to {
+        __u16     conn_handle;
+        __u16      timeout;
+} __packed;
+
+
 #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
 struct hci_rp_read_local_oob_ext_data {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd68..ae14927 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -38,6 +38,7 @@
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
+#define AUTHENTICATED_PAYLOAD_TIMEOUT 0x0BB8
 
 /* Handle HCI Event packets */
 
@@ -4815,6 +4816,22 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 }
 #endif
 
+static void hci_write_auth_payload_to (struct hci_dev *hdev, struct hci_conn *conn)
+{
+        struct hci_cp_write_auth_payload_to cp;
+
+        /* Check for existing LE link established between local
+         * and remote device, also check the controller capability
+         * for LE Ping.
+         */
+        if ((conn->type == LE_LINK) && (lmp_ping_capable(hdev)))  {
+                cp.conn_handle = cpu_to_le16(conn->handle);
+                cp.timeout = AUTHENTICATED_PAYLOAD_TIMEOUT;
+                hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
+			sizeof(cp), &cp);
+        }
+}
+
 static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			bdaddr_t *bdaddr, u8 bdaddr_type, u8 role, u16 handle,
 			u16 interval, u16 latency, u16 supervision_timeout)
@@ -4972,6 +4989,10 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		}
 	}
 
+         /* Set the default Authenticated Payload Timeout after
+          * an LE Link is established.
+          */
+	hci_write_auth_payload_to (hdev, conn);
 unlock:
 	hci_update_background_scan(hdev);
 	hci_dev_unlock(hdev);
-- 
1.9.1

