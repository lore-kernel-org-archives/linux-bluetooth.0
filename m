Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1431C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiCEBXZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCEBXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AE1B783
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z11so9220180pla.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5GrbTgGybIX7VE+dUMBOi9DeNkU5nTUZSPVbLy7V1tY=;
        b=kKhLU9byVsSBR8dhMqfJZLMSw2ol10UbHYZOeBBL2X+Brd9Szbm+hDorp7fovOL95/
         bn1wJr77U8twJIogjzbGdQj3D7p/2iZeIepMnuesn1SYLWfzjBSylVGbdqoG6rdA4LQF
         a6Ws/L1KAQjnPj1BwWejNh1c4C8pAGDNA8dcUj061kcowpeeEELsDYkcI5QbyNpAsx/V
         UP21Q1M+tOS7EX524bg6ZGVjML6ZoFg0+YqfI58cOsj7SbP8E3EqbOobZSOp85NyGqJI
         Xv9dvtCewzvNtO2KWLKLQeJ8uIZsYmbBRAf1cogthqXPrGurEg2GTlWPPlFIMughwP2Q
         tokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GrbTgGybIX7VE+dUMBOi9DeNkU5nTUZSPVbLy7V1tY=;
        b=XAdc7CJAbo/bBaFau7VvBgoSgtSxvMni9Hd17ClBPNM3PQ5xNWajU7N+JS6qlao+1v
         2NGBrwqF823fumFR5CzyhaIY0Oegwpdp43XBhJ1vDh7+GinuM+P8WF5bRgm7VgBk+oaq
         pNheYqhuNXbPbKCAzYIIItPLR9EL5t9cxItI/98ErvVs+ILPMGlLJYkEfHt4HKtvQoO8
         V19jidq6rGi60yYbn0t9hdRsr8Xd/vjpE5xKMXdE3koKo3784VdXAYF1UVhGReJSgBfn
         FIk5e1cYtUrzDF1k4+q8oM255Cu73bNfnJRMTgT15AQ8cYwT/HupTjld2PS/94h8NrpY
         dkfQ==
X-Gm-Message-State: AOAM532SQr9trcgkqW1KxhhXE+IdjU8gvjIOMZCkyMIFIrdE0BCudDRs
        cgAOHKZ0r9PMWpPhZoMPlsAtrclyFXE=
X-Google-Smtp-Source: ABdhPJx6kEVIfNpiSGQjANMGd3kWTjgh/SwedojKUSac5T11WuyYoluaEG6Dids9UBZx6N04Wq/dFA==
X-Received: by 2002:a17:90b:3ec9:b0:1bf:3158:9057 with SMTP id rm9-20020a17090b3ec900b001bf31589057mr3927130pjb.228.1646443352569;
        Fri, 04 Mar 2022 17:22:32 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 02/12] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
Date:   Fri,  4 Mar 2022 17:22:19 -0800
Message-Id: <20220305012229.853784-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
generating BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED and
BT_HCI_EVT_LE_PER_ADV_REPORT.
---
 emulator/btdev.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 9189e8082..34469d986 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -47,6 +47,7 @@
 #define ACL_HANDLE 42
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
+#define SYC_HANDLE 1
 
 struct hook {
 	btdev_hook_func handler;
@@ -195,6 +196,7 @@ struct btdev {
 	uint16_t le_periodic_max_interval;
 	uint8_t  le_periodic_data_len;
 	uint8_t  le_periodic_data[31];
+	uint16_t le_periodic_sync_handle;
 	uint8_t  le_ltk[16];
 	struct {
 		struct bt_hci_cmd_le_set_cig_params params;
@@ -5294,8 +5296,99 @@ static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
 static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (dev->le_periodic_sync_handle)
+		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+	else
+		dev->le_periodic_sync_handle = SYC_HANDLE;
+
+	cmd_status(dev, status, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC);
+
+	return 0;
+}
+
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
+		const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd,
+		struct btdev *remote, uint8_t status)
+{
+	struct bt_hci_evt_le_per_sync_established ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = status;
+
+	if (status) {
+		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
+							sizeof(ev));
+		return;
+	}
+
+	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
+	ev.addr_type = cmd->addr_type;
+	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
+	ev.phy = 0x01;
+	ev.interval = remote->le_periodic_min_interval;
+	ev.clock_accuracy = 0x07;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev, sizeof(ev));
+	send_per_adv(dev, remote, 0);
+}
+
+static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
+	struct btdev *remote;
+
+	/* This command may be issued whether or not scanning is enabled and
+	 * scanning may be enabled and disabled (see the LE Set Extended Scan
+	 * Enable command) while this command is pending. However,
+	 * synchronization can only occur when scanning is enabled. While
+	 * scanning is disabled, no attempt to synchronize will take place.
+	 */
+	if (!dev->scan_enable)
+		return 0;
+
+	remote = find_btdev_by_bdaddr_type(cmd->addr, cmd->addr_type);
+	if (!remote || !remote->le_periodic_adv_enable)
+		return 0;
+
+	le_per_adv_sync_estabilished(dev, cmd, remote, BT_HCI_ERR_SUCCESS);
+
+	return 0;
 }
 
 static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
@@ -5420,7 +5513,7 @@ done:
 	CMD(BT_HCI_CMD_LE_EXT_CREATE_CONN, cmd_ext_create_conn, \
 					cmd_ext_create_conn_complete), \
 	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC, cmd_per_adv_create_sync, \
-					NULL), \
+					cmd_per_adv_create_sync_complete), \
 	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL, \
 					cmd_per_adv_create_sync_cancel, NULL), \
 	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC, cmd_per_adv_term_sync, \
-- 
2.35.1

