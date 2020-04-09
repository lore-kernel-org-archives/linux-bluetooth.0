Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D620C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D941620757
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58834 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D759DCECF5
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2020 08:15:29 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Enable LE Enhanced Connection Complete event.
Date:   Thu,  9 Apr 2020 08:05:49 +0200
Message-Id: <6b6ecbf19559cb16793d7ef3e96c1181a32b4df5.1586412226.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586412226.git.marcel@holtmann.org>
References: <cover.1586412226.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In case LL Privacy is supported by the controller, it is also a good
idea to use the LE Enhanced Connection Complete event for getting all
information about the new connection and its addresses.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ff42d05b3e72..1da8cec8e210 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -460,6 +460,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 589c4085499c..0d726d59a492 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -638,6 +638,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
 			events[0] |= 0x40;	/* LE Data Length Change */
 
+		/* If the controller supports LL Privacy feature, enable
+		 * the corresponding event.
+		 */
+		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+			events[1] |= 0x02;	/* LE Enhanced Connection
+						 * Complete
+						 */
+
 		/* If the controller supports Extended Scanner Filter
 		 * Policies, enable the correspondig event.
 		 */
-- 
2.25.2

