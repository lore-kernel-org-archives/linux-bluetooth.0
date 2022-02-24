Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBXAbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXAbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17986E284
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so549046pjw.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CB84GU+65qC35bo/M0ozl8Z6qSqDAdXZpXKDOuBUTfg=;
        b=Htw1oY/CJE7Xn7jDLa/yvuA/LDVVU+TLOvbOOsRmgm3yZvbNIxrGXAruT6muEhOWT8
         PM97EzLkFcm6igjeSPHDKtZ4hgOMafo0YI/1rJ1UINTzII9Gvw7hp8+h2G3WD1Dpy3oc
         ewjqJPvYrX62U3xOL7MwZW78+P3ufcGbGbNf0IqMjmJLSYhGyzZ4Dp2Or3J1VD6KD4Ca
         Lqrb+obpfpU3elOAZmmkJnoIeJyBe//SkNNhg9BUa3oH7vECQUdry2LXEIN3vXiP39uO
         0wdAfESV47i6UKWguLcrRw2x7aBTKAyYsoYLXetFd+dl7/+4n+E5rLzwOsOlF4zA1Emq
         P9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB84GU+65qC35bo/M0ozl8Z6qSqDAdXZpXKDOuBUTfg=;
        b=Pzj9P+P2QeqTg+70+PGjN2kPjlc4wMwDbUMFjTPQ17SZ04PxWWzOfQgFcYIw9EvwIq
         9ZGSCKP2EhMSBz4NlP47NI3xehEJKnLEMvZwTPvq5OMT0A/ea8wPs78pjT7CtvzEZyqu
         x+RlNDnWfKhanXJHXLHwsBmzbqtRmc2hGtaMmKcmZKDr3XAn8LsvuLYOfj0kwgINtpBg
         Ed5VRw8glGOV/Fe0ZtBTGKjH8SLDEds0jq6AC6Po4d06Yo56dK7g2mv1lKwAFZnijoUH
         qdvRaKrGilCypp/l5QSheSIWGmWpvbd8yWrcBRwcvZsK6JtlfC3U9eh5GOGOpdpwljRD
         JFlQ==
X-Gm-Message-State: AOAM5334zEEbl4niwy/ntJ1G4o5199w0WDZ76lXEByPhhLw5a0RNlM5m
        Y5Rzm7TLTr/Opk0q7N7oIAdkuoxDLns=
X-Google-Smtp-Source: ABdhPJwnzInCYKP2gmpVhABYSgZnKPSMLtG/+QQzeAz7XbKl+4NbvEWOvTe4uJsZDysL7O8i22x/+w==
X-Received: by 2002:a17:902:b485:b0:14d:77eb:1675 with SMTP id y5-20020a170902b48500b0014d77eb1675mr165117plr.147.1645662635188;
        Wed, 23 Feb 2022 16:30:35 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/11] btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED when scan is initiated
Date:   Wed, 23 Feb 2022 16:30:23 -0800
Message-Id: <20220224003029.706163-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sends BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if scan is initiated
while BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC is pending.
---
 emulator/btdev.c | 152 +++++++++++++++++++++++++++--------------------
 1 file changed, 86 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 15689137c..59014b535 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -197,6 +197,7 @@ struct btdev {
 	uint16_t le_periodic_max_interval;
 	uint8_t  le_periodic_data_len;
 	uint8_t  le_periodic_data[31];
+	struct bt_hci_cmd_le_periodic_adv_create_sync pa_sync_cmd;
 	uint16_t le_periodic_sync_handle;
 	uint8_t  le_ltk[16];
 	struct {
@@ -5160,6 +5161,85 @@ static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
 	}
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
+static void scan_per_adv(struct btdev *dev, struct btdev *remote)
+{
+	if (dev->le_periodic_sync_handle != INV_HANDLE ||
+				!remote->le_periodic_adv_enable)
+		return;
+
+
+	if (remote != find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
+						dev->pa_sync_cmd.addr_type))
+		return;
+
+	le_per_adv_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
+}
+
 static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -5174,6 +5254,7 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 			continue;
 
 		scan_ext_adv(dev, btdev_list[i]);
+		scan_per_adv(dev, btdev_list[i]);
 	}
 
 	return 0;
@@ -5301,76 +5382,16 @@ static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
 
 	if (dev->le_periodic_sync_handle)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
-	else
+	else {
 		dev->le_periodic_sync_handle = INV_HANDLE;
+		memcpy(&dev->pa_sync_cmd, data, len);
+	}
 
 	cmd_status(dev, status, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC);
 
 	return 0;
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
-		const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd,
-		struct btdev *remote, uint8_t status)
-{
-	struct bt_hci_evt_le_per_sync_established ev;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.status = status;
-
-	if (status) {
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
-	le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev, sizeof(ev));
-	send_per_adv(dev, remote, 0);
-}
-
 static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -5390,7 +5411,7 @@ static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
 	if (!remote || !remote->le_periodic_adv_enable)
 		return 0;
 
-	le_per_adv_sync_estabilished(dev, cmd, remote, BT_HCI_ERR_SUCCESS);
+	le_per_adv_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -5416,8 +5437,7 @@ static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 	 * the error code Operation Cancelled by Host (0x44).
 	 */
 	if (!status)
-		le_per_adv_sync_estabilished(dev, NULL, NULL,
-							BT_HCI_ERR_CANCELLED);
+		le_per_adv_sync_estabilished(dev, NULL, BT_HCI_ERR_CANCELLED);
 
 	return 0;
 }
-- 
2.35.1

