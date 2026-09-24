Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3943D503
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289076; cv=none; b=Wu5JaEod7xdcmnH/zdf/qFJIB9dWvl1WxAr6WonpV1z/NOEVEaokaxvpkyv2NhTo4SUvG+lkJodU/PthwJdUA6P1xZZKHZ3CCbV/I8+zn3zdp4zLM+P8H+MOiPMwjq50iI5t6h7kNxFQuJx3lVqLHM4IrPr2CkpqqZt4j2XT4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289076; c=relaxed/simple;
	bh=4qPLagqZifRlnJwKi6e+cU9OtWIza3rh6DzGI9ZJtms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc2blTdBFfnaDmKMm9jGtO/iUWF0XEEtcxgW4GAZ8C4WgOObhqJWvT94iNZQy9L5zo+V2TReiFIj95o7rOQv3PSHU+vn9+W2H3VS6Dd++WgFWNJnJe7mZFRr3b1JuzCNHiAEdjB9EYhXq14j6Tg0NY5IfdtMAWrDnn16JWjX1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/fl7fL+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/fl7fL+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so207164241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289073; x=1790893873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=c/fl7fL+MAku0lHhuo2/MIW68sGW1gfLAvFRzqvgp5btKggn6p58KyToz+cyp48bM5
         6twUO13ML59auLmKIyHprxLyRazYWxtsb5fYCXi1w8rVhKfw2+uCAri4tl9bETNAontW
         KklH/KLeNqZVwek7ElMjdnLvIPboMhHMu77mkbX5yDODV0iGabePR6lSej4mPTQ8nQFg
         t2H6ID2Vhqa7K8tf7zDnfgqNjH/5zkM/c/3u6pfGgQy1GwEiNR/yWR3ZnU+B58hoyZTB
         zASB9mRUlOvlBjt269xsCHGBHAWf4a/twOJLaaGfvHJJ+lq+GwV8Bep/9A+Pv0tN0GUJ
         pLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289073; x=1790893873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eZxflB7FG7n4zt82TRFbq8lhO2Ajpe/RjIv2FLx0E2U=;
        b=XC8e4XBkIMy4XATdxRywxgBb2KLWUcs4gAhlSAedO9C8cg+L+oEK/6KOomGSzLOoiK
         /QTS/PFV12B0TOR4uwkjCqgXCeEzMCaFOiLHMWqrVGo9eo/sivx7odxQkaPemhzD4oOV
         hcUoHI/ARvnvEe2d5RDEliAqJem1pIX4iMprr15o5QQsjIbcQ5BHErPC4pLzjWB31/rN
         0XiSWYhy9FKN1CMf7Mf0SZBau3WfW2SWPiJ7D8j2wkij1UWIryfkSrJq5ocP0ozTW4XV
         RJaIjg7ncSihHLwv82jkpVJ19QTQ2vupUieHYdNNA1ew4Vs9tWejv59C+bzE11GSrPew
         w8jA==
X-Gm-Message-State: AFuF++lSuUhPA29x7iydkig472kqgL8Z25St5waYGDzU1zlpEqBwLVLF
	Ia9PAIHEquGn/9igpOZkqSgOYNzUa2WQioEP8tPBPy0CeOn2tIhBmgtZqU831yCAfeyGwQ==
X-Gm-Gg: AYBFou18ZBgyJcK3faoYAAB2jcKyRu3tsPepL/2V4zFyc/l29zMwBLw0J4bC+u49elz
	XyExNew9cqfLaGiCxMTAIRbhM9MwpTZRqxisgKKMpAn0DDjuRQqDVNvWeu4DHd9uJTFa5kyjvFf
	Jvw/DcBmwyuQ31vSvEpI8hMtPDwYMdrvPSWqFKI83RY+qINwY6R7hlvFaMLMv0bvs4B28pc82js
	iAu2jVUbuxH6bKOYAaSe8hzeDpQxZU6iVki6fy4PNte/LMOV5Y8kw+g1WY74nZD9XNdeM08x9Ro
	GMaaGYh2aL3gvdbDQwm/fXruPszZA+BZdKqNGRvB5Nom2e1s+12fcZH0n8T8Uu3i7M4E0cmPtb9
	LQD+682AGl4Sz4UKY4zP7ldrg8MV+uScTHfeMO03T/CzoXXCHoFMwHoVb5t5kX/O31Vjdso4Y8i
	E/nX625ToVRU7iHSXuFm24HgHRquEaZF3jVRzkURE+7MK5lGFTRK0VKYfhgxU8XyzxlYmhgZgms
	v21uamjE5c56tAN+T9eK4nNk1xc8Xjfx9S86txts1ZsWvOn1ymlVBjLMFQF079X
X-Received: by 2002:a05:6102:4b04:b0:7ab:1d32:fe30 with SMTP id ada2fe7eead31-7af1ebefd49mr1863786137.25.1790289073115;
        Thu, 24 Sep 2026 15:31:13 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 19/20] device: Use bt_att instead of GAttrib
Date: Thu, 24 Sep 2026 18:30:44 -0400
Message-ID: <20260924223046.605543-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

