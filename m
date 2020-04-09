Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB250C2BB55
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5292084D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDIGF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:05:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49599 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8225CECF4
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2020 08:15:29 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Use extra variable to make code more readable
Date:   Thu,  9 Apr 2020 08:05:48 +0200
Message-Id: <d1758d42f0c1252f02796d28d3e4ca78f5d633c8.1586412226.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586412226.git.marcel@holtmann.org>
References: <cover.1586412226.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When starting active scanning for discovery the whitelist is not needed
to be used. So the filter_policy is 0x00. To make the core more readable
use a variable name instead of just setting 0 as paramter.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 649e1e5ed446..9ea40106ef17 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2723,6 +2723,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	uint16_t interval = opt;
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
+	/* White list is not used for discovery */
+	u8 filter_policy = 0x00;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2744,7 +2746,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, 0);
+			   own_addr_type, filter_policy);
 	return 0;
 }
 
-- 
2.25.2

