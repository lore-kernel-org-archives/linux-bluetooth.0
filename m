Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CD33CE86
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916407; cv=none; b=pRSRxGlzDJ+9KjqDuOTTUQqZvaj6nDS4Ntmb6MT7oxMgnfnMtM+eFFrgrrzzqrAM0WDlLwrzyNEwlEriBgueRNsrYHLGU0I5UsMjHvotcoz7Vho6LY+uZZFnrGQRoRii2LgWOSrxWySaqw05CYAUOcsPhpF5QVzpLinEa0HDwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916407; c=relaxed/simple;
	bh=PYZbFEmYUpWWrgQTqXVPvlTnWJtE/AdAjggyNTHliqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twns7lh0z0UFXZx7DPw0moGOpMlc8fLCOfUND+7nfDBte+be1OSYdbXOZzvcAbttRX2rOdQBZDi0vsPVNCdqQNx3q1oVz5Lq+Jm252bQVwWx6XQFt7Ir/3k9E3A3Cl27VcqtzZBusOgdcEUKwmX4snrD0Ud22y2N1FjZTtblHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=uxEIx0oa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="uxEIx0oa"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4602e2a0372so2903777f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916404; x=1781521204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEEIrB+R5pSSDHSkkuWP/0OiHHc+/Q7WebsY0Xu8rBc=;
        b=uxEIx0oaLUa7UAgFZQuE7mZIkG5Ip1gsgpzOCZN7dQkY6GMdx6Gc02qGQ98DaZlspA
         3mLtszNv22vfvXld7KoyAsbblbzCBq286eW7WyabTlHHVAjJkttNMn//MmadXSSqLaAb
         0zomaX7/M0Wp8FOQQwHD9VGL+RYDBANZUdl0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916404; x=1781521204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEEIrB+R5pSSDHSkkuWP/0OiHHc+/Q7WebsY0Xu8rBc=;
        b=PET73d69I3r2ozI1BMxtP5rqAojvBhgGd0/dQHnMwejtCLKrs00w8HrZdMRB333uTq
         wCKwSeRNa7lJ8dQEJbtFAc8yZlwVrvuYB1h1uc0NLz0PSJgZzUAi/yoHucrNoslWeTj2
         p/9ayHwhSJU3KjU5Of+jmj1ax4P8XrCP/xRyOM99ohwaRRXR1MJmc1QZyjt9V9X2oToj
         pL00YxFIwelXwOe+VYj3yBqP52+l3d2VolHGiM/ND/GP6gJfTeYoISBi4kixoamGzLHQ
         lIOtyT1UYF1N1muy9hDM/4x9dBph67iPZuVISqtI2pqNLCV4ILCiDL9HAAygHGVv425I
         0MpQ==
X-Gm-Message-State: AOJu0YxsX0wZxok0K4yhHATopSlf43niJMhh98XMeDhqAfYYzxdNRukZ
	4u98Ni3PJeu4J7mAVogdcwta7MmwCOtzYiM9td73H894STm7T5RECF7Um2botMF5Mi43+/bCiQ6
	FwRUX
X-Gm-Gg: Acq92OETbG9mqESGtoUvPNugopK4CqnokfFFhmgRPHdPKG8JjXUqyZKwgw0ylKoaUYI
	aU2vy9c7eNFdMBpFlQ2IV2VMRF0IUprtlIs1nzSYpnDrocThWjCw3uV3NN+RT/6qg3YVVtHTFPf
	LGH4Y32/vFf4HBFRXLIqmJ/77HacBUJPHfd5uocVpdVTXnC6MVgy2BsYjc8RI7dSC5yd25gn4Tf
	o4FRocifiB2MqvcLSkSY6MMnwk8WGse9K0AXDdQKNzyGsLSkgJCiCmSQam1fT5GOkIBnpsY+Ide
	XSR71rBtWzG3FmPu0KrrB8ZSwosyqL9/bv7lIlK1jQD513Yu/tLVfQcT1FD9pqoOkN2nqZIBn5B
	P+rcvhXWvmVvuRtiHtD2RawtUIyOx0s0vIqnVMN6k18BG4rWOjF+MnmBFRH8t9mvXHnBWadL0Se
	oz9r79495FNqgVyhEVS79TG0TSxsTAhKc7WwFltMqFZ+NQ2Wcu0rh6bQ==
X-Received: by 2002:adf:f78b:0:b0:460:1957:1b33 with SMTP id ffacd0b85a97d-460304ec1b8mr17052675f8f.3.1780916404097;
        Mon, 08 Jun 2026 04:00:04 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm93113112f8f.29.2026.06.08.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:00:03 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/3] device: Refactor device_discover_services function
Date: Mon,  8 Jun 2026 12:59:50 +0200
Message-ID: <20260608105952.3683040-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
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

