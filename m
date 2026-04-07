Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD837B40A
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596359; cv=none; b=oMKkbAKBD9YyP4V8zw0xBqpKyKOR2bPBFCnAOhtjYA0lei9Nd1JCf7JKO7m3/IT4j68M16H115KBSgHRpciVsEpKmIPpFhh9cXyd+Ou+iAmDjNHSeCFZjFBX24I6h2UAqrZ+UBbyVzcX6Id0tYYiUD+BwQwNthqmqCcrDeezUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596359; c=relaxed/simple;
	bh=vvIVXxuYZA/DLsldw1f1o9fskWHO2iOLMjvON84Jklk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qn3CJklXowOqiZD3ZQOW9nObXeXKrnZRsIfpWjlcBuPOgGqgHd9yQJK0Y6k1zpN9ux6cOZOdbfLTlYhZqtUBFlTOMvjoWeaT2XSsvZJXSVlrMuyle18tuPUnMN4K4OD7SjEUbgcyOt+0XSMOkZQjrKOewGUGcMptnBI23MdiAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr8hZPDK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr8hZPDK"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5637886c92aso2448340e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775596356; x=1776201156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W57C0Ff/7KB3BDY19KQrtMw5EvzMtCbi5yFFybKv89o=;
        b=cr8hZPDK81uOa/Uzb8ZbT747JT3IhD3BgT+WT6bvMZhh0xpzmWhANBG+rR4VyLgQFD
         akPUTq6geBbEzeqX8tVRyiZ8dJI5AcP+yXhmZs1VfD+IcE8fBO7zg7VfOv2mOv7SLJN0
         wC+WAsrc8d5cpT/XmShZyo8NvMB6F1xBG4rBFHBtU+1VpPB+aFpNiso7qgNyUGGws6jc
         /OmQ37LVPLepSAwy+YeoRIOpxmaRwwZ7ciW4PD5P4PvCVu6w8d/ftl52PdL4sqeKbOHe
         ZHMvGSB9YOnT1kUENm13C72Ng2+3tXHCbsdW0HSIHqN4h+RK1rKAZ/EqqwCaOX2JivFA
         Ql7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596356; x=1776201156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W57C0Ff/7KB3BDY19KQrtMw5EvzMtCbi5yFFybKv89o=;
        b=UE/x6Uh34NfRfpby6Abh44ADYQwWjOu+OOit/W0okzyAEIVTLui5aeHVtmNIdFqRvS
         fxEyCk348FIMHiOR1BhpGy8aKpTtf5M6TXO24TeCZ27B5wGezLOLMsNyCUJZU44HGj/N
         1c/xjCn9RikSgMQnlaRglnFd+TCH7lqrDueXS3Ae+zI38FzLlBJ/vjypNj8TIVGmXbPT
         PsXTRxw4gvzxIHTRPDN7H97kRpKVXhfJbzfc4kKm1x+n2V28QCxvRjcOtxqJH5rGvO75
         CAfUazmICEdYSJLuCw0LP5LSMiDGgtcirpXFxs2GPyof0CGWTgK24w8aTBICqZ428PiN
         InXg==
X-Gm-Message-State: AOJu0Yy03owrLZgt+NryNIoB0Hd3shjBCKvwKBe1uPgbTxSW38S8CCN4
	tfBsCTMytL5dpcb/EwmcgmeBbGegdMKKc5ysZJ0VUwdrruQFBHuyxEpaqUhI9e4E
X-Gm-Gg: AeBDiescU+YCptc33wx9Dl5aejUpR1gZOvaaEKuRQlrZpEBqDv9SW7kp+4rqgrfMEOk
	vnpeFyF4/uWPa1TSeCI9pDPw9bbBLUdl/1oBVyna93+vDoOc1oHQE1h3JRM1Zk3qINUwH6LeMZ/
	+q+pWDC2QKtPEhv26LFxkDAOBjb2QUc9hAWTNLJi7yNqpL0KHVU9A3mhtFVS4D9M7/xmHzG7lf2
	zYVmn9O+g/MTC7so2ltUqTkPRaJ8iwrAk1cAyPasolJ8gCt3qnG/WAQQeDscGNJwEnE9PbP/0m+
	lbBJtgT9wynwzX3FIKwNxfrzXs0bdDJBfkumDqMdREY8tAV6JhipNJFa0zWGvDjs3YPbPYDbdSB
	wfv5Kn3JIMd3rtSoUZ3HHBJF2ttSIB392qWwso6kTR9xSIinqmZKqiM6NE+hxmR3pgYhoqvjT1R
	/9fHAGvf2be0a+mGjflvRFGMJEHNV0P2NuJfKrJJ04V+X9bAUQDZO4yifFyOVzeEXHejm7yFcL4
	S5eWKU+pmAxp9gLAw==
X-Received: by 2002:a05:6123:149:b0:559:5ef5:b196 with SMTP id 71dfb90a1353d-56dab9f94ebmr5445278e0c.13.1775596356370;
        Tue, 07 Apr 2026 14:12:36 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba80290sm19418731e0c.3.2026.04.07.14.12.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:12:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] device: Fix btd_device_connect_services not discovering
Date: Tue,  7 Apr 2026 17:12:28 -0400
Message-ID: <20260407211229.61232-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_connect_services would not attempt to discover in case the
selected bearer is BR/EDR and once discover is complete then it shall
proceed with connecting the services.
---
 src/adapter.c |  9 ---------
 src/device.c  | 27 +++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 04568dae6e98..46b89526fcaf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3686,14 +3686,6 @@ struct device_connect_data {
 	DBusMessage *msg;
 };
 
-static void device_browse_cb(struct btd_device *dev, int err, void *user_data)
-{
-	DBG("err %d (%s)", err, strerror(-err));
-
-	if (!err)
-		btd_device_connect_services(dev, NULL);
-}
-
 static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct device_connect_data *data = user_data;
@@ -3726,7 +3718,6 @@ static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	device_discover_services(device);
-	device_wait_for_svc_complete(device, device_browse_cb, NULL);
 
 	g_io_channel_unref(io);
 	dbus_message_unref(data->msg);
diff --git a/src/device.c b/src/device.c
index cfbde307bcc9..e762aea2797c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2705,6 +2705,17 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	return dev->bdaddr_type;
 }
 
+static void device_browse_cb(struct btd_device *dev, int err, void *user_data)
+{
+	DBG("err %d (%s)", err, strerror(-err));
+
+	/* If there are not errors with discovery proceed conecting services */
+	if (!err) {
+		dev->pending = create_pending_list(dev, NULL);
+		connect_next(dev);
+	}
+}
+
 int btd_device_connect_services(struct btd_device *dev, GSList *services)
 {
 	GSList *l;
@@ -2724,8 +2735,20 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 		return device_connect_le(dev);
 	}
 
-	if (!dev->bredr_state.svc_resolved)
-		return -ENOENT;
+	if (!dev->bredr_state.svc_resolved) {
+		int err;
+
+		err = device_discover_services(dev);
+		if (err)
+			return err;
+
+		/* Wait for service discovery to complete before connecting to
+		 * profiles.
+		 */
+		device_wait_for_svc_complete(dev, device_browse_cb, NULL);
+
+		return 0;
+	}
 
 	if (services) {
 		for (l = services; l; l = g_slist_next(l)) {
-- 
2.53.0

