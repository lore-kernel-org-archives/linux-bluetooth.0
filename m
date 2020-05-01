Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D0C4724C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D520836
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgEARBC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 13:01:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:21285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgEARBC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 13:01:02 -0400
IronPort-SDR: ugJjwQfUieEnP2olAmLfQahnS2AH6enYG4ZYFRcK2QkeOst28Bu7OuL5UKkCBK7JVG6IH73NKa
 3OvjGK2diynw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 10:01:01 -0700
IronPort-SDR: Rpnah1ajWODl7WbCWdCpr0EjaBbh1/fjfYKTEMAdbNcoBSTTW7yu2qOcW2Dtcgo4Hz1yMPKijy
 NUgROfFOIdTw==
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="433367572"
Received: from han1-mobl3.jf.intel.com ([10.254.74.98])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 10:01:01 -0700
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v2] Bluetooth: Fix advertising handle is set to 0
Date:   Fri,  1 May 2020 10:00:50 -0700
Message-Id: <20200501170050.42758-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fix the advertising handle is set to 0 regardless of actual
instance value. The affected commands are LE Set Advertising Set Random
Address, LE Set Extended Advertising Data, and LE Set Extended Scan
Response Data commands.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 net/bluetooth/hci_request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9ea40106ef17..3f470f0e432c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1447,7 +1447,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
 		hdev->scan_rsp_data_len = len;
 
-		cp.handle = 0;
+		cp.handle = instance;
 		cp.length = len;
 		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
 		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
@@ -1591,7 +1591,7 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 		hdev->adv_data_len = len;
 
 		cp.length = len;
-		cp.handle = 0;
+		cp.handle = instance;
 		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
 		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
@@ -1876,7 +1876,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		cp.handle = 0;
+		cp.handle = instance;
 		bacpy(&cp.bdaddr, &random_addr);
 
 		hci_req_add(req,
-- 
2.25.4

