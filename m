Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A0CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjJNHrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNHrc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 03:47:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E2A9
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 00:47:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a0907896so731475e87.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697269648; x=1697874448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzFn9lDk3LUoqXcGj6yH4E/e0EbCI1scsgJFKiOR1GU=;
        b=fcqs7FOH58lMP9nJR7ZDjkH1xOfc7Sj1DWMLouPsDAltx92F0nxTJSNDISgDN7b/2p
         QyBjetLdx8MpXLm2WYFBL2NmvbG6fjkYBl7f67DSLp+LX43m2fyY5T/7iSB06XkgT0l/
         wfeOkUE0FRAFKyV0OAsiQuG4ftiyv++lXNGjt+fs8HBX84ZkVej9qv48A2dhYi7m4RH+
         C0CpZGWERjEup1G6QktYrafhKXG1K9mkXyWcQ34PjiHZjvYb9dBL94UtnSpwOFAnkudM
         7hm9s7UepchexPz27aisnS2rACLETodtgmjIabKeRlDANiwD4A1CTc9vtgKp3r4jXM8E
         G6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269648; x=1697874448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzFn9lDk3LUoqXcGj6yH4E/e0EbCI1scsgJFKiOR1GU=;
        b=RUgKC8Bfr2bWEyJFLzXI6GP/NyDd4699oepk/kNqlc8h3oO/QOUjdUatrmanU/FwRJ
         ss/YDX0iSjAd+eLih+HaaCrbQuu0rI4WdHtE1kegQIg60/05TylePPPYtjPJ6vz7+BMm
         XbJ/RD6GoXdBfnwgpMPDA+avaYMfQVK00DM4lT4nNzaQSpsfh+yxkYX3mIRJbeCmCYi0
         jaLhZURnedZWtRPLZoVrm73kyp1YcFWqT8otewt3fy6dizEF8+exr5mcHuDX3d5I89DJ
         fa4Za+qZT7up9vcupibvbBs80zI9KJgly2dduHAYAhpCN47xnEh4CFZKlBOa0WtF/tBE
         Ahmg==
X-Gm-Message-State: AOJu0Yw/4RqO0LE5hKfW/UkmO7Mr4f090rOFK6D/HQ/l7GytmdMESrPC
        w50wMylZU1bFuKbnNBIHIrhD/jTYIBM=
X-Google-Smtp-Source: AGHT+IEVMmwgyzjp4GB4q84+amC8FpoI0q2x3Je2mG6UOeylI5QsmF5KgjpVlo3wAZB7Bqqt8h0vbA==
X-Received: by 2002:a19:655e:0:b0:507:9a32:fd89 with SMTP id c30-20020a19655e000000b005079a32fd89mr3268850lfj.44.1697269648217;
        Sat, 14 Oct 2023 00:47:28 -0700 (PDT)
Received: from localhost.localdomain (46.205.208.24.nat.ftth.dynamic.t-mobile.pl. [46.205.208.24])
        by smtp.gmail.com with ESMTPSA id u5-20020ac258c5000000b005079ab8ab19sm674917lfo.150.2023.10.14.00.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:47:27 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] btdev: Broadcast EXT_ADV packets every 200 ms
Date:   Sat, 14 Oct 2023 09:47:16 +0200
Message-Id: <20231014074716.1866266-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Real BLE devices transmit LE advertisement report packages in given
intervals (typically in range between 20 ms and 10.24 s). With current
kernel module Bluetooth stack implementation it is possible that the
first LE meta packet just after enabling scanning will be lost. It is
not an issue for real devices, because more advertisement reports will
be delivered later (in given interval time).

This patch changes optimistic implementation of sending only one LE
meta packets just after enabling scanning to sending LE meta packets
in 200 ms intervals. Such behavior will better emulate real HCI and
will workaround the issue of dropping the very first LE meta packet
by the kernel.
---
 emulator/btdev.c | 102 +++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 65ad0a40c..3840c6150 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -100,7 +100,8 @@ struct le_ext_adv {
 	uint8_t adv_data_len;
 	uint8_t scan_data[252];
 	uint8_t scan_data_len;
-	unsigned int id;
+	unsigned int broadcast_id;
+	unsigned int timeout_id;
 };
 
 struct le_cig {
@@ -547,8 +548,10 @@ static void le_ext_adv_free(void *data)
 	/* Remove to queue */
 	queue_remove(ext_adv->dev->le_ext_adv, ext_adv);
 
-	if (ext_adv->id)
-		timeout_remove(ext_adv->id);
+	if (ext_adv->broadcast_id)
+		timeout_remove(ext_adv->broadcast_id);
+	if (ext_adv->timeout_id)
+		timeout_remove(ext_adv->timeout_id);
 
 	free(ext_adv);
 }
@@ -4682,9 +4685,13 @@ static void ext_adv_disable(void *data, void *user_data)
 	if (handle && ext_adv->handle != handle)
 		return;
 
-	if (ext_adv->id) {
-		timeout_remove(ext_adv->id);
-		ext_adv->id = 0;
+	if (ext_adv->broadcast_id) {
+		timeout_remove(ext_adv->broadcast_id);
+		ext_adv->broadcast_id = 0;
+	}
+	if (ext_adv->timeout_id) {
+		timeout_remove(ext_adv->timeout_id);
+		ext_adv->timeout_id = 0;
 	}
 
 	ext_adv->enable = 0x00;
@@ -4901,9 +4908,10 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 					1 + 24 + meta_event.lear.data_len);
 }
 
-static void le_set_ext_adv_enable_complete(struct btdev *btdev,
-						struct le_ext_adv *ext_adv)
+static bool ext_adv_broadcast(void *user_data)
 {
+	struct le_ext_adv *ext_adv = user_data;
+	struct btdev *btdev = ext_adv->dev;
 	uint16_t report_type;
 	int i;
 
@@ -4939,7 +4947,10 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
 							report_type, true);
 		}
 	}
+
+	return true;
 }
+
 static void adv_set_terminate(struct btdev *dev, uint8_t status, uint8_t handle,
 					uint16_t conn_handle, uint8_t num_evts)
 {
@@ -4958,7 +4969,7 @@ static bool ext_adv_timeout(void *user_data)
 {
 	struct le_ext_adv *adv = user_data;
 
-	adv->id = 0;
+	adv->timeout_id = 0;
 	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
 								0x0000, 0x00);
 	le_ext_adv_free(adv);
@@ -5043,32 +5054,29 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
-		else if (eas->duration)
-			ext_adv->id = timeout_add(eas->duration * 10,
-							ext_adv_timeout,
+		else {
+			/* BLE advertising interval shall be between 20 ms
+			 * and 10.24 s in 0.625 ms steps. Most devices which
+			 * require fast advertising use interval between
+			 * 100 ms and 500 ms.
+			 */
+			ext_adv->broadcast_id = timeout_add(200 /* 200 ms */,
+							ext_adv_broadcast,
 							ext_adv, NULL);
+			if (eas->duration) {
+				unsigned int duration_ms = eas->duration * 10;
+				ext_adv->timeout_id = timeout_add(duration_ms,
+								ext_adv_timeout,
+								ext_adv, NULL);
+			}
+		}
+
 	}
 
 exit_complete:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &status,
 							sizeof(status));
 
-	if (status == BT_HCI_ERR_SUCCESS && cmd->enable) {
-		/* Go through each sets and send adv event to peer device */
-		for (i = 0; i < cmd->num_of_sets; i++) {
-			const struct bt_hci_cmd_ext_adv_set *eas;
-			struct le_ext_adv *ext_adv;
-
-			eas = data + sizeof(*cmd) + (sizeof(*eas) * i);
-
-			ext_adv = queue_find(dev->le_ext_adv,
-						match_ext_adv_handle,
-						UINT_TO_PTR(eas->handle));
-			if (ext_adv)
-				le_set_ext_adv_enable_complete(dev, ext_adv);
-		}
-	}
-
 	return 0;
 }
 
@@ -5378,43 +5386,6 @@ done:
 	return 0;
 }
 
-static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
-{
-	const struct queue_entry *entry;
-
-	for (entry = queue_get_entries(remote->le_ext_adv); entry;
-							entry = entry->next) {
-		struct le_ext_adv *ext_adv = entry->data;
-		uint16_t report_type;
-
-		if (!ext_adv->enable)
-			continue;
-
-		if (!ext_adv_match_addr(dev, ext_adv))
-			continue;
-
-		report_type = get_ext_adv_type(ext_adv->type);
-		send_ext_adv(dev, remote, ext_adv, report_type, false);
-
-		if (dev->le_scan_type != 0x01)
-			continue;
-
-		/* if scannable bit is set the send scan response */
-		if (ext_adv->type & 0x02) {
-			if (ext_adv->type == 0x13)
-				report_type = 0x1b;
-			else if (ext_adv->type == 0x12)
-				report_type = 0x1a;
-			else if (!(ext_adv->type & 0x10))
-				report_type &= 0x08;
-			else
-				continue;
-
-			send_ext_adv(dev, remote, ext_adv, report_type, true);
-		}
-	}
-}
-
 static void scan_pa(struct btdev *dev, struct btdev *remote)
 {
 	if (dev->le_pa_sync_handle != INV_HANDLE || !remote->le_pa_enable)
@@ -5440,7 +5411,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 		if (!btdev_list[i] || btdev_list[i] == dev)
 			continue;
 
-		scan_ext_adv(dev, btdev_list[i]);
 		scan_pa(dev, btdev_list[i]);
 	}
 
-- 
2.39.2

