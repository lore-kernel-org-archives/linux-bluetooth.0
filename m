Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4720DDB
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364789; cv=none; b=P/jEValgTk4RvmYLNaoDCKt+DDPKvTJy8Ij7WA2wVKGe2zKdShVk/HYuaYB+kr53G/F2RQsD3s0ldfrtzXXlWBvO9gGuTFkJ8dEdUK1vWgIE0WuTOZmsWdthxikh73tMUIEa//muLCS8i9pk2RpVuqtg8FXY/BCdaAbCmSFoia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364789; c=relaxed/simple;
	bh=b7mIt2us4bSHKZSaNMsSZb63MhUTFWf6H01vjL8E7Fs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cSMFKxMWdeV3RNSeGgrqV1JRjCZF6V9Arh92gmV+8VMjOzIHzqz9kGZVN9xJvFgSqu5zqwcGvGdCs3FENhaoRMA11c/KBUuqbuyvC0FHYiaM2HpFNB5ulm5IemSrqQFdo4+iFCB8Ko2GlXg0EqAIO3ppVLleSs6LgRh34hnckFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1IZfjW0; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1IZfjW0"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d41b1200deso99651e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710364786; x=1710969586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7M6bG98oxEt39U36FkqUwvU3XdWcCNWkTEfwP8528Q=;
        b=V1IZfjW0SGP3+eDHAu9ba9b2HNz8xhq1i1YUGhMBfPD3jzm61XjXhU7C+JL8HYONRM
         ZhfqpGILwRGlpCSuuaF/JLc0LyaWIT23LkFYLjkdKCRoNEB/gbBW8oNILtSATO5Qdm1y
         lFfAcxelKYVGYdnUqX1FhPWRqm8jDfgd60i9/++wiKb/K8Z78TgF4tK8YFBAW3QMX0z/
         IaH/tN8A8sW8KrXs0fK01CpItQ6g7Gsj4ax2+QME//AzezZG8o3usJps4hI5eF6gK7a4
         0uA+K5+Qup4c36pl4QS8JTY5SnTMuQQyDNe4mH7zZBK/m406ImolC+j5jAWVyAibDMdc
         krbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364786; x=1710969586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7M6bG98oxEt39U36FkqUwvU3XdWcCNWkTEfwP8528Q=;
        b=Dhf6fqfGUNwnNhGK4jq7ByVdTN8+Pqj2pL+AJXnxYUcmtZqPDjcfLO1gyLZRKMv7W1
         DI0iw/LQ7lPykkWZKcCyFrK1DHdxCH62S1HNuKR4vheAeCV1hfpDue/soTbpRaIgubWd
         nicOfpiAUWoelVddnyGYvOmhsQgqJvNVjL3/Tl7Y5cX0xWiBXshhYCpb9TKjaJIr70wC
         OfjOw4+17jx9KZWiiv7RfhFR8LXuaGCCZ9xrcBRbjPjPMPwddrJcVr1y9yeCVUpqBjIx
         QFpimbJDJlJ7yF6CgfrK5kIGAqQ06ztqjd4NLLtEYa9Xn6umQ55GiVsOchX+4Of0sxUg
         1mrw==
X-Gm-Message-State: AOJu0YyOj6o7B6CDE/fwGLKqfwFb5PvR7oEIz/GbDJepo9zIBvfsW4dN
	hSuWJfrj78cTqKXioFh2W7jaNSXc3t4rJKbUqTM7fCgauo6rOsxPnJEzARDV
X-Google-Smtp-Source: AGHT+IFGdBNAz/hXM/uzRaRa6vIuQlPMAAeAP125e6JdoPUy9lGKdRu29J+4OBpyjLPN6eJwBqlG4Q==
X-Received: by 2002:ac5:cdd8:0:b0:4d4:872:c68a with SMTP id u24-20020ac5cdd8000000b004d40872c68amr139360vkn.1.1710364786403;
        Wed, 13 Mar 2024 14:19:46 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 15-20020a056122080f00b004d41b9843e6sm30940vkj.12.2024.03.13.14.19.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:19:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input/device: Force UHID_DESTROY on error
Date: Wed, 13 Mar 2024 17:19:44 -0400
Message-ID: <20240313211944.1440225-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If we cannot sent a message back to the device destroy the UHID device
since it is likely that the driver is trying to reach the remote device
which is no longer connected.

Fixes: https://github.com/bluez/bluez/issues/777
---
 profiles/input/device.c | 60 ++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index c4f75c7442e8..8184d7c9ff7b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -105,7 +105,6 @@ bool input_get_classic_bonded_only(void)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
-static int uhid_disconnect(struct input_device *idev);
 
 static bool input_device_bonded(struct input_device *idev)
 {
@@ -314,6 +313,28 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 	return true;
 }
 
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
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
@@ -356,8 +377,7 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 		virtual_cable_unplug(idev);
 
 	/* If connection abruptly ended, uhid might be not yet disconnected */
-	if (bt_uhid_created(idev->uhid))
-		uhid_disconnect(idev);
+	uhid_disconnect(idev, false);
 
 	return FALSE;
 }
@@ -654,8 +674,11 @@ static void hidp_send_set_report(struct uhid_event *ev, void *user_data)
 			timeout_add_seconds(REPORT_REQ_TIMEOUT,
 					hidp_report_req_timeout, idev, NULL);
 		idev->report_rsp_id = ev->u.set_report.id;
-	} else
+	} else {
 		uhid_send_set_report_reply(idev, ev->u.set_report.id, EIO);
+		/* Force UHID_DESTROY on error */
+		uhid_disconnect(idev, true);
+	}
 }
 
 static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
@@ -698,9 +721,12 @@ static void hidp_send_get_report(struct uhid_event *ev, void *user_data)
 						hidp_report_req_timeout, idev,
 						NULL);
 		idev->report_rsp_id = ev->u.get_report.id;
-	} else
+	} else {
 		uhid_send_get_report_reply(idev, NULL, 0, ev->u.get_report.id,
 									EIO);
+		/* Force UHID_DESTROY on error */
+		uhid_disconnect(idev, true);
+	}
 }
 
 static void epox_endian_quirk(unsigned char *data, int size)
@@ -934,28 +960,6 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	return err;
 }
 
-static int uhid_disconnect(struct input_device *idev)
-{
-	int err;
-
-	if (!bt_uhid_created(idev->uhid))
-		return 0;
-
-	/* Only destroy the node if virtual cable unplug flag has been set */
-	if (!idev->virtual_cable_unplug)
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
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
@@ -1087,7 +1091,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		idev->virtual_cable_unplug = true;
 
 	if (idev->uhid)
-		return uhid_disconnect(idev);
+		return uhid_disconnect(idev, false);
 	else
 		return ioctl_disconnect(idev, flags);
 }
-- 
2.43.0

