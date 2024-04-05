Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F981DA32
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351510; cv=none; b=ETLxujK921rpOuWodTKwXqzsPmUNPmoFUPVMRV/6tFJL6A4ZtH1Kyp4MrJwx6tiAzM1apk4LDD71ytp3rtf4sKyZjMdiyucgsuJlxcejRbcH7j42SO0mhgh8hNSKiwUlyd9Fh1QoZtEubpOLho67JmO0HeIapk8j9ICZETyzBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351510; c=relaxed/simple;
	bh=jc27TBSDxlljRPF07T3OnDVRGhlpgDIJWgSIqWSiYiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MR55tUddJ5jycliccdjewy2v5D1xxjphqtQ/TBUU5iliP0sUBFZ4sFWCf9TQMDpIGr8gvMhVSw7Bew3uRsYNF576PxdMihBSwlmuHn8TZqFeljiT1OhL8GVUr8BmkvELU+s28wjgRqhnuErC1UmuNgewHf8IXSsLlt0aqi/eAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3qgATBY; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3qgATBY"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479e57ff63bso167327137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712351507; x=1712956307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=N3qgATBYyUgWjGgwF2CBAr39oKBsVEadn36cNMt9pyU038nguPJP1SgAU/Cx7oEik+
         M5DFHnPzHH8Pl7S9f5KIQniYjpXKfKXuhuZfk80WpoFTEqyj3qRcfV/rvPuuWhHmGOiz
         SI0HQDbySUowVnNYREWBHY0frItIGpx+mNkQ3I5QjWeyTFFCZ9gKl98ZOBcH4vKglQde
         eQGbFjZX6TwQDmlvRzoENuZPodubII1z3042cYi6wUGtTLaG6Pne09PfydeH8COc4woM
         odlB7hHHH5GbcEA7Dp+IBCRD5LzR5HR1f3wb4O1Z95UNM0HDpPo1D5tC0bhmyPrg9tXw
         WIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351507; x=1712956307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=R+0LzXCDtgEDvjXmI199W6vUA4NFl+4ekdIn+EFVWVKBFzdP2Ic1oaSDYZtBaQYOup
         5KjO71+mIDvCrdAb0iJIS5HyOhHZlcS1MqOP6Helx4IACMBTKxSN6EDbFbggjMrU80CD
         bO7qyYJ6mLa4oDmd78QEFtAwq/hWHduSPySOcgw+FOdX/sjZ/69Eaaf4D6hxr+40xC6b
         VXKFa3evdk/bI+11eGItioc6eoyK2VJUXM9DupmlZbqbtkm7tQElA7ITvVMkytbRr8dZ
         nz8odwn7fgbdkfgxfk3MxEoe+zjUKXaEHFX+vqn0akzvAfXyTcoAEcnWxtreQnxyRKRc
         iLUA==
X-Gm-Message-State: AOJu0YyBfbHV3ucNaTYPikRI4YsqyW1by6icA9wOqzeKjjcKACcelXZQ
	0dvEQlDu7lQAcmhW+iQeCxQCeG8dCKEhdEr5SJaKaeLxiAz6d7Iaq2oI1qME
X-Google-Smtp-Source: AGHT+IHuuYN+3moh7vrMn2KCJiPpqtA0Nw0zCzuJmbXs1NYW8QarrieBc2DHBtISh2CVnW2S785bOA==
X-Received: by 2002:a05:6102:4703:b0:478:406a:cbf8 with SMTP id ei3-20020a056102470300b00478406acbf8mr2179966vsb.35.1712351506817;
        Fri, 05 Apr 2024 14:11:46 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056130291a00b007e3d1347195sm306723uab.3.2024.04.05.14.11.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:11:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 1/3] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Fri,  5 Apr 2024 17:11:43 -0400
Message-ID: <20240405211145.3463154-1-luiz.dentz@gmail.com>
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

