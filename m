Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiCEBXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiCEBXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:22 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80076656A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id bd1so9192382plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5+rBSTF3sbYgAZ1sTD//Ehy88r9kNGpqp/Y56gyqolU=;
        b=AIX0a+jvpvzzGM7soW3THUzWjg7hWBan8r30HiAEvkRtU6GUt/WykLFjFiSgthQqcO
         M59QxvsCFxVmgeJSnuFDylFVZ2tGBQJqj8YJNoIUPKRkdg6Fbq8Log0qvoyIQwOw9Zoy
         QNHJfQGYgvOKS2ygtwcgGgs1f8In1w1r+jUfZvJV4ZZO1Hm8Jf9HDOIWS99upZNymiEg
         qEQBG+GGhhVlXWNcKOi1uVR4zLPzudQVmazVKroPWlG719rHwQWd8Zec+Brq7F3aaUrp
         /beQrQbaAj6AokZAKQ5yaqaMaLdij/S2rWPdy9Pk5dVLkrxvY0IAq2Fj8b+FDYhlIayF
         ak1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+rBSTF3sbYgAZ1sTD//Ehy88r9kNGpqp/Y56gyqolU=;
        b=efp+Act6b2E7/ta/6rmcISDS9Wyidsujq50wASLwTJck3g4cVSPChwlFkcMqzItgIo
         BqIbFteplXRa6oYx0Zxk8uNK2IYGyqG4hqiW+4GW5RReK9l8EF398c+4zMsWaGbH6PA3
         gyJc7fhhhEPef7zsfeqJJVWPGU73qNyaZGDBroMa5/6JrF5OvBwi0Qeg7Yykqkj2e4g/
         SQasU+doLF3himgtqMu1naf2rmhO1HrSZCUTeNoBKSVbbcixR3b4yaNMQHf/r/rOKzcX
         0hUaXRo1xvJAvWFil7HtEpySBG0D6572vBn95VqvJsUitbNIRqOd6dQQtCcuBY7ssfHu
         IBbg==
X-Gm-Message-State: AOAM532PPVFa5sFVSJmGlrpA/SxrucT6pLV8xesEn6Mv+1aXsuwdmuqb
        zjnTcLrQiu1Dhol2TKIs8a3vwqKmYeM=
X-Google-Smtp-Source: ABdhPJx8ti6cWcjtgAu2smAsHE/B624/kMwXAD/hkRH2G0RiHHVhqb3RZzdp4jBeo32sBCBFedhn3Q==
X-Received: by 2002:a17:902:cec8:b0:151:cac8:f0a2 with SMTP id d8-20020a170902cec800b00151cac8f0a2mr1189321plg.12.1646443351815;
        Fri, 04 Mar 2022 17:22:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 01/12] monitor: Fix Create BIG PDU
Date:   Fri,  4 Mar 2022 17:22:18 -0800
Message-Id: <20220305012229.853784-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
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

