Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D01C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiBXAbI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBXAbF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F06E2A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i1so288866plr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9UiSChX/MlhykLBJGD3Js3tynaUAJ9b+hYqI4IfTwkA=;
        b=RXESZudrYFuUD4PHiOgvzTJgdQpp/uHNWhlLtwXW+mpkQbLTJmfcduAJ6yVkStjhri
         1LMiJ+tXuFlkcXTUdmJeaEp4eHE2ogxaODfJXE8/B68OfNbngOdTJF9E39YbR8mdaqOe
         vEyUu3ZoH8Kpj2u3lspZmI3iXhDLN3spPf3dvg8wpTyB9XIla3xOsqL+Rc6mAjDr1Ynk
         hZksKwsi1Yp2zu3jUMg28d2kyOUBenZITGg9AxaPWa3e9zBiadG0VHSNXbrVK8k56Vyh
         bAaYN+9cSXrQFTdQ8wHElkshmkMSMEHg8yNplp//pPlkjdt0McNUsADnMjJ4wQHxPDGl
         aBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UiSChX/MlhykLBJGD3Js3tynaUAJ9b+hYqI4IfTwkA=;
        b=o4E9lmBiKxLBfD13Leca851CS7Qr9dCzadY9l4j6KvRoacjxKCDSXOrl2qroOdquKA
         mUOzGmD+Rjt8PUpp7SAA3fhG1JlxWuJcYrAlbVidcIiwISPY3AOpFNDZazQKmNeIkJfK
         1LqzaH5OVFLYF6AP5J5PhRKyLK7rz48T/l4dqFSeLp3E4h6zlkTXil2KEPUuY2H6B5ON
         q0orItNWHhAAshP+QLZB/nu9tFCUI/IYTi9UMurP9B6h326ookEr9Cjw86DNbKWZzpix
         fsjUaxEnm0Rif9Lz01Os9jF2aJQOnR4qEihuVoTv4IUp5p/Fgg4d6Q6IRw/1lJ5+/4aA
         AV3Q==
X-Gm-Message-State: AOAM5318EcQ2ZAKiDwYlAI6iYrEUCSHASh5RtSl1d/bb693TA3QsSfpV
        ZgQ5UOrX5L9DWLPCRIi61fJh9COI7gQ=
X-Google-Smtp-Source: ABdhPJxn8CE0g5X5KZEPwM0iyNQdJKxlpStymxLDbkMB7nSno6wopXw48sIV/K/Jx5t9JZzyqCLlKw==
X-Received: by 2002:a17:902:8b8c:b0:14e:d959:7bdb with SMTP id ay12-20020a1709028b8c00b0014ed9597bdbmr326054plb.41.1645662636156;
        Wed, 23 Feb 2022 16:30:36 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote start pa
Date:   Wed, 23 Feb 2022 16:30:24 -0800
Message-Id: <20220224003029.706163-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sends BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote device start
to periodic advertise when BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC is
pending.
---
 emulator/btdev.c | 144 +++++++++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 59014b535..e79b0dc67 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5044,11 +5044,77 @@ static int cmd_set_per_adv_data(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static void send_per_adv(struct btdev *dev, const struct btdev *remote,
+						uint8_t offset)
+{
+	struct __packed {
+		struct bt_hci_le_per_adv_report ev;
+		uint8_t data[31];
+	} pdu;
+
+	memset(&pdu.ev, 0, sizeof(pdu.ev));
+	pdu.ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
+	pdu.ev.tx_power = 127;
+	pdu.ev.rssi = 127;
+	pdu.ev.cte_type = 0x0ff;
+
+	if ((size_t) remote->le_periodic_data_len - offset > sizeof(pdu.data)) {
+		pdu.ev.data_status = 0x01;
+		pdu.ev.data_len = sizeof(pdu.data);
+	} else {
+		pdu.ev.data_status = 0x00;
+		pdu.ev.data_len = remote->le_periodic_data_len - offset;
+	}
+
+	memcpy(pdu.data, remote->le_periodic_data + offset, pdu.ev.data_len);
+
+	le_meta_event(dev, BT_HCI_EVT_LE_PER_ADV_REPORT, &pdu,
+					sizeof(pdu.ev) + pdu.ev.data_len);
+
+	if (pdu.ev.data_status == 0x01) {
+		offset += pdu.ev.data_len;
+		send_per_adv(dev, remote, offset);
+	}
+}
+
+static void le_per_adv_sync_estabilished(struct btdev *dev,
+					struct btdev *remote, uint8_t status)
+{
+	struct bt_hci_evt_le_per_sync_established ev;
+	struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = &dev->pa_sync_cmd;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = status;
+
+	if (status) {
+		memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
+		dev->le_periodic_sync_handle = 0x0000;
+		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
+							sizeof(ev));
+		return;
+	}
+
+	dev->le_periodic_sync_handle = SYC_HANDLE;
+
+	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
+	ev.addr_type = cmd->addr_type;
+	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
+	ev.phy = 0x01;
+	ev.interval = remote->le_periodic_min_interval;
+	ev.clock_accuracy = 0x07;
+
+	memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
+
+	le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev, sizeof(ev));
+	send_per_adv(dev, remote, 0);
+}
+
 static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
 	uint8_t status;
+	int i;
 
 	if (dev->le_periodic_adv_enable == cmd->enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
@@ -5060,6 +5126,18 @@ static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, &status,
 							sizeof(status));
 
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		struct btdev *remote = btdev_list[i];
+
+		if (!remote || remote == dev)
+			continue;
+
+		if (remote->le_scan_enable &&
+			remote->le_periodic_sync_handle == INV_HANDLE)
+			le_per_adv_sync_estabilished(remote, dev,
+							BT_HCI_ERR_SUCCESS);
+	}
+
 	return 0;
 }
 
@@ -5161,78 +5239,12 @@ static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
 	}
 }
 
-static void send_per_adv(struct btdev *dev, const struct btdev *remote,
-						uint8_t offset)
-{
-	struct __packed {
-		struct bt_hci_le_per_adv_report ev;
-		uint8_t data[31];
-	} pdu;
-
-	memset(&pdu.ev, 0, sizeof(pdu.ev));
-	pdu.ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
-	pdu.ev.tx_power = 127;
-	pdu.ev.rssi = 127;
-	pdu.ev.cte_type = 0x0ff;
-
-	if ((size_t) remote->le_periodic_data_len - offset > sizeof(pdu.data)) {
-		pdu.ev.data_status = 0x01;
-		pdu.ev.data_len = sizeof(pdu.data);
-	} else {
-		pdu.ev.data_status = 0x00;
-		pdu.ev.data_len = remote->le_periodic_data_len - offset;
-	}
-
-	memcpy(pdu.data, remote->le_periodic_data + offset, pdu.ev.data_len);
-
-	le_meta_event(dev, BT_HCI_EVT_LE_PER_ADV_REPORT, &pdu,
-					sizeof(pdu.ev) + pdu.ev.data_len);
-
-	if (pdu.ev.data_status == 0x01) {
-		offset += pdu.ev.data_len;
-		send_per_adv(dev, remote, offset);
-	}
-}
-
-static void le_per_adv_sync_estabilished(struct btdev *dev,
-					struct btdev *remote, uint8_t status)
-{
-	struct bt_hci_evt_le_per_sync_established ev;
-	struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = &dev->pa_sync_cmd;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.status = status;
-
-	if (status) {
-		memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
-		dev->le_periodic_sync_handle = 0x0000;
-		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
-							sizeof(ev));
-		return;
-	}
-
-	dev->le_periodic_sync_handle = SYC_HANDLE;
-
-	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
-	ev.addr_type = cmd->addr_type;
-	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
-	ev.phy = 0x01;
-	ev.interval = remote->le_periodic_min_interval;
-	ev.clock_accuracy = 0x07;
-
-	memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
-
-	le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev, sizeof(ev));
-	send_per_adv(dev, remote, 0);
-}
-
 static void scan_per_adv(struct btdev *dev, struct btdev *remote)
 {
 	if (dev->le_periodic_sync_handle != INV_HANDLE ||
 				!remote->le_periodic_adv_enable)
 		return;
 
-
 	if (remote != find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
 						dev->pa_sync_cmd.addr_type))
 		return;
-- 
2.35.1

