Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiBXAbD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBXAbA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CB36D94C
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so4644374pjq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5+rBSTF3sbYgAZ1sTD//Ehy88r9kNGpqp/Y56gyqolU=;
        b=Q2gRiI5OUYsIMY/8NAeaqna9sX1WhX4Xzr62c4GdpcOedIRCygTt9lFKGtCdmfPUIm
         GmOEReVS2Q/Py8R36LOwSQsV15BzeTSp9WlAyFSW0TNMotvVH9o91+bsycoTDhCxwvYU
         16cs5LQIMHD8/ZTB0jR6xSB7idzd7Bg+xJouLQ7ICNI1hRHAZ6XOmqH594quP7M0aQRx
         mXFvaL6qwi8A0t+i6ou8xxhY2SAEkmlp2xHcCBiBK3VYOO3hJmeY9ugLfhNDllW8FHUS
         wgtTUtL51UcAT/V1jj3G1Gk7CBw4A+mIRsRlLTEzd/SkMyx6sCrTExdu3SScLg2z54/a
         TLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+rBSTF3sbYgAZ1sTD//Ehy88r9kNGpqp/Y56gyqolU=;
        b=70Z2eVRyu2gVQabR3ntBHbmhtKjwdhHb7upbGsoPbDaBGSC5nO8Eih1obm3EBMgXdq
         Bgn2gjuir0nXBBRZOYKcOK6fyojxBnHbt6GXjxFzjmAGOG8CjXzGVaPS2bDlcpIuNIx0
         xqc2ukimsR6dthK5/ZcPCpo5hp13SQAfjor1sOBtigqPOxbZPgsvMLWQf4JW3lgZyoo9
         TCO8HnHHZJN90xRzNRMwy9Yg7PZmEjNsl0wJXOEDp4fXWTxDp9dM7elWC5HJ0/ZoMAAp
         s+aLV9UVQXIOLEc1/fwDsuSfysOSMtVabnoZ7la9gZepjKALq6znMMwvXMlMgjT3Hkx4
         EmbA==
X-Gm-Message-State: AOAM531LTVl4AbZbRP69ny+1oPS7n1rAGsOyg2kcwyhXC+jItmp/tdE5
        +/yTk9I3NSYh1SSQam76j/PkaicfPJg=
X-Google-Smtp-Source: ABdhPJxLIeI12qHm5SMJYPzoYUtIaqBHV1Rt1ciEx1WOaEVXxFeGIvAJ1lj4/wmnDkFMjGCIrbYHew==
X-Received: by 2002:a17:902:8bc2:b0:14d:6d13:a389 with SMTP id r2-20020a1709028bc200b0014d6d13a389mr70669plo.2.1645662631747;
        Wed, 23 Feb 2022 16:30:31 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] monitor: Fix Create BIG PDU
Date:   Wed, 23 Feb 2022 16:30:19 -0800
Message-Id: <20220224003029.706163-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The PDU of Create BIG is actually fixed size as the num_bis is
related to the number of indexes to be connected and not the BIS
parameters.
---
 emulator/btdev.c | 2 +-
 monitor/bt.h     | 2 +-
 monitor/packet.c | 9 ++-------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 378674010..9189e8082 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5692,10 +5692,10 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_le_create_big *cmd = data;
+	const struct bt_hci_bis *bis = &cmd->bis;
 	int i;
 
 	for (i = 0; i < cmd->num_bis; i++) {
-		const struct bt_hci_bis *bis = &cmd->bis[i];
 		struct btdev_conn *conn;
 		struct {
 			struct bt_hci_evt_le_big_complete evt;
diff --git a/monitor/bt.h b/monitor/bt.h
index 66ed3ef5a..51b1833dc 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2758,7 +2758,7 @@ struct bt_hci_cmd_le_create_big {
 	uint8_t  handle;
 	uint8_t  adv_handle;
 	uint8_t  num_bis;
-	struct bt_hci_bis bis[0];
+	struct bt_hci_bis bis;
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_LE_CREATE_BIG_TEST		0x2069
diff --git a/monitor/packet.c b/monitor/packet.c
index ec779a9d5..a17c632a7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8200,10 +8200,8 @@ static void le_reject_cis_req_cmd(const void *data, uint8_t size)
 	print_reason(cmd->reason);
 }
 
-static void print_bis(const void *data, int i)
+static void print_bis(const struct bt_hci_bis *bis)
 {
-	const struct bt_hci_bis *bis = data;
-
 	print_usec_interval("SDU Interval", bis->sdu_interval);
 	print_field("Maximum SDU size: %u", le16_to_cpu(bis->sdu));
 	print_field("Maximum Latency: %u ms (0x%4.4x)",
@@ -8223,10 +8221,7 @@ static void le_create_big_cmd(const void *data, uint8_t size)
 	print_field("Handle: 0x%2.2x", cmd->handle);
 	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
 	print_field("Number of BIS: %u", cmd->num_bis);
-
-	size -= sizeof(*cmd);
-
-	print_list(cmd->bis, size, cmd->num_bis, sizeof(*cmd->bis), print_bis);
+	print_bis(&cmd->bis);
 }
 
 static void print_bis_test(const void *data, int i)
-- 
2.35.1

