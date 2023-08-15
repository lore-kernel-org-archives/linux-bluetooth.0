Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F9C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 22:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbjHOWST (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbjHOWSI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 18:18:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D31FEE
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:18:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6887b3613e4so218084b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692137886; x=1692742686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEtttGym/u8sgUzXCm7YcAHUA4L942pJv1+j7zJ3Hn4=;
        b=j9JtVeYSfYvzYgliJA7qthArrwzkYb4f7h9Q7mpIk+z/XJgdP6cG4sYJIya50GJvM7
         S9BVirRqN9KoBL1EFHF3YuiQOTJ0K9ia1dThVIlp+JIN6yg6TRqe4s9YZAUvlkywPRcq
         2xgN/e9cYQG5z07zHaDpgEIPkLDbMUIbH+GuqURJfJiAOkNJgR1E9ENK/vo97WPR37lY
         EwNxvLVkd12ahr+DHtVxX0GADQoRKiF4M1GkkIK322Js6r5qYyXl1fp7iMTdGa3YP5sd
         49C7K33kZ1ifkiFvnFmxUi/qRX9+CkXRRmgLaWFk1GoFC+9HQh3R3Qreb8SUmM+aor1Q
         3qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137886; x=1692742686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEtttGym/u8sgUzXCm7YcAHUA4L942pJv1+j7zJ3Hn4=;
        b=PQZ4Xv1lILPJhFifs/uSamf5wkjiPI1oKhtfQvniyfffp+AnTeefxMVphB4t4WbWQA
         XmwNWAgUZwzaa+PCwkSIrYNKP8T6lTACK9pS2KaXBZcvIpfqEQyDijwpwjkXRrg5Ff4Z
         0nxvcRdaanA4DzejQiVTjLbtgwyaEfmmxXqDMUa+KuU1/cs2UuGUeQn23ZoAXzXE5N/p
         ldU9bnXF8hDDxWRCNcKuBjJnvcokpT/JSSpycdoSzkiaOLPMWHNOXJug6zQ5KwwSLujI
         UFURaF2qP5qq7aw9cUsBee56Pns5wuVSbg8AupSITAhXzNemix2g/KDZpRxmGI2E6/f/
         Z2wQ==
X-Gm-Message-State: AOJu0YzrrbBe6e76cLVp9JdKzlcgg1W+RxulZ9NoBQHv8Atdd1QQfjGs
        4Nf60w0GLhYEmu42PiyShJoYgdBFtXU=
X-Google-Smtp-Source: AGHT+IH9L6OfL1s7UPci47Wr2aw+4hp3WU/C7rxpUAfKT1FwCCmBHFuC7pR8qQvTAiWrVT59TxAhUw==
X-Received: by 2002:a05:6a00:14d3:b0:686:bbfa:68e3 with SMTP id w19-20020a056a0014d300b00686bbfa68e3mr99375pfu.15.1692137885487;
        Tue, 15 Aug 2023 15:18:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b006870ccfbb54sm9751563pfi.196.2023.08.15.15.18.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:18:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL
Date:   Tue, 15 Aug 2023 15:18:03 -0700
Message-ID: <20230815221803.2491905-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL when
hci_le_create_conn_sync has not been called because HCI_CONN_SCANNING
has been clear too early before its cmd_sync callback has been run.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 234746721047..95339623883c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1299,6 +1299,7 @@ static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->state = BT_CONNECT;
 
 	return hci_le_create_conn_sync(hdev, conn);
@@ -1370,8 +1371,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	clear_bit(HCI_CONN_SCANNING, &conn->flags);
-
 	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
 				 UINT_PTR(conn->handle),
 				 create_le_conn_complete);
-- 
2.41.0

