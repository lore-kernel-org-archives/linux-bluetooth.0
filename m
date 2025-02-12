Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20601202F7E
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400289; cv=none; b=Gg5AoKyJ9m8/+f9FR+VeeZvETO2916n0pmRz2rASLIGfekpNCa5S+I+zemMLb4AAey1T3HEuTzf/VDDSQ+5RI/VwivrgIr9cJPRzgKMk/qXKSbY7KX9L2hHwZDHS/uFG+CbNhQVWTc/3bHT1kqNYqG+VjTa68W98UgdUsNsPcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400289; c=relaxed/simple;
	bh=dRfGLnUXm/vERklpEcnDy8Y98kdt30aqtjxh2f80RIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h5s+PKK3NmdLY4oTfPMfV5RBArctognIkXx8H9C7n2ucBUf8xKL/yW+MdNDxfJePTMCu1Kc43HTO+g7JGsxG607WVzfB9MRHF8tQDRvAJCNy5T2ner5l3k3i9uaK81TSu0j4g/UTojAWroJY7rNKn4XDJZU/1XmNKa6Y99MlhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbPoi1Pt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbPoi1Pt"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f972c031efso12545687b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739400286; x=1740005086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTfohA9sm8zoLTUzAE59lK1T8lEJy769Bo4iznjUHGg=;
        b=IbPoi1Pt62ZGFJIjPsfxqWNh8bSG4aUQEQQfrPhZ0WM/ZxIqkdE+9rOx6Pgh26HAHP
         kJRD8b2Ajo6Dy3YkyY1sKmBgzbcoVDQyCeXRqrMC/96AbtiGYJ8zbbhF1pOpqir6ZQ+u
         YSShXLR3vHBVCWGUt2t+Wh/fK9G+KgLVDoucWW4bf1VQ4KcHRgYGZ9SWt5f3MVYrXT4O
         1f/7iVuGsrSsi4fs84Oy1p9X22IipkG4may8l96x7AfFCKPBcDHlcjNEg9J/YJ2kk4AE
         HYOWzp4FNaRo9B7VuYW7xUb/6DiEya1zO6zvaozwsCyc3jYY2VVr8X566nX9AlUSF9cn
         5BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400286; x=1740005086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTfohA9sm8zoLTUzAE59lK1T8lEJy769Bo4iznjUHGg=;
        b=Otm0Yk1aV/GbX0RVKx7fRHoFovhvoM22IlsAo+aMc2u8Y/1tB1t5dq3G/HQ+2wsBGI
         0nNFCzbxK3csAy7iyklu4wTdWXduEkhf6PjdwqM6Re+CDXV8XRjQ7qibLARPsdhagKOW
         oB6JtxNlyVBPYmoDrr0mkpZbKadWcQ2dS/hujwyhefmk/IeDSDvp7Up6XET3SA2wjaxV
         4l0MmNJetMHhFJKvIRuv4Dae94/dNAKTaetz5qmYedgChlQE9l+Ar56SajESmcvOYM03
         HsSLwT/jQHNuuWuR9Z1bguKE6csEF35bFM2l+yYe+BgHlucf56eMcsJHDz2hS3DpXJfk
         t/IQ==
X-Gm-Message-State: AOJu0Yx1qRHttB3mia5KBE3et57uD1HCJ0VJ+Xi9D9ENbunbsfa2iEeG
	+qje6PoIII1kZAiO6JG0qVali8Jk4uHNfVrZ0qnvPOeM18Iq2JEj0XOdUYVc0Qg=
X-Gm-Gg: ASbGncsW8SvxAhaSvqCDvKyKCeItWJBtsUg3ztWi2BPlVSNC73XzDcQrmnimrDtVJka
	WPrq5tI3qbLe3M3BtYYZoGBWmKcpJYqI6DpOL/51Ep/11imNWyUi+4/k0avkyGpU3/d8hg37/sh
	BoFauiDEVVKK0ePdsG0ENL/k8HTyMng+fp1LLW4UZU2nQ/1uPewHW5+V4nA5DTdW0LS37mMLbwe
	V+oQ5HWFF/zoFqQVjHS3JBXbdpZSbEDY7hq9fKVD7Cs/CGvroBqumIhpPm6B28cbk0L2d+GOaDJ
	JjYb3q8KcNmazwrx/eLCOdQg8FbeJPX3vvGDjHdaKxm9qxq1iswTlzNiAOcxQvM=
X-Google-Smtp-Source: AGHT+IF4qPVj6sVo0iJkoWxJ/1aXlYQYWK73e+uU2K368E3kmRk6HmorgyD32el8cr1UcDkFpeE/uA==
X-Received: by 2002:a05:690c:6007:b0:6f9:4b81:3dc7 with SMTP id 00721157ae682-6fb33e86b72mr7561337b3.1.1739400286415;
        Wed, 12 Feb 2025 14:44:46 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d58640sm65907b3.7.2025.02.12.14.44.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:44:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] btdev: Broadcast EXT_ADV packets based on its interval
Date: Wed, 12 Feb 2025 17:44:44 -0500
Message-ID: <20250212224444.508659-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>

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
by the kernel.
---
 emulator/btdev.c | 103 +++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 70229d9eed14..b4d336f9e7a2 100644
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
@@ -4861,6 +4869,7 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 		return 0;
 	}
 
+	ext_adv->interval = get_le24(cmd->min_interval) * 0.625;
 	ext_adv->type = le16_to_cpu(cmd->evt_properties);
 	ext_adv->own_addr_type = cmd->own_addr_type;
 	ext_adv->direct_addr_type = cmd->peer_addr_type;
@@ -4978,9 +4987,10 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
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
 
@@ -5016,7 +5026,10 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
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
@@ -5035,7 +5048,7 @@ static bool ext_adv_timeout(void *user_data)
 {
 	struct le_ext_adv *adv = user_data;
 
-	adv->id = 0;
+	adv->timeout_id = 0;
 	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
 								0x0000, 0x00);
 	le_ext_adv_free(adv);
@@ -5120,32 +5133,28 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
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
 
@@ -5495,43 +5504,6 @@ done:
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
@@ -5560,7 +5532,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 		if (!btdev_list[i] || btdev_list[i] == dev)
 			continue;
 
-		scan_ext_adv(dev, btdev_list[i]);
 		scan_pa(dev, btdev_list[i]);
 	}
 
-- 
2.48.1

