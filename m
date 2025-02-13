Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3B221572
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449805; cv=none; b=uhPNd82SAzglppNdH5ct+2vd2bSllTdkcUvg2VU/nrLq5GmEoxhYTg4vooEBpV1Lq02/azfn8yjmUM5ftPO5swVAbozkB5vN8GvR1cdC+HLkSBBHi0hqraKPOebhCd7j6gzWPsuUzOP+qaDnAPVjaMkltTv4crjQX1H9rdspMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449805; c=relaxed/simple;
	bh=O1DBPqIsjvRF6KksfJkmlu/qf7D/OHIR+gXUgpJRlO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNLeYQdGXt1BVqfAb8ZqvDjMASfknbMgeL+p6qVDZD5OE5XNqMxO6jsDIWWFdy6DikBRZglAhS/76i8d98mzXdw2gN4yidsMjxw5UZBynknIRP/ZY2UKKfw7Q/uThBMJBBptOd8kgvW6dnXBYfV2+vAHQ6xThK814YG8dz/7EHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2DY8n5l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2DY8n5l"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7fa1bc957so162737666b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 04:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739449801; x=1740054601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tklDtkFMlQXzWAayFc2jpaYXHdwXkPqP10yjNDgF0gM=;
        b=f2DY8n5lmewCkuGwpTsHUdecWK1k1WAAZ1rdxb1LiWLDvoWOtiXjTmHwct0ZtROBSK
         BLx7bFBm7drLUAZ1+vk5eIzzdcsfPymMzJWt73B+3ktwW67MLkotZoz0NVhGcXOqqw/t
         yV45LAXNTCqmyGSj+x4QZGrw6SLrCAWZctzHVG823mVgmfhtVc5fxZlYZOInUeULk2RZ
         7o3pyvqjkjZcxT0+jKDk9yOiVgeg+a9IsumUnZalmQ0/Di57/w7hid2d/GFx17M6HRM1
         JJP238nmJIfeBQBAsZVVpvorGR0T4HoZcWDYirR5tuQXzmjqyDF14JM0Tak0da7C/s1E
         1+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739449801; x=1740054601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tklDtkFMlQXzWAayFc2jpaYXHdwXkPqP10yjNDgF0gM=;
        b=iMOfe8q9+7nvGnuL8mVJ7apbaTxqtXYtcTwTnw4bCtqbvbNfZiYkAcXEQbsFHM/ZH4
         7UkUh6xUwAN3FIjcugdzCasQ9gAXDTgqzxa2L3iEzYaT2Ysq9fDIToRRFtmIvgem6YTh
         JQY+OwNaN+uAy/p/fQRZT5Rkt59/uVOBTHCuEXgkZcifABHENwLAGaSSnjU8JI2CbpIF
         C9YBzXeWXsQ7DBQaqMQzYes05TvyraYQk1L7CeG2PEVteWbfQGDlluvlc994CqlhkO3P
         Ls7/TaFuMr8WBfG0TFoIq9r1gFmeg075GPNujaNqtMg+vU9t3RrowS0yfyI8O0RigSB8
         dhww==
X-Gm-Message-State: AOJu0YwvQg6QUBkvfdjJdcnTs0IaQaPxLX9X3yB1/W4z2KQZmMNzXGYP
	8TWZRloWHqQutWqMeQz5GZjFBljZtJ6Z69IddGzrhLY1021w+rcW5ku9Rkqd
X-Gm-Gg: ASbGnct7Oz3XxOGBRpYA3rY97S5qwUvQjEbxbU1ohH+2bEcDoKK2mLO1EnHZ9cYav3A
	65qwWAGwpkUZ94M0q0NTh65yrgBMZXwiTotqSnxcLfxvpFdm2yTo4zdJ/NADOJVxY8VgrbNMZjm
	5HHc1elrgHVyqpnwRLr2qUAeRurnkxU/NShW9jNw67PZt4Tht1YlcFBHwHtcZnBdEm8hfj23z3p
	Q+DY9ngT4vejb9d3JzExZEVFFX4D4o04l9ih+xcGD9mR32O3q3w2JHAyDrQng0Sv6FYEpsqMJdf
	8KJsoyn81HB6BKy1gj+x8ShdeTEL3ucGWfTNCbshzCEVZRkImki/DNihvNSnqeepm2E295Qjl6O
	iAjugpFAV5Pg=
X-Google-Smtp-Source: AGHT+IE+choaPYJTtIGA2C8Xvl7z9+bOdiptDczuhXDc/gm98XFrS0/BxlJDDCTIBatkbu9ls1AABQ==
X-Received: by 2002:a17:907:940c:b0:ab7:e47c:b54a with SMTP id a640c23a62f3a-aba5017e74amr312742566b.37.1739449800401;
        Thu, 13 Feb 2025 04:30:00 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232275sm124300666b.31.2025.02.13.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:29:59 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH v4] btdev: Broadcast EXT_ADV packets based on its interval
Date: Thu, 13 Feb 2025 13:29:52 +0100
Message-Id: <20250213122952.138986-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250212224444.508659-1-luiz.dentz@gmail.com>
References: <20250212224444.508659-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real BLE devices transmit LE advertisement report packages in given
intervals (typically in range between 20 ms and 10.24 s). With current
kernel module Bluetooth stack implementation it is possible that the
first LE meta packet just after enabling scanning will be lost. It is
not an issue for real devices, because more advertisement reports will
be delivered later (in given interval time).

This patch changes optimistic implementation of sending only one LE
meta packets just after enabling scanning to sending LE meta packets
every minimal interval thus emulating what a real controller would do
and will work around the issue of dropping the very first LE meta packet
by the kernel. For direct advertising, the 10ms interval is used to
provide high duty cycle advertising.
---
 emulator/btdev.c | 121 +++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 70229d9ee..086885d9d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -91,6 +91,7 @@ struct le_ext_adv {
 	struct btdev *dev;
 	uint8_t handle;
 	uint8_t enable;
+	uint32_t interval;
 	uint8_t type;			/* evt_properties */
 	uint8_t own_addr_type;		/* own_addr_type */
 	uint8_t direct_addr_type;	/* peer_addr_type */
@@ -102,7 +103,8 @@ struct le_ext_adv {
 	uint8_t adv_data_len;
 	uint8_t scan_data[252];
 	uint8_t scan_data_len;
-	unsigned int id;
+	unsigned int broadcast_id;
+	unsigned int timeout_id;
 };
 
 struct le_per_adv {
@@ -575,8 +577,10 @@ static void le_ext_adv_free(void *data)
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
@@ -4759,9 +4763,13 @@ static void ext_adv_disable(void *data, void *user_data)
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
@@ -4782,6 +4790,8 @@ static struct le_ext_adv *le_ext_adv_new(struct btdev *btdev, uint8_t handle)
 	ext_adv = new0(struct le_ext_adv, 1);
 	ext_adv->dev = btdev;
 	ext_adv->handle = handle;
+	/* Default value for min/max advertising interval shall be 1.28s. */
+	ext_adv->interval = 1280;
 
 	/* Add to queue */
 	if (!queue_push_tail(btdev->le_ext_adv, ext_adv)) {
@@ -4862,6 +4872,23 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 	}
 
 	ext_adv->type = le16_to_cpu(cmd->evt_properties);
+
+	/* In case of direct advertising (type == 0x01) the advertising
+	 * intervals shall be ignored and high duty cycle shall be used.
+	 */
+	if (ext_adv->type == 0x01)
+		ext_adv->interval = 10;
+	else {
+		unsigned int min_interval = get_le24(cmd->min_interval);
+		if (min_interval < 0x0020 || min_interval > 0x4000) {
+			rsp.status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
+			cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+						&rsp, sizeof(rsp));
+			return 0;
+		}
+		ext_adv->interval = min_interval * 0.625;
+	}
+
 	ext_adv->own_addr_type = cmd->own_addr_type;
 	ext_adv->direct_addr_type = cmd->peer_addr_type;
 	memcpy(ext_adv->direct_addr, cmd->peer_addr, 6);
@@ -4978,9 +5005,10 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
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
 
@@ -5016,7 +5044,10 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
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
@@ -5035,7 +5066,7 @@ static bool ext_adv_timeout(void *user_data)
 {
 	struct le_ext_adv *adv = user_data;
 
-	adv->id = 0;
+	adv->timeout_id = 0;
 	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
 								0x0000, 0x00);
 	le_ext_adv_free(adv);
@@ -5120,32 +5151,28 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
-		else if (eas->duration)
-			ext_adv->id = timeout_add(eas->duration * 10,
-							ext_adv_timeout,
+		else {
+			/* Send the first advertising report right away and
+			 * start the timer for continuous advertising.
+			 */
+			ext_adv_broadcast(ext_adv);
+			ext_adv->broadcast_id = timeout_add(ext_adv->interval,
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
 
@@ -5495,43 +5522,6 @@ done:
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
 	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
@@ -5560,7 +5550,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 		if (!btdev_list[i] || btdev_list[i] == dev)
 			continue;
 
-		scan_ext_adv(dev, btdev_list[i]);
 		scan_pa(dev, btdev_list[i]);
 	}
 
-- 
2.43.0

