Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC27C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiBPWSj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:18:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBPWSi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 17:18:38 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0C20193F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:18:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id h5so1523668ioj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gy8Q7hwl+Y0piUzmJiK8zHQPZ0ofgoAuSIy6CuzRRHM=;
        b=ERBDA4U2BmbNnIYU23K7qKgE5dhF75zwzJDx7Baps4E90zWU1j2nB4NUstQE0ZQkCs
         4HfwpH4iMM7MpCEIIZuYW5P7VpKNWlJ5EYhdBhipoFfxU/z14e+7rz4xUNBXxwiNN8Qv
         bQwAh9PVly1Q1h1Ts1QVqjZ2BfBdu9KBjk0X37FXcwrUkw7oc0n9kE7Ydm3B2JG8Gkct
         v3NoUsiDg9JNkWtveBQ+SNyaD/nRVwCt30j71zmf2tmSrFLM3AYHO+ZlbIfYWcX1e5Re
         fJY23yNPLffQRcJDnCcqd2q6/BHO9cFqBEIDvu+zIS6QH8Ke6lJLG6nxGA1iowescTVm
         mBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gy8Q7hwl+Y0piUzmJiK8zHQPZ0ofgoAuSIy6CuzRRHM=;
        b=WKFRrtCRChfXfqGrd73091/8neSKfQLic2PJHoeQ44W9gOaPzAjJm9AFxXAHMYYTLq
         moH1+Ik8ica+DwtBq57QAl78Qj9+SdJ2hFHKfMxS5pySXyLsPx+E24NstKOTatuYp+l4
         3VWInyp9woN3heLSVrkkP1nzT3ToRdJZVVVy4Sw4GM8ym3JjuwwdS36lrAjAcP9jMqQC
         Mtw6DHG0hkw69/t0Hf7kL/cT32fLm5x+L8cHwL/+jNjyAMTK0pFejn6hKOgHYcSR9TF6
         Z3T9zCcsyNyHuweDAdeAu5PvSPDbYzMoYTfMjE9I4zueVl/zfMhIjlITImfrYxT7l01b
         Spvg==
X-Gm-Message-State: AOAM532X79XjfOPH/eq1a4bdIJRcdIY9liOPzqbnm9g+EvEBowvPq8qL
        Rvsvm+A+HHzz+YwTlWBvx/7P5rmvQTKEnA==
X-Google-Smtp-Source: ABdhPJw3/YDtZo8Zl+M/ZUZAIjT8Ma2P6KT/6IiSh9pXtuanizJtKQNnAhRnIewsvO3pTqn4Fn8TcQ==
X-Received: by 2002:a05:6638:b1a:b0:311:4aa1:6c36 with SMTP id a26-20020a0566380b1a00b003114aa16c36mr3213383jab.281.1645049904249;
        Wed, 16 Feb 2022 14:18:24 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j15sm608216ile.6.2022.02.16.14.18.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:18:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix not using conn_timeout
Date:   Wed, 16 Feb 2022 14:18:22 -0800
Message-Id: <20220216221822.2694867-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using hci_le_create_conn_sync it shall wait for the conn_timeout
since the connection complete may take longer than just 2 seconds.

Also fix the masking of HCI_EV_LE_ENHANCED_CONN_COMPLETE and
HCI_EV_LE_CONN_COMPLETE so they are never both set so we can predict
which one the controller will use in case of HCI_OP_LE_CREATE_CONN.

Fixes: 6cd29ec6ae5e3 ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9dbf007e3dc7..002f9c5b5371 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3265,11 +3265,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
 		events[0] |= 0x40;	/* LE Data Length Change */
 
-	/* If the controller supports LL Privacy feature, enable
-	 * the corresponding event.
+	/* If the controller supports LL Privacy feature or LE Extended
+	 * Create Connection, enable the corresponding event.
 	 */
-	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+	if (ll_privacy_capable(hdev) || hdev->commands[37] & 0x80) {
 		events[1] |= 0x02;	/* LE Enhanced Connection Complete */
+	} else if (hdev->commands[26] & 0x10) {
+		/* If the controller supports the LE Create Connection
+		 * command, enable the corresponding event.
+		 */
+		events[0] |= 0x01;	/* LE Connection Complete */
+	}
 
 	/* If the controller supports Extended Scanner Filter
 	 * Policies, enable the corresponding event.
@@ -3289,12 +3295,6 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (hdev->commands[26] & 0x08)
 		events[0] |= 0x02;	/* LE Advertising Report */
 
-	/* If the controller supports the LE Create Connection
-	 * command, enable the corresponding event.
-	 */
-	if (hdev->commands[26] & 0x10)
-		events[0] |= 0x01;	/* LE Connection Complete */
-
 	/* If the controller supports the LE Connection Update
 	 * command, enable the corresponding event.
 	 */
@@ -5188,7 +5188,7 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
 					plen, data,
 					HCI_EV_LE_ENHANCED_CONN_COMPLETE,
-					HCI_CMD_TIMEOUT, NULL);
+					conn->conn_timeout, NULL);
 }
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5274,8 +5274,11 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
 	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
-				       sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
-				       HCI_CMD_TIMEOUT, NULL);
+				       sizeof(cp), &cp,
+				       ll_privacy_capable(hdev) ?
+				       HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+				       HCI_EV_LE_CONN_COMPLETE,
+				       conn->conn_timeout, NULL);
 
 done:
 	/* Re-enable advertising after the connection attempt is finished. */
-- 
2.35.1

