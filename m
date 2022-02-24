Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31339C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiBXAbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBXAbB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35A6D96A
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o8so299249pgf.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5GrbTgGybIX7VE+dUMBOi9DeNkU5nTUZSPVbLy7V1tY=;
        b=ibF51VTF3FeXh8q6MWp5ToQ8705jRdam8byOB2Ug9Mp9VkH+VVjiS02GDf0lYd4/IC
         DfskWJrkC3SHjuvrF4xyDwdWdGbjmds4ToIdKTnR01iq92G8CmY8C4+0CX9i3JZV9lRx
         RRt8PZlnqTcUs/booD4mzPH72zfuogC4/VtdCKhPJTa2Csxaa8KvmIn3dJGW4w2kvo+V
         XgZwZZ+WJf6oV64nO2D+0y1ZJoUNm72ak8PbFDigpQBgMuBjT7KFauN9X5rqI+Bztiid
         tR3EUfzO/C2ET2KAsgFO2jOMzg7KmcwKlurX4UpHPqoaVpEWcMXKX31ZagzDmAI4fUcE
         D6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GrbTgGybIX7VE+dUMBOi9DeNkU5nTUZSPVbLy7V1tY=;
        b=qtG/jNeVoKr31Q5Oc2Q5lsycP18A6o9d0iT/d/D3T8i/+g8Wn6qHMjmp2IKysirTEw
         sgc90bNWZe52oXgVxQ31vnvMXqPnX8ag6YkJ4obGZtFgaoEpnL/leWuHcum/rlZ7OjTH
         fYtmXf1XjH8kN1riB+rH9zohqspf2qU4KneTkrG7C+OgWiPSSLE2++g+H99Ub/98m6N+
         Iata7ydLu9oiFqgZothBTVPjeczt7AqNpInzuMEWK9qIMLLvpUsrCRr/vjoQ7RUJgazd
         bw0vzdVuRaLYy1Nj2xH3w2kWQA/1yJiHYPQzlhcMwRCqNlsrcPh/Ho2Km2mbUo7YqXrR
         mSXg==
X-Gm-Message-State: AOAM530uWzxt/QloA5v63EsQnLgsFhJ+6ndruY1GCuAKhbJfp1VKr7iI
        zDQEm1NBG+EeYqISHbYhZgIgxI7/A0U=
X-Google-Smtp-Source: ABdhPJxweJsaulfMnP+WgS53NTnYUdQuz7zql4TL+3nFqKOo08/gf+Vj+IF2I8yBWXaVcErUKlfV6g==
X-Received: by 2002:a05:6a00:15d6:b0:4f1:4a86:b3b with SMTP id o22-20020a056a0015d600b004f14a860b3bmr209616pfu.60.1645662632521;
        Wed, 23 Feb 2022 16:30:32 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC
Date:   Wed, 23 Feb 2022 16:30:20 -0800
Message-Id: <20220224003029.706163-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
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

