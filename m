Return-Path: <SRS0=1XHc=MR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C6C65BA7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19222098A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19222098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJEQSS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:18:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:1470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbeJEQSS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Oct 2018 12:18:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 02:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="80086445"
Received: from mallikarjun-h270m-d3h.iind.intel.com ([10.223.96.120])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2018 02:20:21 -0700
From:   Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth : Errata Service Release 8, Erratum 3253
Date:   Fri,  5 Oct 2018 14:48:13 +0530
Message-Id: <1538731093-30347-2-git-send-email-mallikarjun.phulari@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
References: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
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
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 06c247d..efdc195 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -277,6 +277,8 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_SEC_BLOCK	0x0003
 #define L2CAP_CR_NO_MEM		0x0004
 #define L2CAP_CR_BAD_AMP	0x0005
+#define L2CAP_CR_INVALID_SCID	0x0006
+#define L2CAP_CR_SCID_IN_USE	0x0007
 
 /* credit based connect results */
 #define L2CAP_CR_LE_SUCCESS		0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 01a89b2..c244c450 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3815,9 +3815,17 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	result = L2CAP_CR_NO_MEM;
 
+	/* Check for valid dynamic CID range (as per Erratum 3253) */
+	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
+		result = L2CAP_CR_INVALID_SCID;
+		goto response;
+	}
+
 	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(conn, scid))
+	if (__l2cap_get_chan_by_dcid(conn, scid)) {
+		result = L2CAP_CR_SCID_IN_USE;
 		goto response;
+	}
 
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
-- 
2.7.4

