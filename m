Return-Path: <SRS0=1XHc=MR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5FBC00449
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B420875
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeJEQSS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:18:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:1470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbeJEQSS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Oct 2018 12:18:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 02:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="80086420"
Received: from mallikarjun-h270m-d3h.iind.intel.com ([10.223.96.120])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2018 02:20:16 -0700
From:   Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth:LE credit based connection result values
Date:   Fri,  5 Oct 2018 14:48:12 +0530
Message-Id: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added the result values specific to LE Credit based connection
And changing the old result values wherever they were used

Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
---
 include/net/bluetooth/l2cap.h | 17 +++++++++++------
 net/bluetooth/l2cap_core.c    | 26 +++++++++++++-------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0697fd4..06c247d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -277,12 +277,17 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_SEC_BLOCK	0x0003
 #define L2CAP_CR_NO_MEM		0x0004
 #define L2CAP_CR_BAD_AMP	0x0005
-#define L2CAP_CR_AUTHENTICATION	0x0005
-#define L2CAP_CR_AUTHORIZATION	0x0006
-#define L2CAP_CR_BAD_KEY_SIZE	0x0007
-#define L2CAP_CR_ENCRYPTION	0x0008
-#define L2CAP_CR_INVALID_SCID	0x0009
-#define L2CAP_CR_SCID_IN_USE	0x000A
+
+/* credit based connect results */
+#define L2CAP_CR_LE_SUCCESS		0x0000
+#define L2CAP_CR_LE_BAD_PSM		0x0002
+#define L2CAP_CR_LE_NO_MEM		0x0004
+#define L2CAP_CR_LE_AUTHENTICATION	0x0005
+#define L2CAP_CR_LE_AUTHORIZATION	0x0006
+#define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
+#define L2CAP_CR_LE_ENCRYPTION		0x0008
+#define L2CAP_CR_LE_INVALID_SCID	0x0009
+#define L2CAP_CR_LE_SCID_IN_USE		0X000A
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d17a473..01a89b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -681,9 +681,9 @@ static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
 	u16 result;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
-		result = L2CAP_CR_AUTHORIZATION;
+		result = L2CAP_CR_LE_AUTHORIZATION;
 	else
-		result = L2CAP_CR_BAD_PSM;
+		result = L2CAP_CR_LE_BAD_PSM;
 
 	l2cap_state_change(chan, BT_DISCONN);
 
@@ -3669,7 +3669,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 	rsp.mtu     = cpu_to_le16(chan->imtu);
 	rsp.mps     = cpu_to_le16(chan->mps);
 	rsp.credits = cpu_to_le16(chan->rx_credits);
-	rsp.result  = cpu_to_le16(L2CAP_CR_SUCCESS);
+	rsp.result  = cpu_to_le16(L2CAP_CR_LE_SUCCESS);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
 		       &rsp);
@@ -5279,7 +5279,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	credits = __le16_to_cpu(rsp->credits);
 	result  = __le16_to_cpu(rsp->result);
 
-	if (result == L2CAP_CR_SUCCESS && (mtu < 23 || mps < 23 ||
+	if (result == L2CAP_CR_LE_SUCCESS && (mtu < 23 || mps < 23 ||
 					   dcid < L2CAP_CID_DYN_START ||
 					   dcid > L2CAP_CID_LE_DYN_END))
 		return -EPROTO;
@@ -5300,7 +5300,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	l2cap_chan_lock(chan);
 
 	switch (result) {
-	case L2CAP_CR_SUCCESS:
+	case L2CAP_CR_LE_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
 			err = -EBADSLT;
 			break;
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
@@ -5458,7 +5458,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
 					 &conn->hcon->dst, LE_LINK);
 	if (!pchan) {
-		result = L2CAP_CR_BAD_PSM;
+		result = L2CAP_CR_LE_BAD_PSM;
 		chan = NULL;
 		goto response;
 	}
@@ -5468,28 +5468,28 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
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
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan) {
-		result = L2CAP_CR_NO_MEM;
+		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
 	}
 
@@ -5524,7 +5524,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		chan->ops->defer(chan);
 	} else {
 		l2cap_chan_ready(chan);
-		result = L2CAP_CR_SUCCESS;
+		result = L2CAP_CR_LE_SUCCESS;
 	}
 
 response_unlock:
-- 
2.7.4

