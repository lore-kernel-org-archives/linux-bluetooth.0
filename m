Return-Path: <SRS0=5F6V=MQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C6C64EB8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3964E21473
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 05:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3964E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJDMZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:25:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:53681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJDMZB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Oct 2018 08:25:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 22:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="78352879"
Received: from mallikarjun-h270m-d3h.iind.intel.com ([10.223.96.120])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2018 22:31:32 -0700
From:   Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth:LE credit based connection result values
Date:   Thu,  4 Oct 2018 10:59:46 +0530
Message-Id: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes added to rename the l2cap connect/create result values.
Result values specific to LE Credit based connection are renamed
as L2CAP_CR_LE*, and changed the old names wherever they were used.

Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
---
 include/net/bluetooth/l2cap.h | 29 +++++++++++++++++------------
 net/bluetooth/l2cap_core.c    | 12 ++++++------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0697fd4..35788d9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -270,19 +270,24 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_DYN_END	0xffff
 #define L2CAP_CID_LE_DYN_END	0x007f
 
+/* Renaming the result values specific to
+ * LE Credit based connection as L2CAP_CR_LE_*,
+ * And changing the old result value wherever they were used
+ */
+
 /* connect/create channel results */
-#define L2CAP_CR_SUCCESS	0x0000
-#define L2CAP_CR_PEND		0x0001
-#define L2CAP_CR_BAD_PSM	0x0002
-#define L2CAP_CR_SEC_BLOCK	0x0003
-#define L2CAP_CR_NO_MEM		0x0004
-#define L2CAP_CR_BAD_AMP	0x0005
-#define L2CAP_CR_AUTHENTICATION	0x0005
-#define L2CAP_CR_AUTHORIZATION	0x0006
-#define L2CAP_CR_BAD_KEY_SIZE	0x0007
-#define L2CAP_CR_ENCRYPTION	0x0008
-#define L2CAP_CR_INVALID_SCID	0x0009
-#define L2CAP_CR_SCID_IN_USE	0x000A
+#define L2CAP_CR_SUCCESS		0x0000
+#define L2CAP_CR_PEND			0x0001
+#define L2CAP_CR_BAD_PSM		0x0002
+#define L2CAP_CR_SEC_BLOCK		0x0003
+#define L2CAP_CR_NO_MEM			0x0004
+#define L2CAP_CR_BAD_AMP		0x0005
+#define L2CAP_CR_LE_AUTHENTICATION	0x0005
+#define L2CAP_CR_LE_AUTHORIZATION	0x0006
+#define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
+#define L2CAP_CR_LE_ENCRYPTION		0x0008
+#define L2CAP_CR_LE_INVALID_SCID	0x0009
+#define L2CAP_CR_LE_SCID_IN_USE		0x000A
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d17a473..1c49419 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -681,7 +681,7 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 	u16 result;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
-		result = L2CAP_CR_AUTHORIZATION;
+		result = L2CAP_CR_LE_AUTHORIZATION;
 	else
 		result = L2CAP_CR_BAD_PSM;
 
@@ -5314,8 +5314,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		l2cap_chan_ready(chan);
 		break;
 
-	case L2CAP_CR_AUTHENTICATION:
-	case L2CAP_CR_ENCRYPTION:
+	case L2CAP_CR_LE_AUTHENTICATION:
+	case L2CAP_CR_LE_ENCRYPTION:
 		/* If we already have MITM protection we can't do
 		 * anything.
 		 */
@@ -5468,21 +5468,21 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_AUTHENTICATION;
+		result = L2CAP_CR_LE_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
 	}
 
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
-		result = L2CAP_CR_INVALID_SCID;
+		result = L2CAP_CR_LE_INVALID_SCID;
 		chan = NULL;
 		goto response_unlock;
 	}
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		result = L2CAP_CR_SCID_IN_USE;
+		result = L2CAP_CR_LE_SCID_IN_USE;
 		chan = NULL;
 		goto response_unlock;
 	}
-- 
2.7.4

