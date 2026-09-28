Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A54EB869
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616812; cv=none; b=df7ukxBQ+ReOaqusc3+wpEVMMMeh3LPn1dAhAn8WYLZ2d+won38yFaL/p0PW9C7/sdBysLJkU2BkU12kp8MY3GLkHJan8vnSAxMs7Umk6nfUzRdZcE4iG9jXsHeBDqbaY9NOqLJtjWapWrAAtLDX+tMABYBB8mLCLBlaE+Iva7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616812; c=relaxed/simple;
	bh=4qPLagqZifRlnJwKi6e+cU9OtWIza3rh6DzGI9ZJtms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae1HCsjXcVdLU49UANnVmmNIFWyMkVGu2c7hOFAPovF7dObOWXyl0O5iLGTBpqA5R+7DdWGGdNOupIj3nfmJQ/zKLL60F8r/6KhGfh1evUNbtR3hyDTuwH+nPRNU/ELIiEbPaTqLxcZ2n2pw4JeiGoBi/5LB6s40fpCvime9+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENKjOCii; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENKjOCii"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-79028ca9371so1143042137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616809; x=1791221609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=ENKjOCiiQ5KImalsZbaLkxQBTJ6xv9B3FA9P1sSJAIqyjvwM+vIVlfSKx2mXmr1BMv
         tY1x0vNRAUJPkQ4dbjhDd2Vq4Jc7cIL5pNHQRc6J5QOexfEWkG4BqL4SgdavDabPai3S
         c8k/9wepVG5Wky+BTE5EN+NxPr3fkduqlvtjde3OsAypaS4oOEjGV/MxvNQChDOXx/Rc
         82FFTVKx0f2RYO/js9ge1MD1ZERW8szvdeowJF/wYT0PaYtjnTLPXJb25p5XllCVaF5u
         lXTjFNMqWbQOvLPwQ0La7fXzn0IgKPhfForRvUBtEOI/9hlbkXgcjPlkvVvc/b0QHGKD
         rCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616809; x=1791221609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=lgniVqsxNlhrpHQXnvj0DfsTmN8POW8RGMKzZ0G4YiA5JgLjNyDTr6KVfn5lYSuLxe
         dU2bki16565yWzMNsX79DXVf7ax0+MBJxHCmnez1/AqLUjJYdX4PSkm+ST3fOR5iXBUb
         bucw/n4gN2rhGkiblWK01jD2VZu5xdIDu0Z5jhvyPt0BVuq5CD+uab/el02lG6yXDLB+
         Gg7ZOW9ZfJWtSAQpzIAWGoXKwaqCcThgQbJvTbxQG/tlHHJUCp+pyZ4JdGFLE4lIQvDC
         HVQz/e66LUW7d42LVYPodrVAyMOXvJn6qnXwxnsgMW170N/dFGXUxwn+kJy3ykXv5CVh
         iNWA==
X-Gm-Message-State: AFq9FYKxE2YBz6+R9P65EtGdNxG1Gj1HXlvaBNI4lz9lwjHYr3ceeUSy
	pd+ao0Zqq77YK7+7ES3y5wMyEQN3UVso4oHDFt3yyhxbsQzWh7apv2sszj4WXl/u8Xc=
X-Gm-Gg: AYBFou2eua1wXb8jjoFfK7AKb6jaxUvpmDibMn39gGisCxoErVHCUuWrqwEsoGlqAdV
	/ld0RgGgRePh10PhQNUc5TY4YwshLoosP5egMmubqXcG+HMVWAqD/I+RYOvynT/TXZUFw/Yw/zy
	q78jOeTIecsxWoNUC1JuGC8UsXCeVzFsXJDmUG25Qj65oUNtwndbrtIwbKLLLQ/k5yIwZjZHVMo
	LyNfM3GTj9t3V41R3unMkdI2R5ZcgpF5T7MGBfkQG2x6J0kSvCsDs1bwjIzTCZzmGaZUyNo1gCt
	cvrtfAy3Qb73NaADtbeUFlDyRGN3/8P6j/xTrnWnV1JTYSlCLXkZPeKw6DrFBczZ3upF8NwBKv/
	scCFL68WOhTBWv9FLtKK7tyOKDXLXjCPLtw0wpnauzjxYc4uO2msKoAjopKfc0UimU1GPYEE6CY
	oyHpTRS8KZ7Q+aaEuSEitWiN+fAerKM7J8qcE7qsPUUoJJp78lI/fdmJj0hshabGiOX3Hnky/r6
	Bqy3ZDxSdTHpBQ3FqV3erHYtT2c5R0W0ymASOjOscu4W2hdDmYUuUd4aHdIXU/Ndg==
X-Received: by 2002:a05:6102:1488:b0:7b4:879c:bb87 with SMTP id ada2fe7eead31-7b4879cc10fmr1305209137.14.1790616808928;
        Mon, 28 Sep 2026 10:33:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 19/21] device: Use bt_att instead of GAttrib
Date: Mon, 28 Sep 2026 13:32:38 -0400
Message-ID: <20260928173243.1073509-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GAttrib is no longer used other than to create the bt_att of the
connection, so create it directly, and remove btd_device_get_attrib as
there are no users left.

Assisted-by: OpenCode:claude-opus-5.5
---
 profiles/deviceinfo/deviceinfo.c |  2 +-
 profiles/ranging/rap.c           |  1 -
 src/adapter.c                    |  1 -
 src/device.c                     | 46 ++++++++++++--------------------
 src/device.h                     |  1 -
 5 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index e77bb50b457a..b1f6fb3ff749 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -26,9 +26,9 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
-#include "attrib/gattrib.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "attrib/att.h"
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index b494d188c9c0..f3f677c4b4bb 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -27,7 +27,6 @@
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/gatt-database.h"
-#include "attrib/gattrib.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
diff --git a/src/adapter.c b/src/adapter.c
index 33e1ff07ab24..4131c4431dc6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -59,7 +59,6 @@
 #include "uuid-helper.h"
 #include "agent.h"
 #include "storage.h"
-#include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "gatt-database.h"
diff --git a/src/device.c b/src/device.c
index c5d8e4c6ebdd..7ed32a63cf19 100644
--- a/src/device.c
+++ b/src/device.c
@@ -47,10 +47,10 @@
 #include "btio/btio.h"
 #include "bluetooth/mgmt.h"
 #include "attrib/att.h"
+#include "attrib/gatt.h"
 #include "btd.h"
 #include "adapter.h"
 #include "gatt-database.h"
-#include "attrib/gattrib.h"
 #include "device.h"
 #include "gatt-client.h"
 #include "profile.h"
@@ -59,7 +59,6 @@
 #include "error.h"
 #include "uuid-helper.h"
 #include "sdp-client.h"
-#include "attrib/gatt.h"
 #include "agent.h"
 #include "textfile.h"
 #include "storage.h"
@@ -257,7 +256,6 @@ struct btd_device {
 	GSList		*disconnects;		/* disconnects message */
 	DBusMessage	*connect;		/* connect message */
 	DBusMessage	*disconnect;		/* disconnect message */
-	GAttrib		*attrib;
 
 	struct bt_att *att;			/* The new ATT transport */
 	uint16_t att_mtu;			/* The ATT MTU */
@@ -865,14 +863,6 @@ static void attio_cleanup(struct btd_device *device)
 		bt_att_unref(device->att);
 		device->att = NULL;
 	}
-
-	if (device->attrib) {
-		GAttrib *attrib = device->attrib;
-
-		device->attrib = NULL;
-		g_attrib_cancel_all(attrib);
-		g_attrib_unref(attrib);
-	}
 }
 
 static void browse_request_cancel(struct browse_req *req)
@@ -2342,7 +2332,7 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	/* Enabling auto connect */
 	adapter_auto_connect_add(device->adapter, device);
 
-	if (device->attrib) {
+	if (device->att) {
 		DBG("Already connected");
 		return;
 	}
@@ -6391,7 +6381,6 @@ static void gatt_client_init(struct btd_device *device)
 	}
 
 	bt_gatt_client_set_debug(device->client, gatt_debug, NULL, NULL);
-	g_attrib_attach_client(device->attrib, device->client);
 
 	/*
 	 * If we have cache, notify existing service about the new connection
@@ -6491,7 +6480,7 @@ static bool remote_counter(uint32_t *sign_cnt, void *user_data)
 bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 {
 	GError *gerr = NULL;
-	GAttrib *attrib;
+	struct bt_att *att;
 	BtIOSecLevel sec_level;
 	uint16_t mtu;
 	uint16_t cid;
@@ -6541,17 +6530,24 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	dev->att_mtu = MIN(mtu, btd_opts.gatt_mtu);
-	attrib = g_attrib_new(io, cid == BT_ATT_CID ? BT_ATT_DEFAULT_LE_MTU :
-					dev->att_mtu, false);
-	if (!attrib) {
-		error("Unable to create new GAttrib instance");
+
+	att = bt_att_new(g_io_channel_unix_get_fd(io), false);
+	if (!att) {
+		error("Unable to create new ATT instance");
 		return false;
 	}
 
-	dev->attrib = attrib;
-	dev->att = g_attrib_get_att(attrib);
+	if (!bt_att_set_mtu(att, cid == BT_ATT_CID ? BT_ATT_DEFAULT_LE_MTU :
+							dev->att_mtu)) {
+		error("Unable to set ATT MTU");
+		bt_att_unref(att);
+		return false;
+	}
 
-	bt_att_ref(dev->att);
+	/* The fd is closed once the ATT instance is freed */
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	dev->att = att;
 
 	bt_att_set_debug(dev->att, BT_ATT_DEBUG, gatt_debug, NULL, NULL);
 
@@ -7984,14 +7980,6 @@ struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device)
 	return device->client;
 }
 
-void *btd_device_get_attrib(struct btd_device *device)
-{
-	if (!device)
-		return NULL;
-
-	return device->attrib;
-}
-
 struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index 2ed369856d3d..f18fa5b2119f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -75,7 +75,6 @@ bool btd_device_set_gatt_db(struct btd_device *device, struct gatt_db *db);
 struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
 struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device);
 bool btd_device_is_initiator(struct btd_device *device);
-void *btd_device_get_attrib(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
 bool device_attach_att(struct btd_device *dev, GIOChannel *io);
-- 
2.55.0

