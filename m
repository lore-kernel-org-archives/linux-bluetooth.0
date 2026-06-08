Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87533F8BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916878; cv=none; b=Y2g4LqZur8TO6ZhvOcg67ZpsUmQYCsCjLRO4GHzycd0e4iBQ/23v/FrYYBVTJjrx4g0tOS2aduSQp1UfNM19YL4DtuVglrVTITcNOe8+adRQJVIM300TLYurLfthPv9icQVaVP0l0bs+k7ppVx3MhKEvuhFcjDQkz6anfkd1MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916878; c=relaxed/simple;
	bh=LqZChiKpnVPPERY94kp3SS+0cLX7Q/yApYtZAgaQ+20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI558ReqYO6wkHh4gn/sqA121CkcdS7hzD/8Dj5M+X3fRwHYElYY5XpQS+AFFy1FQTPUKD22Gh3xEzAgjc2YBJ9Ma92sC5I+8mpC6e9B5/vvSDykjFHNpIAC843OGgs3wKBoepGNA38C/fT3ag1NWeLKcZjU4I2rFF2VLHnhQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=dCmFwgH/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="dCmFwgH/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so33920305e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916875; x=1781521675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0/m74EN+ySyH1867CFW5wy2kmo4ZBsaxERqDbYEeiQ=;
        b=dCmFwgH/S961VFXz10R6K/25nLU0lkxB37aVCiT8ogQ1A1pQGkpcQJTMIegKRZBvaA
         8ESDKgAcsAHuB0OC+s4SNZBpmRH1vJ271Wp+nnZDFwLoYmpCEdOFTGQLZXXfGH0wdlxg
         /CoSg9SPPgUgCFoFni0mpUT1QADm0/foYmb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916875; x=1781521675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K0/m74EN+ySyH1867CFW5wy2kmo4ZBsaxERqDbYEeiQ=;
        b=WrKAr5XoGfwt9JYQ7vOY+XFR8XPS7CiYgTTK5B0Pza4P16GLxoH2mdQA8RsUhQImE5
         Vp19MLb6BE9uWZSWY6gpsb0/w54Y05WP/mdboOMUEdZfyCqox5Kds7hgQQc2IXT+xCOu
         dbStn+xi7NHCMQXYjg/8Gos4xknL+51wLQuVcP+iZRNQvqxUoWjkklhxH24eDYdRqcN0
         ImgPvCOtWG9ZrGKK13MFSLS4AMlNjo3UOfT08CBPLc2fZEIXVXLhM4oq35k3cFFTSy1J
         Wht35jmb3vuR1UNo2/uhdT9MW/OnfR3DeimdaQolzVdLNsdsdXMwR+ggasfJ+3sHvZKv
         DE1g==
X-Gm-Message-State: AOJu0Yyrgquve4d3rxH/esX0EZFnCB26xuxxa+cdUY07eG1JYxpmzJHw
	mkUZRMm4bsbvXMm8A5XoPyS4FMjWcBnOCJ6GT8VmTWIRN59yVuyQ8zD74y2p8ZfEpMvyEKutDE3
	YeQW6
X-Gm-Gg: Acq92OGpwC9xtaCV8r+mrJ9Pir49vAj/NQeUOzuEk8IYLjlQeZv+CJySjjVBWqPqwUq
	DYuaDGqVjYOoEP94oSkATbwXc4TUWSg88oure6N7faVhKQMmhXSW8a1sJ/Ky+LCZYQ8WQnUSYf9
	kpdF3liPtfkfayAnNNq3R7bN+OJq9ZG0W4zoY1qF8vPHrKiCtpqkGksZZwiKBU26AG7JP5A8vrw
	SLjTMgDbDfXBnBYXY2t6daNcuEIzUdahFgEyPJPqy+Y+8b+DviKwnylIIAfe2I5t87xwswbT9NS
	ICsH9a1h17NjIOoM5GZ3dfi1oP4xFXKjNlVxq66N2LfgxguLDkR2YcrfWsueqv/8ctzAVzJeR37
	sySilddtjxQ0qJN67o5ytjiRc6qEyLOsag1hPDq8q6XW2Vl8qJAl0ko0cklioq3aDYZ/04eCRoB
	oZopHfie0xEhkaAktEki2W+KVnITApkWAifkK58ypaM0yvSi2H/0FJhA==
X-Received: by 2002:a05:600c:458a:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490c25adb21mr256193185e9.4.1780916874740;
        Mon, 08 Jun 2026 04:07:54 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm326962625e9.1.2026.06.08.04.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:07:54 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/3] device: Refactor device_discover_services function
Date: Mon,  8 Jun 2026 13:07:41 +0200
Message-ID: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
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
 src/device.c            | 26 ++++++++------------------
 src/device.h            |  3 ++-
 4 files changed, 12 insertions(+), 21 deletions(-)

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
index bea893301..223e25102 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2735,7 +2735,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 	if (!dev->bredr_state.svc_resolved) {
 		int err;
 
-		err = device_discover_services(dev);
+		err = device_discover_services(dev, BDADDR_BREDR, NULL);
 		if (err)
 			return err;
 
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

