Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4353FC64EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A81E20684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 13:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A81E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJCUas (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:30:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:55081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUas (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 16:30:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 06:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="95714468"
Received: from mallikarjun-h270m-d3h.iind.intel.com ([10.223.96.120])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2018 06:42:19 -0700
From:   Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth : Errata Service Release 8, Erratum 3253
Date:   Wed,  3 Oct 2018 19:10:34 +0530
Message-Id: <1538574034-31184-1-git-send-email-mallikarjun.phulari@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

L2CAP: New result values
	0x0006 - Connection refused – Invalid Source CID
	0x0007 - Connection refused – Source CID already allocated

As per the ESR08_V1.0.0, 1.11.2 Erratum 3253, Page No. 54,
"Remote CID invalid Issue".
Applies to Core Specification versions: V5.0, V4.2, v4.1, v4.0, and v3.0 + HS
Vol 3, Part A, Section 4.2, 4.3, 4.14, 4.15.

Core Specification Version 5.0, Page No.1753, Table 4.6 and
Page No. 1767, Table 4.14

New result values are added to l2cap connect/create channel response as
0x0006 - Connection refused – Invalid Source CID
0x0007 - Connection refused – Source CID already allocated

And also renamed the result values specific to LE Credit based Connection
as L2CAP_CR_LE_* and changed the old names wherever they were used.

Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
---
 include/net/bluetooth/l2cap.h | 33 +++++++++++++++++++++------------
 net/bluetooth/l2cap_core.c    | 29 ++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0697fd4..dfb047b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -270,19 +270,28 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_DYN_END	0xffff
 #define L2CAP_CID_LE_DYN_END	0x007f
 
+/* Adding two new connect/create channel results
+ * As per ESR08_V1.0.0, Erratum 3253
+ * And renaming the result values specific to
+ * LE Credit based connection as L2CAP_CR_LE_*,
+ * And changing the old result value wherever they are used
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
+#define L2CAP_CR_INVALID_SCID		0x0006
+#define L2CAP_CR_SCID_IN_USE		0x0007
+#define L2CAP_CR_LE_AUTHENTICATION	0x0005
+#define L2CAP_CR_LE_AUTHORIZATION	0x0006
+#define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
+#define L2CAP_CR_LE_ENCRYPTION		0x0008
+#define L2CAP_CR_LE_INVALID_SCID	0x0009
+#define L2CAP_CR_LE_SCID_IN_USE		0x000A
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d17a473..85179ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -681,7 +681,7 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 	u16 result;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
-		result = L2CAP_CR_AUTHORIZATION;
+		result = L2CAP_CR_LE_AUTHORIZATION;
 	else
 		result = L2CAP_CR_BAD_PSM;
 
@@ -3815,9 +3815,24 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	result = L2CAP_CR_NO_MEM;
 
+	/* As per ESR08_V1.0.0, Erratum 3253, check the CID is in valid
+	 * dynamic range and is not allocated already.
+	 * Send the new result values accordingly
+	 */
+
+	/* Check for valid dynamic CID range */
+	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
+		result = L2CAP_CR_INVALID_SCID;
+		chan = NULL;
+		goto response;
+	}
+
 	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(conn, scid))
+	if (__l2cap_get_chan_by_dcid(conn, scid)) {
+		result = L2CAP_CR_SCID_IN_USE;
+		chan = NULL;
 		goto response;
+	}
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
@@ -5314,8 +5329,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		l2cap_chan_ready(chan);
 		break;
 
-	case L2CAP_CR_AUTHENTICATION:
-	case L2CAP_CR_ENCRYPTION:
+	case L2CAP_CR_LE_AUTHENTICATION:
+	case L2CAP_CR_LE_ENCRYPTION:
 		/* If we already have MITM protection we can't do
 		 * anything.
 		 */
@@ -5468,21 +5483,21 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
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

