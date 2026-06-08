Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09963B4404
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915161; cv=none; b=i7Z+TwzGAMdk8gHJipnfkt6pabX9HTQIoztHhlTuHdAanCGc86Ozm5tafukug1QY039HjHqRdIu7/pW406uqVOzLcnj/Wun4oSodcOjA+hsxuI7wfbaIT8osSqcqrsy1VSKNrl+CSDC6wNISFy4tX3YJbbRS0aCtT5DBqhCggxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915161; c=relaxed/simple;
	bh=PYZbFEmYUpWWrgQTqXVPvlTnWJtE/AdAjggyNTHliqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7OYuOfdN/6vmL9IoJIVPP3C/k4V/qVw7DQXmJBCYfgTs0KepM3VPCAlIKO//uP9HJ0MM5nVFlb006rMUx7cXKrhHvRTaJ/9nG8YzRjcl+xxbqm40TOvnl9eB/j1VpaWDB3ZseT7tXz5OuWCrzF2iB5XBfmqXoHtSk8cz3wvssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=jkQLROVo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="jkQLROVo"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3001392f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780915157; x=1781519957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEEIrB+R5pSSDHSkkuWP/0OiHHc+/Q7WebsY0Xu8rBc=;
        b=jkQLROVoKxCqlJVVwrZNFeLDt3DqtOKwp6P/osak3LS5d3CzQm94C0i9HvrAoADJ6t
         9hlqoiSLRGgUBaVMNiY8odwaNCm2vgNrfnAMNVTeE6WyNuOpgxnc+Edd80u9fqyiRixL
         DhtXEj2RAu05b0WI0CoGGs4qdBokhvPYn2csw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915157; x=1781519957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEEIrB+R5pSSDHSkkuWP/0OiHHc+/Q7WebsY0Xu8rBc=;
        b=bdjAg22g+QuZJPrNuiswr8t0j+MlP8RoJvSEpxbszVXo6aJQ9BKjiBZEwdeIvwEapq
         xfcMhvmZsd5XuDmm0KTfZ9yJ8+4Mim8nAGFInaMUrTzhkkdMHrnZEolh9COWMyROHHZi
         fJU3Ru1Y+O8c9yAbzorpvWAU6uMhnOSK1/t2aVlGmOLwgJQf1TXaujqKjOTGuOCHTeqy
         csIRpqIJizRdE/0ERUa/0GaNJOUYl5ZLcGMNmDjHxxljiHBtnWqqKy3VpGolup5SLgy1
         huXY24HLWgamn2dsFP2aFITU2FOgLgH/4VCMGsyb7h5Jn/QvX700fM/T4tuz4qZ+iGjx
         0fpg==
X-Gm-Message-State: AOJu0YzRH++5ceGtlKOBIZcn4k5sRXmncsJWCD+HIRHAieMlvAulmkQp
	rqoQtNlsodu2jSc5iQYDfkRCffyS3YCb6Hvw0ZWKfIrbNIF/eDb+CBsAaZLfGtQs14mPjLe8EMr
	ecqBy
X-Gm-Gg: Acq92OEdjo8YsNf+DUFFT/KAvBaMIEoG89q5R1/Y3J12Hj5QYUZiRSQwYdO0wCmToMM
	+tLKX2u7jmxHOPNS28V7FpG3/jl2SrnOEH0HT2mUJLqVjQ6wB6AkSnM7My+ufxh0faOVxUVvObn
	EwkBRkP3Rdi13+csUhMwBXGQ8aLBvZXls+lNteT1kPZm1lT7ZanDUyKxah6jOOcbfIf2CJlMqNG
	36B+LXR5/MEf+RSdm5W9pgdrCbkpOc7veCT43LXvp8weoLFeKf925AoQRVWeIvCcsnd1Zft8Zbf
	zXEMaEUV5sArl9khxwqZognf1uM5fKmyJHwvhNzME9j0X0aln518owUbAe8VSJl6Yow1DLdrmmU
	8FGpA/86gS1J8eiZZdAWbFeGr4R1mzwkCy2LsV4ujGtTdCbOpbDHeKdfFlqnSoR9DtHseUdBCA+
	06jAJSXVgMp15S/b9bJu6fPkdjmfbqdJYI26qhz/qbsJirdJQMd8B/Vtf6vwmS/zHQ
X-Received: by 2002:a05:6000:220f:b0:45e:8526:7dcb with SMTP id ffacd0b85a97d-46032b7355amr21050183f8f.7.1780915157119;
        Mon, 08 Jun 2026 03:39:17 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm92776130f8f.29.2026.06.08.03.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:39:16 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/3] device: Refactor device_discover_services function
Date: Mon,  8 Jun 2026 12:39:03 +0200
Message-ID: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After refactoring we can reuse function once more in function
void device_bonding_complete(...)
---
 profiles/input/server.c |  2 +-
 src/adapter.c           |  2 +-
 src/device.c            | 24 +++++++-----------------
 src/device.h            |  3 ++-
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 97579152e..93c73f8d2 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -102,7 +102,7 @@ static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
 	data->psm = psm;
 
 	if (psm == L2CAP_PSM_HIDP_CTRL)
-		device_discover_services(device);
+		device_discover_services(device, BDADDR_BREDR, NULL);
 
 	device_wait_for_svc_complete(device, sixaxis_sdp_cb, data);
 }
diff --git a/src/adapter.c b/src/adapter.c
index 03593d962..cc753fbd6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3717,7 +3717,7 @@ static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		device_attach_att(device, io);
 	}
 
-	device_discover_services(device);
+	device_discover_services(device, data->dst_type, NULL);
 
 	g_io_channel_unref(io);
 	dbus_message_unref(data->msg);
diff --git a/src/device.c b/src/device.c
index bea893301..0c2ee7d8d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2812,10 +2812,7 @@ DBusMessage *device_connect_profiles(struct btd_device *dev,
 resolve_services:
 	DBG("Resolving services for %s", dev->path);
 
-	if (bdaddr_type == BDADDR_BREDR)
-		err = device_browse_sdp(dev, msg);
-	else
-		err = device_browse_gatt(dev, msg);
+	err = device_discover_services(dev, bdaddr_type, msg);
 	if (err < 0) {
 		return btd_error_failed(msg, bdaddr_type == BDADDR_BREDR ?
 			ERR_BREDR_CONN_SDP_SEARCH : ERR_LE_CONN_GATT_BROWSE);
@@ -6834,14 +6831,15 @@ void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type)
 	browse_request_free(device->browse);
 }
 
-int device_discover_services(struct btd_device *device)
+int device_discover_services(struct btd_device *device,
+				uint8_t bdaddr_type, DBusMessage *msg)
 {
 	int err;
 
-	if (device->bredr)
-		err = device_browse_sdp(device, NULL);
+	if (bdaddr_type == BDADDR_BREDR)
+		err = device_browse_sdp(device, msg);
 	else
-		err = device_browse_gatt(device, NULL);
+		err = device_browse_gatt(device, msg);
 
 	if (err == 0 && device->discov_timer) {
 		timeout_remove(device->discov_timer);
@@ -7354,15 +7352,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		DBG("Proceeding with service discovery");
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
-		if (device->discov_timer) {
-			timeout_remove(device->discov_timer);
-			device->discov_timer = 0;
-		}
-
-		if (bdaddr_type == BDADDR_BREDR)
-			device_browse_sdp(device, bonding->msg);
-		else
-			device_browse_gatt(device, bonding->msg);
+		device_discover_services(device, bdaddr_type, bonding->msg);
 
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
diff --git a/src/device.h b/src/device.h
index b36f9af66..b890f23d4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -207,7 +207,8 @@ bool device_remove_svc_complete_callback(struct btd_device *dev,
 struct btd_service *btd_device_get_service(struct btd_device *dev,
 						const char *remote_uuid);
 
-int device_discover_services(struct btd_device *device);
+int device_discover_services(struct btd_device *device,
+			uint8_t bdaddr_type, DBusMessage *msg);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
 bool btd_device_flags_enabled(struct btd_device *dev, uint32_t flags);
-- 
2.43.0

