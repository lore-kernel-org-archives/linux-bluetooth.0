Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5E12E1F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639978; cv=none; b=cAj6JbH0DSb1/k6C3KG8jp/3mZtjjVmVM5EFExfD1Uk7927AJOdPZ4VaeFDQj8Eeuk22w8+iD9zmhzHo/E+NInzMiVUbbJzJX2+dW2OrrYLcw2RowlxdDhff+9/M1LffuxqR2ZxhC3Ib6LtZOz21raEYcMWfnfOdbnsekTMoF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639978; c=relaxed/simple;
	bh=YrEX1pFaBBCv+85Ax+FgJ0ML0ykxzPK4VpnpOYy7Xdk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CAPzzue5L1lormhosGIq8KP0jPwYWo5mtgZC+EsqNVsLVWgPh/rYZrUABB8RXO+KlRAyF84L05k//xM6ec/aoeOgNLMVZekVM0AiEOgABPkjh5CXXwwgPhAGSgFWFJKp0SSJsrtIqlVQAQ1OP3oLNgfJQUo/m5pvUQp8KZa1m44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNggBMiz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNggBMiz"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-611248b4805so11408697b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639974; x=1712244774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Db/DIkTVVG3EAOgN+gmvaboNMLf6YY+23htotPYKnsY=;
        b=hNggBMiztMUzki3sH4ZtjjLfULOioBLCRSSUpxLQ048+ZcvZQpHC2j4IuNrS1gZsc5
         aUdT/ZxjY+WPlr9aUeFHv1gJ0Sv2K3eNkygTVVBerDpoHH35d2QqTF4X1cD0WtaI3Oub
         XXx59P65Fa/2jQ4pLyTzvlCyu12T7d4RjORgeTJ136qiv+7MIdIEJBlu4P/41AEnzxIZ
         5S30tAjfo2e6o8YNuIUp55n3Ja4B6yI8GjUCFI2G/aTD+kjmNsXCOSQitiWzTskWTUi5
         5qWWTXNiTwfZI/M4zwzmaeg7Nray8r2E01ixR1h5ETRq1TVE158Gyga+cdJmiuQaWMZ5
         h5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639974; x=1712244774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Db/DIkTVVG3EAOgN+gmvaboNMLf6YY+23htotPYKnsY=;
        b=whxzr0lOoX1pe7cknmSjgwyGQOz2MlN5opxJMkoyy+QG2O1E0RzAR8vzJ12U3cAT/+
         IYyqEjAY77gkpG/hAEUik6jyezyeOCUv4rj5K9jA9Zinl2KWv0k8z05pFyLk3Q2ITJfT
         0dgRsaediv547tqtaX9okYAmETz0x1OWN6pd3XTMRICbphaMMUVC6R9/MjeXdKwC0opC
         7wqEs//zRS0ZWUCFvuij10pI93Wh0dZj0NClyCl9AlfJfquevu67OZi8qktnOZ2Vn5fy
         yOBigtCsXtdJRV9i5bKNdhTIpijdJ+CZBl1GHX/ju3385v+YObGWg/4a9bkTesaU3dhg
         qoog==
X-Gm-Message-State: AOJu0YzEyIKVcyNzPNy2rqNxo5yw1CJPnEVkkFoiN+PudUN9lEE0d5G5
	7iOgnQfprY67t2F74TbonxIbFdOzR6pLyf9EsA4zOkISpCFpEJOPN0+H7Duq
X-Google-Smtp-Source: AGHT+IGIiOs5H6OXHbnjzdwq4QUNmU8Q3ZRAVvgDB/1mWZ3VkgLK7FUq8TTIhTTMg+hoLw8SCBm+cw==
X-Received: by 2002:a05:6902:1351:b0:dbd:c442:9e60 with SMTP id g17-20020a056902135100b00dbdc4429e60mr3390122ybu.36.1711639974256;
        Thu, 28 Mar 2024 08:32:54 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 83-20020a250656000000b00dcd3e78d086sm347473ybg.46.2024.03.28.08.32.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:32:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/2] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Thu, 28 Mar 2024 11:32:51 -0400
Message-ID: <20240328153252.1752439-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When uhid is in use IdleTimeout was not taking any effect, this also
attempt to force the destroy the input device node to make it useful
for users that don't want to keep the input node forever.

Fixes: https://github.com/bluez/bluez/issues/777
---
 profiles/input/device.c   | 86 +++++++++++++++++++++++++++------------
 profiles/input/input.conf |  2 +-
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1b28cdc174b1..b622ee8cd681 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -77,6 +77,7 @@ struct input_device {
 	unsigned int		report_req_timer;
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
+	unsigned int		idle_timer;
 };
 
 static int idle_timeout = 0;
@@ -139,6 +140,9 @@ static void input_device_free(struct input_device *idev)
 		g_free(idev->req);
 	}
 
+	if (idev->idle_timer)
+		timeout_remove(idev->idle_timer);
+
 	if (idev->reconnect_timer > 0)
 		timeout_remove(idev->reconnect_timer);
 
@@ -156,8 +160,54 @@ static void virtual_cable_unplug(struct input_device *idev)
 	idev->virtual_cable_unplug = false;
 }
 
-static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
-					const uint8_t *data, size_t size)
+static int uhid_disconnect(struct input_device *idev, bool force)
+{
+	int err;
+
+	if (!bt_uhid_created(idev->uhid))
+		return 0;
+
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (!idev->virtual_cable_unplug && !force)
+		return 0;
+
+	bt_uhid_unregister_all(idev->uhid);
+
+	err = bt_uhid_destroy(idev->uhid);
+	if (err < 0) {
+		error("bt_uhid_destroy: %s", strerror(-err));
+		return err;
+	}
+
+	return err;
+}
+
+static bool input_device_idle_timeout(gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	idev->idle_timer = 0;
+
+	DBG("path=%s", idev->path);
+
+	uhid_disconnect(idev, true);
+	connection_disconnect(idev, 0);
+
+	return false;
+}
+
+static void input_device_idle_reset(struct input_device *idev)
+{
+	timeout_remove(idev->idle_timer);
+
+	if (idle_timeout)
+		idev->idle_timer = timeout_add_seconds(idle_timeout,
+					input_device_idle_timeout, idev,
+					NULL);
+}
+
+static bool hidp_send_message(struct input_device *idev, GIOChannel *chan,
+				uint8_t hdr, const uint8_t *data, size_t size)
 {
 	int fd;
 	ssize_t len;
@@ -191,6 +241,8 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 		return false;
 	}
 
+	input_device_idle_reset(idev);
+
 	return true;
 }
 
@@ -200,13 +252,13 @@ static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
 	if (hdr == (HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG))
 		idev->virtual_cable_unplug = true;
 
-	return hidp_send_message(idev->ctrl_io, hdr, data, size);
+	return hidp_send_message(idev, idev->ctrl_io, hdr, data, size);
 }
 
 static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
-	return hidp_send_message(idev->intr_io, hdr, data, size);
+	return hidp_send_message(idev, idev->intr_io, hdr, data, size);
 }
 
 static bool uhid_send_get_report_reply(struct input_device *idev,
@@ -297,6 +349,8 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	if (hdr != (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		DBG("unsupported HIDP protocol header 0x%02x", hdr);
@@ -313,28 +367,6 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 	return true;
 }
 
-static int uhid_disconnect(struct input_device *idev, bool force)
-{
-	int err;
-
-	if (!bt_uhid_created(idev->uhid))
-		return 0;
-
-	/* Only destroy the node if virtual cable unplug flag has been set */
-	if (!idev->virtual_cable_unplug && !force)
-		return 0;
-
-	bt_uhid_unregister_all(idev->uhid);
-
-	err = bt_uhid_destroy(idev->uhid);
-	if (err < 0) {
-		error("bt_uhid_destroy: %s", strerror(-err));
-		return err;
-	}
-
-	return err;
-}
-
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
@@ -520,6 +552,8 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	type = hdr & HIDP_HEADER_TRANS_MASK;
 	param = hdr & HIDP_HEADER_PARAM_MASK;
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 00a34eb63de1..fc20c58b6b32 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -6,7 +6,7 @@
 
 # Set idle timeout (in minutes) before the connection will
 # be disconnect (defaults to 0 for no timeout)
-#IdleTimeout=30
+#IdleTimeout=0
 
 # Enable HID protocol handling in userspace input profile
 # Defaults to true (Use UHID instead of kernel HIDP)
-- 
2.44.0

