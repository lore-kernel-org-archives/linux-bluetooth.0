Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0E25D52C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382891; cv=none; b=JwDYUtPBTPlBsTah2nSue3KmZ121PI6GYHmIgYl40pwsynUoPfbC+SRsyDbRHSyRxmWxF3hVXKWbsgBLDGLaE3byiAquizwjNBcVgwTSpZyhpLXeLX7jAZkG3jhbvlrvZPiXj6yGY8oxXr9gEKl1b7r5EwUlZrL1NHYh5QfRer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382891; c=relaxed/simple;
	bh=c9/7xde9jhjClU1ixWMvVApijX63T2TnaygOadv+8to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVdjhmV7V1npcZE4oEXiUQezlV/AEyUotjB/ERWkT1AZ/qQGNZJIriV+TgWgtZApOFalmHLey8fur+Bm8yZeMN7J3jBp6Px1oIiEEIn3W4IymfUSQoaDI/MhNkcDJNc8thSNCKRspMKHeb1fn2hHWq1R1siZXxoTwbWWiMw/haU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCYKpLpl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCYKpLpl"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso834442a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382888; x=1739987688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq+Ec8GvVS0HatXkMf7Y28pt8Vi5KFMnK3HW4hVGP/c=;
        b=jCYKpLplXIpIQIs+knx5Umfj/gOgc7mTbdql1E/Ut3Z0/ALMRFUyrvscPZ2G8ljnCZ
         /9LTcCZT9Lk0v8OlPBLPykHb+6HOY67pvNbR5xbvnvpBloJjCj0Ii93ZMRz+GvHlOT59
         aXgc96Qnd0vICr0oZ6zn/0ZOgrXdIc2i3c5gv5q3CJgSCcPizzGYkDAiXPIt272v6aqv
         +VwZJ7LgM9TWjilvD+WlXutS7Uj43V7ucx977JvsCfVPuBW1nTgrCf0fB9eC1DgIhOrA
         m4qM3gLkJrDhPcsAJPt2Mp0FnUJrHX02BM2QYLJsYLIL4RcMVzo4471HML0OWO/4ioqO
         P4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382888; x=1739987688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq+Ec8GvVS0HatXkMf7Y28pt8Vi5KFMnK3HW4hVGP/c=;
        b=FxioV7IBmZKLH7gb1v4+0QAh4Yuk1HuSyFG6S+wBJY4Ejlct3X8fukclZU65OBpbH8
         zRuiBcg585sITPlsDJUR9MGHXVuujLb+14c1yIi1Coz0swbtjaZ8ULoLYY/fYj/qopT3
         oG0srnJfqmrzdSdA+v2qJjXyR4fx59TlPAahgm55w78SYnzN2o1oGrJrsJZ3D4dugnBD
         wrHOejGe8B0KzLdiDkkes1Mac6x7TAsElD5yC7BldboXksmqeTzP29Vak9IYOsCnoKhD
         /lm0S5eG8sJ4hvXcxflYNkLMZ7k7elO66X7XbYUGH88krIAlHVniAMEiM3upeqV79MYA
         7SAg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0NUxoUn2zes0fxUQfAQS+y1FWbL1u+WN8t3W9DdF2iDrkKinl/qZGGOXuJHvFmdeFNozSsf4uqnOZIg7Bw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvWDBF2+GfcoT/rX/DGb8KP3GSP50O/pn0ObzVaXs+61FeAlt
	z5/KRkfYrCC64YUt9mbVaHQQZPva358MDW7FZ/0gWqAiT6CgNB8+
X-Gm-Gg: ASbGncuhAalZEpeq6jyZt9U7pGtrGg4RNiCE3fWWP1Fd70RIMXzYnl952OD92S6s+VA
	kEX4v/x//IrZx6Z174Uoco8f0DCsV/VafvCwpsQfriO4XbgOjUZEIHce2aHNJ4bvVdQJFJlJ5uE
	TC9LN3wdSTi/gENatw7pB6swkTWISvq3zPGjIb5zhf2u1O8NCAJCJR3hsK0st4v8DM5LGgsXiVg
	PpQPND2djqPadKimvAfi7uMfRHR+8n5KggXAp/wyEGzu3FhIn/2qro4bqOSVkaHvt1zRpPRdYhc
	Br0UL38UZ4a7aOijo3wruXe4zqJZGY1mRD/r8Nlcn504oF/DJ8zcA8yp7PO/ULbXFl0S2LsGL8w
	xwrwllJfd4hY=
X-Google-Smtp-Source: AGHT+IFv8/B5HMQQLTOM8A0avq7Qa29lNLfOxP7tcHBFXCQE76yL4PCjyBklLgqW9XfosyZ3h89y1w==
X-Received: by 2002:a05:6402:2353:b0:5dc:71f6:9725 with SMTP id 4fb4d7f45d1cf-5dec9faa37emr143792a12.27.1739382888005;
        Wed, 12 Feb 2025 09:54:48 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7f779d9aesm156314566b.63.2025.02.12.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:54:47 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: luiz.dentz@gmail.com
Cc: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: [PATCH BlueZ v2] btdev: Broadcast EXT_ADV packets every 200 ms
Date: Wed, 12 Feb 2025 18:54:27 +0100
Message-Id: <20250212175427.131356-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
References: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
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
in 200 ms intervals. Such behavior will better emulate real HCI and
will work around the issue of dropping the very first LE meta packet
by the kernel.
---
 emulator/btdev.c | 105 ++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 66 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 60901ba56..fb2f2f41d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -102,7 +102,8 @@ struct le_ext_adv {
 	uint8_t adv_data_len;
 	uint8_t scan_data[252];
 	uint8_t scan_data_len;
-	unsigned int id;
+	unsigned int broadcast_id;
+	unsigned int timeout_id;
 };
 
 struct le_per_adv {
@@ -575,8 +576,10 @@ static void le_ext_adv_free(void *data)
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
@@ -4756,9 +4759,13 @@ static void ext_adv_disable(void *data, void *user_data)
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
@@ -4975,9 +4982,10 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
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
 
@@ -5013,7 +5021,10 @@ static void le_set_ext_adv_enable_complete(struct btdev *btdev,
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
@@ -5032,7 +5043,7 @@ static bool ext_adv_timeout(void *user_data)
 {
 	struct le_ext_adv *adv = user_data;
 
-	adv->id = 0;
+	adv->timeout_id = 0;
 	adv_set_terminate(adv->dev, BT_HCI_ERR_ADV_TIMEOUT, adv->handle,
 								0x0000, 0x00);
 	le_ext_adv_free(adv);
@@ -5117,32 +5128,32 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 
 		if (!cmd->enable)
 			ext_adv_disable(ext_adv, NULL);
-		else if (eas->duration)
-			ext_adv->id = timeout_add(eas->duration * 10,
-							ext_adv_timeout,
+		else {
+			/* Send the first advertising report right away and
+			 * start the timer for continuous advertising. */
+			ext_adv_broadcast(ext_adv);
+			/* BLE advertising interval shall be between 20 ms
+			 * and 10.24 s in 0.625 ms steps. Most devices which
+			 * require fast advertising use an interval between
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
 
@@ -5492,43 +5503,6 @@ done:
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
@@ -5557,7 +5531,6 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 		if (!btdev_list[i] || btdev_list[i] == dev)
 			continue;
 
-		scan_ext_adv(dev, btdev_list[i]);
 		scan_pa(dev, btdev_list[i]);
 	}
 
-- 
2.39.5

