Return-Path: <SRS0=/e8j=W7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A9C3A5A8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846F206B8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390633AbfIDSNM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46682 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389844AbfIDSNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:12 -0400
Received: from localhost.localdomain (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 61ED7CECC5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2019 20:21:58 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: validate BLE connection interval updates"
Date:   Wed,  4 Sep 2019 20:13:08 +0200
Message-Id: <20190904181308.14948-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reverts commit c49a8682fc5d298d44e8d911f4fa14690ea9485e.

There are devices which require low connection intervals for usable operation
including keyboards and mice. Forcing a static connection interval for
these types of devices has an impact in latency and causes a regression.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c  | 5 -----
 net/bluetooth/l2cap_core.c | 9 +--------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cdb00c2ef242..c1d3a303d97f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5660,11 +5660,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
-	if (min < hcon->le_conn_min_interval ||
-	    max > hcon->le_conn_max_interval)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
-
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dfc1edb168b7..da7fdbdf9c41 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5305,14 +5305,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (min < hcon->le_conn_min_interval ||
-	    max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.21.0

