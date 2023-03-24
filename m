Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC8CC6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjCXUpb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjCXUp3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 16:45:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D992213DC1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 13:45:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s19so1852684pgi.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679690728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YS09zI3BeC6qLdy+j8+XLDLQAeP9klu5vA1JknSdI0=;
        b=V/KQRtc5bw/aFMCiTKCRoCl6vzJ8a1TNiYLEsQ9giM6sKD4qcRSqQb3hFYvmhM1exV
         5bbZdWinXYlmt0Xj+PRVJitM8heZ3D6t9a/dNbN4geDD8Hj9OdhxX+MQoqhF/sjQ87Pr
         6UQ/FZn41AdGTS6buP76jYgpq6DL2WzdCSKW7nqXFJeaiVsVKJLJfvi6NFFzGzoG6rlc
         IeWMMKWirTwnAG64pBzC0S8yNx2PlN8EN11txTfjo294Fo3ThoACUktEYa87kAZcd261
         GrSs8tXr0hQqd+czPb4anNLsZmvND+2TYXAgIMNcBMWYejzm89Vccnuj0IPGbRu7XnVz
         D70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YS09zI3BeC6qLdy+j8+XLDLQAeP9klu5vA1JknSdI0=;
        b=4MrEj9xy47MofRTiJ19qG69Cqlm4AgDtZj7CGXPxJtgZxXqbmCG8M00JzVQSDiggz5
         HXiWXiwRjBpteROviS4Y2Fc4nBu81YI+SWOCntmVyPlrXjLpuPJFvdKlnAKYev4Bi9oc
         PHbMCTV6moDKJoIZ7JwUf07kFfYATdaK1TsNAX1IGBuKCFUjTJOwim+S5bgq1pAQV1AV
         QxyBu5rLUUN2a49+EaQF8oQYa8tJJXlr2BFExVO+Sgjs72xiaKAYxfZ5gqehIgDL8elv
         X04jcGUmhcVx3pIx2h9AcFO4FPqRmbme6+QAYRhrOkVceo4FnnfGkik+3PvOdJEvL8xh
         FlnA==
X-Gm-Message-State: AAQBX9dqYxA3+T3P9yR6Ddj643M1grdjOJzSH5SxFrR1A2TcAJ4yqHiM
        VavuwX+9gZgCb0ooVC3yMFuoZAiCeFc=
X-Google-Smtp-Source: AKy350ZWgMbPNiRHKI4ANLjpWHOPvXcnOd4tmMwSHb4q4CQM2AONY/tHVQkM7jum5I1944c0YPOlpg==
X-Received: by 2002:a62:6401:0:b0:625:c9bd:57de with SMTP id y1-20020a626401000000b00625c9bd57demr4164918pfb.30.1679690727551;
        Fri, 24 Mar 2023 13:45:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7804d000000b0062b485b8e5esm1669916pfm.81.2023.03.24.13.45.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:45:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
Date:   Fri, 24 Mar 2023 13:45:24 -0700
Message-Id: <20230324204525.3630188-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 17b946f9ba31..0cd339ba7858 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -88,7 +88,16 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, bdaddr,
 					   bdaddr_type);
-	if (!params || !params->explicit_connect)
+	if (!params)
+		return;
+
+	if (params->conn) {
+		hci_conn_drop(params->conn);
+		hci_conn_put(params->conn);
+		params->conn = NULL;
+	}
+
+	if (!params->explicit_connect)
 		return;
 
 	/* The connection attempt was doing scan for new RPA, and is
@@ -1181,13 +1190,7 @@ static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn_params *params;
 
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
-					   conn->dst_type);
-	if (params && params->conn) {
-		hci_conn_drop(params->conn);
-		hci_conn_put(params->conn);
-		params->conn = NULL;
-	}
+	hci_connect_le_scan_cleanup(conn);
 
 	/* If the status indicates successful cancellation of
 	 * the attempt (i.e. Unknown Connection Id) there's no point of
@@ -1200,11 +1203,6 @@ static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 		mgmt_connect_failed(hdev, &conn->dst, conn->type,
 				    conn->dst_type, status);
 
-	/* Since we may have temporarily stopped the background scanning in
-	 * favor of connection establishment, we should restart it.
-	 */
-	hci_update_passive_scan(hdev);
-
 	/* Enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
-- 
2.39.2

