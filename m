Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F14F68B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625685; cv=none; b=raOPefreALSvpTUHi9jP33bt9PHOE/UK3Apx0woUJ8x0sVWpta6zQJsEK5ASWgg3n61zVWAeZCnF7saRi9CkGKf/hfqAKC0cceSDkH/ZMaSx3Pq0eQZw8+WRQLrvgX2Y7jTT53+TgMsX2LhOwz5n2Sau/pabNhkN0UoBUgI5cZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625685; c=relaxed/simple;
	bh=4qPLagqZifRlnJwKi6e+cU9OtWIza3rh6DzGI9ZJtms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA3TwSBumLLlkwHPHlHe0ne57/JE32Td0nZn5ri6f/A0y/EhwE1gzcg0YFM8tiRYHFI82/DBGLXybxFI+kqzvaXLXdJFOhVPa1MgMaKJu5rwSfdoJtUYTh2RMEgVFlkID4HrqW1iGQ6P010Na8IvIYHgKdcp7K/2rFKFeewmv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz891/cw; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz891/cw"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c979c5eca8so2595206e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625683; x=1791230483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=Uz891/cw/iO48h+1ymuhF8rElWY5UgvlOW4n8Q1acIlLcNcpgTozyLTXROaXcnskCg
         ARO7MhOzYyxuZ4D5wiePInHnWtQnhPsP+u4Cwf8ZhGiqGTt+X0v13xCEKxkx+vPWDyG7
         JGQGoNApKFYEDH8HtOfp6MwDA85oY2Si1A02rZSXZaj+WkWhIbK+db2vrYrL2MtXobm/
         +wu4dz52uf/pS7S0Tu379WN8BQOmkLubcK5t3NCKgsFdqNcQYnvul9kBYcPtur3pwAUG
         S2XGr8bj/3XjIPOiQ9OFL8o/hYLKJpR4VpJf7hPvhvpMsbsh2Wck+fqbsgLuPHTnPwik
         snoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625683; x=1791230483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=iE5NcONSByGEtVvoKT9bsGRgjkuE4sH+GIjnLBgkXGKjf7icKv5H5bJwzov9WIbisp
         qTEayDAiSSj6UalmfvFs0UtJYQllaIlrhXADTmKPpJi9sDqyCmmxNoob9szRIlP6xkWL
         owE/EhE+p2w6zrKagYz6C+ixQzP4aEFJhfbR571eLXS3SRaPn2TJU5YXcB3cXpcodl5H
         2nYB50lbRD+9aV1UP1lcY99rOotr3m0BbJvGJd8jieI30g8pKVYcKgI9R1Hj0MMvbQY/
         qpZsFUmuCcI8Tb+Ebn8ErWBQIBBuN2VXtA6KkrhcWBbmUlibGmijgq7dA0ClbVRffjM3
         Srug==
X-Gm-Message-State: AFq9FYJnMsQY9h8rg1ylSdxk9XDVxxK6By8QJRSq72eLGZwdAURDslJq
	yKrGrMI0ni/cQnnMePmsnjXnMGGiDMMQXLkTpNjtWcP+fLIG8d3wmz6TSnDIazpQWm8=
X-Gm-Gg: AYBFou2d4BzGQ4uxEWR+v/0lB8IH5P3kISDn5kdwg0gg2y891jtktSYMEnT1U4BCst1
	r+0iH0EAM/uXL4lncePFzN8fZSBRlzsgfT3lzJRajAmBcGydZJOQJkmuDKg4bzynMGMNqOl/Ick
	gSD6TYMRJXxJuW69Wd9jf5go18kgsABRATDIA0L41oossy46RoQY/yzLsvPCAeEDo7tI/11GPX8
	EUnThr9A2sMtGZND/QMyJsi2UkeD9DOweayCnmTK5ZlbNSJhuOynwBDxYbCinq41vzYoBVISOSu
	MLmHyBEz8+DCh5MVBRdu1I5160gQG11uoAwW72j+ejR6J5I6Ft7v9/8woiCWIYlz2y2yxUATyl1
	XM/5KV1JpYOYGcSpLzawSIhB8Z2D2T4O9BbqqS7xHBogiWKe98Wel5O00nsjSEUcdbvcqrEhUbl
	4U844bdZdke48z5079klE17r2vH+n+ZJ4+9zrgVmXX3MndMEdwqRKZNDfAlmqU9k2MJCRDqI/CS
	lI7C7K5d+LmAkRrYUQL7WOtg0PK052aH6ep/m4pRN0HLBjxkCVoWad/zoa266+Q
X-Received: by 2002:a05:6123:91:b0:5bf:d3cd:3d64 with SMTP id 71dfb90a1353d-5cb06003ee3mr6549626e0c.0.1790625682652;
        Mon, 28 Sep 2026 13:01:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 21/23] device: Use bt_att instead of GAttrib
Date: Mon, 28 Sep 2026 16:00:27 -0400
Message-ID: <20260928200031.1209311-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
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

