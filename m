Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D016F840
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329479; cv=none; b=PYO2KzhiMwcqGEzN4e42gN0R/fVKlY//tL2DWW382SWDrSrUTOgicUZQz7I2i8D3EiJmAVDPj1mk1bJKBfPg2Y8uI5rJykZl0QfcWnnTacyp61Ll0GniRPhZlFhjOPvUm1KY4s+qgZ1wjRYUrFeXWwV0cdGpDAzeBHDlQQb+Urs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329479; c=relaxed/simple;
	bh=jc27TBSDxlljRPF07T3OnDVRGhlpgDIJWgSIqWSiYiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GLCQJ7w9i37mJKSRBIbQL0WZa0yk/Cp5QHoJ+2VOvMBmzfdR/gXguh9t7dZcZ85BkNNT6UbhvaXTQPlViBblCd8zlHCZnfFLYCUgQSPfvJVzazgFPc8ghMKgakLikZkiHgpkBihST1oDmCnIOHhN2z6Br+XzZMPJ5O0hi0gx8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQi81saQ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQi81saQ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ed075a629so458667fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329475; x=1712934275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=eQi81saQjriXW/oYkKQaQhJtWgy/BHDnIb6yRnWgioNi3DaFll8tlVGgVuqMy83Zga
         kBBOm2coGijxNINJANGIQtlBzfYuUJS2Bn/U3jYKslyEy5zbdbRrqLdI8rYKHOSu7HGs
         eJ0y6IpyWJXBUo5rT9UIjuRhtxw1bN7isMF3ogpqW7ZlIap75UZjASB9pWWo3ygdupQ+
         C4rz12Tinu3LSBEL29Vyzx6A24uJVg4l66oCd5/bVhTYXQJrwgtgSttY3ajJhWBrxZd/
         AIbaWF8RfMRMy8PkQTD8jfEiIhcknVTUMcKahYvhf3py4luB0Ismm3dcxVaWdZhNCyma
         hhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329475; x=1712934275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXA+oiwz2b8EHFOBjQLtlpM7ubcXnMrzwUHSkgQ2sUk=;
        b=KC1elIjkZxokAxqicPplwi4d8ZjULdGqIvyhYGOOPksLDhc6Le/ZtkGFaBScDZ+ON0
         VBUo7EW61E5jXFgrfZMKP6t7OjfGNllVm8FcBBDUc8CE2idGWFwkfBVuYMi0Gq4selEJ
         J7cDTrhZGYMrwBTcW+dD8bNdApEUS7EYJTCKdRhT28216tqUCvYcDBgUFrS8RUfVFR1H
         CBAoqWn0AKF/a9iKfdcCMwndlfR2ce1zQON4x9a2fE3l3H3ZwAoZfcZbJxV4V+MoVXA0
         ZvimnV0noPfC2Gfb30yfMuq0bLkzW1tcRIpb9SnRWRFXZyfLi2hmqeQwq08Q762wpi6x
         bPHA==
X-Gm-Message-State: AOJu0YwkFl11jQiTIRXUUCSJqSXHfEnNH1149Dv+9arjXOx5d54oz0R5
	qJLMKh0HB715vn6I8/vmiENJ8rtsVHpp8ctd1yCeZCPWPk5SggeP+jebDnOU
X-Google-Smtp-Source: AGHT+IECNMQlklHUetqzvw6wwM7qo8fi7/Ylzg9tlbAefO2i7iDyKES+TSJdiXAcSZdaktaC0VaO4g==
X-Received: by 2002:a05:6870:912c:b0:22a:b358:268 with SMTP id o44-20020a056870912c00b0022ab3580268mr2067066oae.25.1712329475116;
        Fri, 05 Apr 2024 08:04:35 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d4c09000000b006e82f65ad4esm306451otf.11.2024.04.05.08.04.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:04:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/3] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Fri,  5 Apr 2024 11:04:30 -0400
Message-ID: <20240405150432.3360157-1-luiz.dentz@gmail.com>
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

