Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB034C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956E220809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgG3JOb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57558 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgG3JO3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:29 -0400
Received: from localhost.localdomain (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id F1D29CECF8
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 11:24:28 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Enable RPA Timeout
Date:   Thu, 30 Jul 2020 11:14:20 +0200
Message-Id: <20200730091421.48847-7-marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <nsathish41@gmail.com>

Enable RPA timeout during bluetooth initialization.
The RPA timeout value is used from hdev, which initialized from
debug_fs

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dccd6718e..dd82cce77a7a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1648,6 +1648,8 @@ struct hci_rp_le_read_resolv_list_size {
 
 #define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
 
+#define HCI_OP_LE_SET_RPA_TIMEOUT	0x202e
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3f89bd639860..68bfe57b6625 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -763,6 +763,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
 		}
 
+		if (hdev->commands[35] & 0x40) {
+			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
+
+			/* Set RPA timeout */
+			hci_req_add(req, HCI_OP_LE_SET_RPA_TIMEOUT, 2,
+				    &rpa_timeout);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
-- 
2.26.2

