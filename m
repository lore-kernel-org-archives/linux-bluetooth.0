Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D83C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiCEBX2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiCEBXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4227656A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso8954026pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CB84GU+65qC35bo/M0ozl8Z6qSqDAdXZpXKDOuBUTfg=;
        b=kr14BqESTdxZ43FFq/qYirg/s7flosm5xqG/R1cSVQhCE/stYxyMKBNrfogWVNsxBR
         vNxSFCxO+uEzgOqSQkA3kUJzo7edlnELd2eE18BN3ukvOCP670kYU1fVvvlcIvNgLevo
         uSADkLlnscChJdhQlMU6X3URjbloVPfcmYzOpCuc1mLopkcIx8kCIs19TSh70PELriTO
         25uu3q7cGY+vK4HQYuchZZgIyH6iZxyNKudkHe9CdwnOHMYTikOwgjUS+IEjNs5x7VB3
         XShRen55Z6+XTc3HraAIOjmb83/v7ZQa7Ap6D6eyDjKmbygAJptS/YVv7NCMatmfIh30
         slzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB84GU+65qC35bo/M0ozl8Z6qSqDAdXZpXKDOuBUTfg=;
        b=S0MqDpnAzlrH94Z3tyHgI2ExMXjAagYLDpVJij2yynM/F23vSas04nFw/OkfyCK1jU
         RTo5QwtzemkCYJvW5Df9FWlyj7Cw/fMia74pkmJNaBWYhAMF/I3+c3+CRezylFSB7qqc
         ZBM+aVrEClcg8oxSvDDNfGE08P7uLtt07cuLhVv0jgqZe7vRvjoZGUQg5of5hGKlt8aW
         2rPRWjN3fa7+y8YEsvyxc0ZBMnzkJLiJaw/2r3Sl0o5WMnZ+3zBEzrQWuZ5sINfIHwPk
         dUKaTCe1fM3gwkyEMPaj2jejfKMF+VJ5OHXamiWqz37oCUYtsxEYNxfvMOWp2f1tdmmB
         ifiw==
X-Gm-Message-State: AOAM532/Cw7OHNqkoas9i5XRJh4iWytkJeSLO32iEgNlbEZkzHjdE7zl
        jbdwDV1YZKhST04vFbah2xqTY0a4Cxo=
X-Google-Smtp-Source: ABdhPJyUU0PnHc8u+NJfdiv+o21Tbt2FeEcpfQ53qA+hD7BnzcQY9iZQaCGU8D4cb2fgwSJTcvr0sg==
X-Received: by 2002:a17:90b:2486:b0:1bc:9d6a:f22 with SMTP id nt6-20020a17090b248600b001bc9d6a0f22mr13557401pjb.211.1646443354929;
        Fri, 04 Mar 2022 17:22:34 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 05/12] btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED when scan is initiated
Date:   Fri,  4 Mar 2022 17:22:22 -0800
Message-Id: <20220305012229.853784-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
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

