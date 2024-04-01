Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E4F9DF
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997894; cv=none; b=B3cq6f25GXf6cJCF+YuDbFwqnbpHcN9aJqk9VCifzJCGL/nA3oojqGSsbTQ8UoTH0pUiLQvS1+kT8m9sC+Du/uu5QerxWWAcinTzz5LtfDWvIfNokQ3PlpuoTe7u3WabwY5lf7gm6ww5tG0cs9D3EbLGmN3+xlJ+8hHJdIUdriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997894; c=relaxed/simple;
	bh=jc27TBSDxlljRPF07T3OnDVRGhlpgDIJWgSIqWSiYiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f7W9a0JVEeH9A6+xazDsrEnC/AHcarHVHIpX7LahXfTgMOfWUlRiwlPNsrHX7IeJ7iU5zr2qgyNGRoWl9s97tj8oHy16fRXGZ/2JoJhaYK0PYwzihA9qo7OoHkxrMHzTZ6XWQKQdWq3bQLfTWoHRGGABXFwYrN/xajl9tkz6HSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBz3o4ya; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBz3o4ya"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a434ea806so47192097b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997891; x=1712602691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=OBz3o4yaFnlio2b2MMhwX97tyoKz1hw9NLa6BFyj4v/PP4dYRNV9UtCx0VncJrM/wx
         khn/fb9fM7Uxp2tj9EPr7uKYu0FBkdeP6JETVGfs+ur4y6vWamFWPagBj3qwiXVs6xWR
         8i/NVJtP44mzHUmW5nr2GzcwVQerQSyk1DGyqRrvKeTtQNVviTnELZupZfHp9zoEl3FJ
         L8m8KyoSoSnJthwXvrtI0D7dEVXSYNtp6xa5/Ap3aUD64C0Ni6O0M07m05aYxMm+XiQr
         4nhN7iW9b8DV+voaIOP2ycqObT1koX8OnWkjqdpsYhLFW41jhIx4MzogtYvX4MKSTSrP
         0ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997891; x=1712602691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=oh2pf1oWwaU0MO+XS79SBmSd7UowHIDPgXgpHrfLx0cwWmttFPMPeL5ErevpdKj255
         z80Pe+v1v8nagpIKXxaAxhwnl8Hh2hqg27/8IJQoctGFxTcG7APiUS2fPhz8LqiUP62h
         GOmHPQWYYyLrUHrY1SeNFa02OqHwNXlpu8aFN1JseCcxsWSwo7MWY1tkTSnw5K8Ux096
         PZe/OjObQzzCu3P4rc8auiKCQveehrNtxG6v5ztJTpGCiHGj+M5VsVHj0SVTAzs32RGk
         dLe+V9kVhEVUnqexI2J50VrLV3ciiKV7k0/2wxZccZa7NoKUDwZxM/CD9YP4RJenhoHA
         m7fQ==
X-Gm-Message-State: AOJu0YwjWaMGKgeJL1E9Gx6R2DAc2Q/DDT5+yaYu7MnfvmMi0V5tExzj
	9JEiGixvCSXlL9zldDBN4Tj0p3nZ9ppu79j5/lFcDv+gnD70Gb81dFlMXE8g
X-Google-Smtp-Source: AGHT+IGeePDJ/1CBvfkj98bCvpFTbn/eSl4jPp8G3uy6fwVnurf0FFV8Tu+lKOQmjp/04L2wZ8C+3w==
X-Received: by 2002:a25:1f82:0:b0:dd0:97e8:74e6 with SMTP id f124-20020a251f82000000b00dd097e874e6mr8361019ybf.55.1711997890844;
        Mon, 01 Apr 2024 11:58:10 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id o9-20020a25ea49000000b00dcc234241c4sm2153739ybe.55.2024.04.01.11.58.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/3] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Mon,  1 Apr 2024 14:58:06 -0400
Message-ID: <20240401185808.2520694-1-luiz.dentz@gmail.com>
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

