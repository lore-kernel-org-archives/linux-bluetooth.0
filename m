Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E3C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 20:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjC0UyC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0UyB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 16:54:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFBA12F
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 13:54:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso13082955pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1L+faVjqclI2aZ3GTM8ttWFm4rrYutFC0WWX7Io7o8g=;
        b=pTVE+PERdy4iLOcvdjLkBuwivmzf9l5sZJZlgEnTNlNmJYwaxYxdZv982KygkfFRBq
         GWwaxc3F74u6eS8tfl+lVjq4/aLH7AV/QCQ4dKDLBTz/ytEcWJ9Zxzfr0iT5v5NDcirJ
         q9p+HLahH51F4opI+HMWo7pNxg4nhImhxeihnSMCxM+FrBkWUo8GQD87JtlB60YBjz0j
         x5JsFsp5zRT+LqOSUOJL/I62+O5+hvsDSznggOx/5O8eksqrKCU7kQrvwQv/cn8sJcG0
         rOcTGwamfaoqfOcZbQhpv2OzC/eAoPIwhoV+bUgC05U4f4hdh6HCodhU8jRSZblt/SnY
         BrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L+faVjqclI2aZ3GTM8ttWFm4rrYutFC0WWX7Io7o8g=;
        b=nyvpV6lHcBcvPlgNi553Xky9IL8noQqNKtsfVqZFZlGTG2mh7n1AW1ckAqjSe+GR6r
         tVTY5KAL0ik6OmEVMZ8JZx/KLZ51VujnsG5DqZkheZzhhae3w0QEbRsN9g7g1V1e/rXt
         9arinsWOKKReeX5mYa3rBktbVARgTh50LxH/wIO2N4g0HRuTyQSZSWUzd8efXqhKWpKX
         B4dYJ1dnqey6qFM021e1CTpVEWkoIK6fVrW19yOL9/3jm7u5JYN0qit8y832lYqw92Y9
         B6gX1IvYYT2dAPjxZSODBwJdiwr4tLtCA1ExvI1f3JUchwuqqvbFoKhMAmRhA6OGdtEe
         9VDw==
X-Gm-Message-State: AAQBX9cMDo8zM/U7gkM/r4CvELVPLgdBmPtY12lX23gm1uLfqjPsoQqC
        5mRLnJhYrYolrXoY9LQZYajo0Vezgro=
X-Google-Smtp-Source: AKy350ZZZlqxEMgO+vFupb9FxvECL/AgB/7UxRfU4/BZ36A5Jzkf7S/Y64SwSPwaM3Eaf7h+cjErgw==
X-Received: by 2002:a17:90b:314c:b0:23d:42d4:b9f5 with SMTP id ip12-20020a17090b314c00b0023d42d4b9f5mr14842168pjb.37.1679950438976;
        Mon, 27 Mar 2023 13:53:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id mu10-20020a17090b388a00b002369a14d6b1sm4781155pjb.31.2023.03.27.13.53.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:53:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
Date:   Mon, 27 Mar 2023 13:53:46 -0700
Message-Id: <20230327205347.51568-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_connect_le_scan_cleanup shall always be invoked to cleanup the
states and re-enable passive scanning if necessary, otherwise it may
cause the pending action to stay active causing multiple attempts to
connect.

Fixes: 9b3628d79b46 ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 52 +++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 17b946f9ba31..5af3f6b011c9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -68,7 +68,7 @@ static const struct sco_param esco_param_msbc[] = {
 };
 
 /* This function requires the caller holds hdev->lock */
-static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
+static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 {
 	struct hci_conn_params *params;
 	struct hci_dev *hdev = conn->hdev;
@@ -88,9 +88,28 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, bdaddr,
 					   bdaddr_type);
-	if (!params || !params->explicit_connect)
+	if (!params)
 		return;
 
+	if (params->conn) {
+		hci_conn_drop(params->conn);
+		hci_conn_put(params->conn);
+		params->conn = NULL;
+	}
+
+	if (!params->explicit_connect)
+		return;
+
+	/* If the status indicates successful cancellation of
+	 * the attempt (i.e. Unknown Connection Id) there's no point of
+	 * notifying failure since we'll go back to keep trying to
+	 * connect. The only exception is explicit connect requests
+	 * where a timeout + cancel does indicate an actual failure.
+	 */
+	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID)
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
+				    conn->dst_type, status);
+
 	/* The connection attempt was doing scan for new RPA, and is
 	 * in scan phase. If params are not associated with any other
 	 * autoconnect action, remove them completely. If they are, just unmark
@@ -178,7 +197,7 @@ static void le_scan_cleanup(struct work_struct *work)
 	rcu_read_unlock();
 
 	if (c == conn) {
-		hci_connect_le_scan_cleanup(conn);
+		hci_connect_le_scan_cleanup(conn, 0x00);
 		hci_conn_cleanup(conn);
 	}
 
@@ -1179,31 +1198,8 @@ EXPORT_SYMBOL(hci_get_route);
 static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct hci_conn_params *params;
 
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
-					   conn->dst_type);
-	if (params && params->conn) {
-		hci_conn_drop(params->conn);
-		hci_conn_put(params->conn);
-		params->conn = NULL;
-	}
-
-	/* If the status indicates successful cancellation of
-	 * the attempt (i.e. Unknown Connection Id) there's no point of
-	 * notifying failure since we'll go back to keep trying to
-	 * connect. The only exception is explicit connect requests
-	 * where a timeout + cancel does indicate an actual failure.
-	 */
-	if (status != HCI_ERROR_UNKNOWN_CONN_ID ||
-	    (params && params->explicit_connect))
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
-
-	/* Since we may have temporarily stopped the background scanning in
-	 * favor of connection establishment, we should restart it.
-	 */
-	hci_update_passive_scan(hdev);
+	hci_connect_le_scan_cleanup(conn, status);
 
 	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
@@ -1240,7 +1236,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	hci_dev_lock(hdev);
 
 	if (!err) {
-		hci_connect_le_scan_cleanup(conn);
+		hci_connect_le_scan_cleanup(conn, 0x00);
 		goto done;
 	}
 
-- 
2.39.2

