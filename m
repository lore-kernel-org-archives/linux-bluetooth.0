Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BF41206
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939684; cv=none; b=N9KJjH4OXVM6dprjnTq11/M6lX9Ah6+ym0srAYhYJUAeqggKLit72UB0XTwV9SHS9Y0PGURdoT490gvBaCAtTHZH6YI3NWxMS/6oJrm4/6UJiagiX+pIrKfvOSGDCxVhx4TltHgtGOrxWhwZ/Mg9NS90r2yMKBwffpx6FiemMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939684; c=relaxed/simple;
	bh=VfVIVcbo/fE/aSHGNz+Hrv1ZldpsFHc94vUfaSp0bUk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g9Mb2FSrvpUb83GkDmGHwxd9qvemhzLYpPJzsHS95g3V6tmD+BbigOiPNxRC1mxqFX3C3EDfqFPYl9rd9A0MTzOqIZtTvDInZZBsO4yTPAJICpB2TLf2HL4TWg5Czxs0rQbN7+DVLBMieN8vbGl5u5Hivq2AwleVBr862fQSNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXR0u0q/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXR0u0q/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e162b1b71so5651408f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710939681; x=1711544481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LF1S664mil8PDb8kZeofMd5EY7q01REtMQOrJthdT4g=;
        b=YXR0u0q/a54KT7mLFQ2n3xecqIuRYe8M++/P4dTSRRIfEhkPC4aNfVcY2yZ20wmaH4
         M0KTHvS8PS/AwawkulnhB5cRIYSLXUPJCCIb38az86Ma3G+vzFJTjkizSlxJo0XI7r/v
         Jh7iUttO5BJOGBba8T0o9hg9ZaQ2DKeeYlXMNkGkBQxoZnz5RhaWK3MsiQUOFjBSuruy
         LK1H2UnqBvvN+6RHqwbMmUte8HZuqU0xSDQjTriz3eNVb3SnkwDWmhF2K2rlnE2HShRj
         GcFrSpMWVcpOarE9gipOnr0AinwZlZDf7hDNv8phLDggUU+knz22j/SUdidBHbyCrXRq
         kF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710939681; x=1711544481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF1S664mil8PDb8kZeofMd5EY7q01REtMQOrJthdT4g=;
        b=mBqhbChSskE8FuhwPKTqYn8ojUmNA0JDmBBjdqHnExMZVvVVObJb+xBnKAUKDzK9jx
         zjXlXI2oYp+tC6Mmnuj9C7PWxDW4LxdOZX7DLcetwq73e+rAE5wTVAL89d4Nm18IC6t/
         2mYr41O2Gez7yzarBx/p4fN2cr9yiIn26QmzB7YdeT5t06NzXbrzCBwzppb0sKogXeP5
         MSm5i5fjjbxjZ0Mv2xsD93+YGfWs8BdZvq9YDqU7pXpDEOdWNBoTUFWFIzK8qnPS9uyX
         wLwajeQEJtopxkA2yoqHbBfi9s9ebArxy4zAU7tyOfklSwz0Hh7qcgr0Th4jKvxhIT0N
         7msw==
X-Gm-Message-State: AOJu0YxO20jQYLyLVgUAsnklAm0h4/ncDsujOZgVKnobZaa0YSq/z51o
	2AHtGiwwa2jti+qBvPOw9rtK58nJ2Vxjyx6M9fX0/xvdSeErscoHXLn0DU1apd3uoQ==
X-Google-Smtp-Source: AGHT+IE/P6DjEGbs8KYkYR5W6Ae5mQuq9n6JxB9TxG0xLAJQlCXkRvJWrbeviEh+WoLjYBWcgCrqyw==
X-Received: by 2002:a5d:408b:0:b0:33e:745a:88f5 with SMTP id o11-20020a5d408b000000b0033e745a88f5mr3610394wrp.57.1710939680449;
        Wed, 20 Mar 2024 06:01:20 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id l4-20020adfe584000000b0033e91509224sm14700283wrm.22.2024.03.20.06.01.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:01:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Wed, 20 Mar 2024 13:01:19 +0000
Message-ID: <20240320130119.854959-1-luiz.dentz@gmail.com>
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
 profiles/input/device.c   | 89 +++++++++++++++++++++++++++------------
 profiles/input/input.conf |  2 +-
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1b28cdc17..5c52ec98a 100644
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
 
@@ -156,8 +160,57 @@ static void virtual_cable_unplug(struct input_device *idev)
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
+	if (connection_disconnect(idev, 0) == -ENOTCONN) {
+		/* Force UHID_DESTROY on idle */
+		if (idev->uhid)
+			uhid_disconnect(idev, true);
+	}
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
@@ -191,6 +244,8 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 		return false;
 	}
 
+	input_device_idle_reset(idev);
+
 	return true;
 }
 
@@ -200,13 +255,13 @@ static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
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
@@ -297,6 +352,8 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	if (hdr != (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		DBG("unsupported HIDP protocol header 0x%02x", hdr);
@@ -313,28 +370,6 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
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
@@ -520,6 +555,8 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	type = hdr & HIDP_HEADER_TRANS_MASK;
 	param = hdr & HIDP_HEADER_PARAM_MASK;
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 00a34eb63..fc20c58b6 100644
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

