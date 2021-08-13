Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC47560F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhHMMVn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbhHMMVm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F956C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11-20020ac85a4b0000b029028acd99a680so6261701qta.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nSdtwf8edjqkvQpKOKp6xr2CCq6fB+GF7AwcpC/+Jpk=;
        b=KyLjd0ru4w7yVJLNDiNfXI6o1n7o15y16AilMV3RucZKe6cODe2B/c0MXTeK5RmjeZ
         qmWkNpXuz7Gxk3i/Xx91RSqI+W4fLeafBzZLXPl6FEEk0omq9yEISdDA4e6DAhWoEpfA
         OkNV0ZxJqHTM0gct3g4fo4ixsNExVwPSymdcML71lb/FI6Hnuwev1S3YX5WZiFuNFoyr
         Kh/TO1ohOBPGdyNeViXv1oXqo8ZYFYZU/IKpMWRggGpSkDTdueMJ//fRP3DJfxhIBbjY
         SOYGJE3GI1WyfFo5sAqmtcUOH0ExWrzwhNx4UtsXVJNgWwZEB/D25lvs9ijWEHl+AEPp
         RSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nSdtwf8edjqkvQpKOKp6xr2CCq6fB+GF7AwcpC/+Jpk=;
        b=ChqWtT77jufd8dgz8JrF6PfxPjdiJ9AJ6BTSxSjA5cFUGpFqrUJwbqpKg8V4qLgZ4v
         xsPgXcMBLgL1xzbqgL+swkvqC9jlEelSem4d7B1VB1oRwalgj9JlWN2cS4kAgvag/k9F
         UQu0nrdeIXwIwQ68KmQIZqqNwmnguXFWjWvwPBhtDPgD4Jls8W4Klo9zuQFsfUCCsdvz
         H3IgczyWeqq3xt+1/L+KBmVCAWyJN7APkggyPJt2MyuiKz4HO8TiiYcs6WGSmO93u16X
         XPCNJSCSio0dOk69NImvRn5uczWDPYukVxG6YaQEmFzjkz0why/GQk34OxidIxaqevyi
         DUXQ==
X-Gm-Message-State: AOAM532OK5PzLTMwLQKT7WRO2habmtmip5qr9rSsQ0yd7z/o+bwwqwTW
        Lx0XWm+LdXITluKvnQbG3P4Uj8c8vQ3HSTI1mA4oJQrwZhS0fXF+5Zyli6B2vlMN89HPmNeONTr
        Jb3vTiSvpw1o+F9JmmrzYTHtPOCzzi1ahQH/NR1TpVVnepT4OFHji5PtP3AjJSRfag1rJtIGLEP
        vQ
X-Google-Smtp-Source: ABdhPJxIU9pchhWJF+KSFIDxvP6uMjm2uIrIqG03g0c6Je82fDA9/cIOkWDbrEhR/LkCqup7QD3ehfDDMQtW
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:e4d:: with SMTP id
 o13mr2352142qvc.62.1628857275215; Fri, 13 Aug 2021 05:21:15 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:12 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.27.I993304df2b51028719fee894c1c78c320719096a@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 27/62] tools/3dsp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec 5.3.
---

 tools/3dsp.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/3dsp.c b/tools/3dsp.c
index 5227c30b63..267a39e904 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -112,10 +112,10 @@ static void start_inquiry(void)
 						inquiry_started, NULL, NULL);
 }
 
-static void set_slave_broadcast_receive(const void *data, uint8_t size,
+static void set_peripheral_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
-	printf("Slave broadcast receiption enabled\n");
+	printf("Peripheral broadcast reception enabled\n");
 }
 
 static void sync_train_received(const void *data, uint8_t size,
@@ -149,7 +149,7 @@ static void sync_train_received(const void *data, uint8_t size,
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
-				set_slave_broadcast_receive, NULL, NULL);
+				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
 static void brcm_sync_train_received(const void *data, uint8_t size,
@@ -183,7 +183,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
-				set_slave_broadcast_receive, NULL, NULL);
+				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
 static void truncated_page_complete(const void *data, uint8_t size,
@@ -209,7 +209,7 @@ static void truncated_page_complete(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void slave_broadcast_timeout(const void *data, uint8_t size,
+static void peripheral_broadcast_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
@@ -226,7 +226,7 @@ static void slave_broadcast_timeout(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void slave_broadcast_receive(const void *data, uint8_t size,
+static void peripheral_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
@@ -327,9 +327,9 @@ static void start_glasses(void)
 	bt_hci_register(hci_dev, BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE,
 					truncated_page_complete, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT,
-					slave_broadcast_timeout, NULL, NULL);
+				peripheral_broadcast_timeout, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE,
-					slave_broadcast_receive, NULL, NULL);
+				peripheral_broadcast_receive, NULL, NULL);
 
 	start_inquiry();
 }
@@ -381,7 +381,7 @@ static void conn_request(const void *data, uint8_t size, void *user_data)
 	start_sync_train();
 }
 
-static void slave_page_response_timeout(const void *data, uint8_t size,
+static void peripheral_page_response_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
 	printf("Incoming truncated page received\n");
@@ -389,8 +389,8 @@ static void slave_page_response_timeout(const void *data, uint8_t size,
 	start_sync_train();
 }
 
-static void slave_broadcast_channel_map_change(const void *data, uint8_t size,
-								void *user_data)
+static void peripheral_broadcast_channel_map_change(const void *data,
+						uint8_t size, void *user_data)
 {
 	printf("Broadcast channel map changed\n");
 
@@ -447,13 +447,14 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
 }
 
-static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
+static void set_peripheral_broadcast(const void *data, uint8_t size,
+								void *user_data)
 {
 	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (rsp->status) {
-		printf("Failed to set slave broadcast transmission\n");
+		printf("Failed to set peripheral broadcast transmission\n");
 		shutdown_device();
 		return;
 	}
@@ -493,10 +494,10 @@ static void start_display(void)
 						conn_request, NULL, NULL);
 
 	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT,
-				slave_page_response_timeout, NULL, NULL);
+				peripheral_page_response_timeout, NULL, NULL);
 	bt_hci_register(hci_dev,
 			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
-			slave_broadcast_channel_map_change, NULL, NULL);
+			peripheral_broadcast_channel_map_change, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_SYNC_TRAIN_COMPLETE,
 					sync_train_complete, NULL, NULL);
 
@@ -512,7 +513,7 @@ static void start_display(void)
 	cmd.timeout = cpu_to_le16(0xfffe);
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST, &cmd,
-			sizeof(cmd), set_slave_broadcast, NULL, NULL);
+			sizeof(cmd), set_peripheral_broadcast, NULL, NULL);
 }
 
 static void signal_callback(int signum, void *user_data)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

