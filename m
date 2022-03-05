Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiCEBXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCEBXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D52A273
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so8687191pjh.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9UiSChX/MlhykLBJGD3Js3tynaUAJ9b+hYqI4IfTwkA=;
        b=AOTR/MBsuA96MJhVpb/pyOKZ2uVBH8KCtENrFIc7kw/AeUM3ekEB7xP77+1wyiS1Eo
         0qYASJCiEmBMDqsIULkD/YJcp2BK/qjFT8UsDvBe8vQAw6N1OVg1Uylnjhnmi+7fPqFR
         LVtHMSnKPlIGmAOpFk47LEQaOpgpMRWG6TmY4J0XfEGlpC/lAe4F1YwwBQEAIc8aOjdN
         mMoSFWlickz830S4hPmJYNZArVmlZJvHvjBEnhlDeR+PlzDU1kFVAaTNtOgVdcWwwdiN
         /4fnftHBOS97PhgUAYqQEqoWvvs3SuP6oAjWXoKfQJrJ7eqFluHwwptRcpo7kv6dt+R7
         9c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UiSChX/MlhykLBJGD3Js3tynaUAJ9b+hYqI4IfTwkA=;
        b=O60aDIiKscr01OXGIPJKXfR8C9EtHc9wwuZu6Sfzd94mb2WP/6gt/+9NSrEiUTkYtv
         dDBP1BMXKKTI0u3Yc1QqQQu6dNVgtLARAld4lYXrWsffFXpNKk/tzZCoHtXisswWcx4B
         48r064+gPC6EcC65VMtt7H3Zi4GB9N+Sf/dEBxQYCRyo99HDE1kYxhe6J9CZkaA7xsQw
         yTIhUI5JCJU0aGJv7w0O6PsQD8q/tGevyIwcAkWB+KcdjhiKHvM4jh8Vc6kpfjJfhUZS
         TK/tfdBkeFYuWwYXRoRrZbv7FiGULCZWo2Rd0vFrVAu3iNJpd6fisQZ2rZOnmCQYxjzA
         YESA==
X-Gm-Message-State: AOAM532IjoRjTkh9bNTFyYUvk1V+x/RVlz5NfQhCr99XZz3Ev2v1Du/m
        RyRZpRMyNY1ZxpwtZZ/7FWM4epleafs=
X-Google-Smtp-Source: ABdhPJxNUOEboAy1mBNmpa0VHt4W+pry3pkzfEobFfAro4eJN9xJ0CFKTr0FenIHz4wjI4Pyk3ZH2w==
X-Received: by 2002:a17:902:d2cd:b0:14f:c169:dc6f with SMTP id n13-20020a170902d2cd00b0014fc169dc6fmr1114099plc.170.1646443355779;
        Fri, 04 Mar 2022 17:22:35 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 06/12] btdev: Send BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if remote start pa
Date:   Fri,  4 Mar 2022 17:22:23 -0800
Message-Id: <20220305012229.853784-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
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

