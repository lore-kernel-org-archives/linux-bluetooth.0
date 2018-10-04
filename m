Return-Path: <SRS0=5F6V=MQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517FC64EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C9A21473
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 05:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C9A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJDMZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:25:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:53681 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbeJDMZC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Oct 2018 08:25:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 22:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="78352891"
Received: from mallikarjun-h270m-d3h.iind.intel.com ([10.223.96.120])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2018 22:31:36 -0700
From:   Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth : Errata Service Release 8, Erratum 3253
Date:   Thu,  4 Oct 2018 10:59:47 +0530
Message-Id: <1538630987-4476-2-git-send-email-mallikarjun.phulari@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
References: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
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

Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
---
 include/net/bluetooth/l2cap.h |  6 ++++++
 net/bluetooth/l2cap_core.c    | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 35788d9..fd3998a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -275,6 +275,10 @@ struct l2cap_conn_rsp {
  * And changing the old result value wherever they were used
  */
 
+/* Adding two new connect/create channel results
+ * As per ESR08_V1.0.0, Erratum 3253
+ */
+
 /* connect/create channel results */
 #define L2CAP_CR_SUCCESS		0x0000
 #define L2CAP_CR_PEND			0x0001
@@ -282,6 +286,8 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_SEC_BLOCK		0x0003
 #define L2CAP_CR_NO_MEM			0x0004
 #define L2CAP_CR_BAD_AMP		0x0005
+#define L2CAP_CR_INVALID_SCID		0x0006
+#define L2CAP_CR_SCID_IN_USE		0x0007
 #define L2CAP_CR_LE_AUTHENTICATION	0x0005
 #define L2CAP_CR_LE_AUTHORIZATION	0x0006
 #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1c49419..85179ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
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
-- 
2.7.4

