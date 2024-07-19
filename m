Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003234174C
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419642; cv=none; b=Q1gLPWmH9lnumFwSL5vPnNZEvZoGDZqK9ZGHwf4qH5ZMBZOyiDSs3BjGFwGenSoqSImeNUcLPa1OjwXDo8V31TJ3DqTkFl+z6AdLOHO5QmknpHpdoZLY6t4SbvkSYS7mj6KHkX8SQNQE3X0J2nkiyRuiUiZTuzqiNRTDtuwMAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419642; c=relaxed/simple;
	bh=Je79lj6ELy/1/ZTuJAUGVJGkPLH0h7skGdBXUY6Xsa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kuICsWc6pyk4m2MdiCIa8i0kwkWrtlB9pf2dvotO5bvSmUeM3kKJz9J2dBZvV2YX5a3IEOXwT+WRUaonvmaQg0ykh1WSvdlVw2U0rQFrCPb+guPPFW98YjjELe3+otv7dRWzidIIsb7XDZV7iwYBdfogOVI6E8WUX40XooQ/isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJA0cIMm; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJA0cIMm"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48fe9381454so1715718137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721419639; x=1722024439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ej7KE1cjQE0tn2Kfv1YeBpmNe5KlH9/Drmd04lhvwA=;
        b=gJA0cIMmxj1HS2o8J5T/pwZLphNTIWjgXUlXW36rhFK4k0+hJvl8oOJAzX0u8laGzd
         QBpdT8xcJkavx4spM8HVwrN6yfuPMchf9Xk/at7v/GJoeE39zbBrR9Vejn82ZI2mkBiW
         du+3wfeiAUnoVi8+W7lo58+1cROihw+6m38yOETBuvgHugHY4Z0cxHSP7/T/XYmhgVtE
         Hrdb0v6vQbmJPAqHr5dbaFVkDhJUZU3WrpLFCA/qRUXFnCTiaHPP7xc40QC8d/XnjJ4P
         umkIYU6JS2BzEiwT1AYcPwg+4DIlGl678iwIxznfYd/FrHQ2cSoacmQEtjUDYPGml15Z
         yQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419639; x=1722024439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ej7KE1cjQE0tn2Kfv1YeBpmNe5KlH9/Drmd04lhvwA=;
        b=DPIjJR44fQbrfAuzcjupQQ780X4KWplhiklmJ5HupWCToeOd9bxDI7XGyBMmKCy1/H
         amcVqOsIS/mho7YoHzS9wZfFMDaevMZED4x02a6n5m7XZMoArH6E/m+07SDY4GZ3/2gr
         81v+Zcvande92YO4QSh0zbhqYhil22e1uczscMtP/8XcmjiyhNNvn1XxSB44N9nmXnhp
         bbHOiNw1PZYn+qpU9Sk/l+cH881roikiVB5fL1i4/uU8u/kKCsvWAwI71dgT5q8zfIh0
         BVqaeXxNgRzX9EdJyDVyFJ3yFVlZC88tPD86TyyiqUtWw7p8FZo7RbDAW1f1kwG7g6+N
         v47g==
X-Gm-Message-State: AOJu0YxNqQtKCUH8DGbIYR/oWm90VytP0fEvlqiWaPo7VP4n/Q5HcbY0
	W3u5C2fEQ4y9qS2CL4Wwvd/O9s8VCr0Ix8ZDT2hrToCTtO7XAzOMthYMHA==
X-Google-Smtp-Source: AGHT+IHOpgq+QH6zq73cG+r+2b3zIQfFwpiBSO2emchC0SazRbOjsVrtsas2yFLVPUrhY04rcG7ejw==
X-Received: by 2002:a05:6102:579a:b0:48f:41ec:b0bc with SMTP id ada2fe7eead31-49284249942mr1026453137.4.1721419638821;
        Fri, 19 Jul 2024 13:07:18 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49279293662sm305755137.20.2024.07.19.13.07.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:07:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v1 1/2] main.conf: Add LE.CentralAddressResolution option
Date: Fri, 19 Jul 2024 16:07:15 -0400
Message-ID: <20240719200716.1557861-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds CentralAddressResolution option to LE group which controls the
GATT attribute of the same name using the new MGMT Device Flag with the
fallback to LL Privacy experimental UUID.
---
 lib/mgmt.h          |  1 +
 src/adapter.c       |  6 ++++++
 src/btd.h           |  2 ++
 src/device.c        | 23 ++++++++++++++++++++++-
 src/device.h        |  2 ++
 src/gatt-database.c | 12 +++++++++++-
 src/main.c          | 23 +++++++++++++++++++++--
 src/main.conf       |  6 ++++++
 8 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 8f92b77315e3..6cd3b7397e18 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -678,6 +678,7 @@ struct mgmt_rp_get_device_flags {
 
 #define DEVICE_FLAG_REMOTE_WAKEUP	BIT(0)
 #define DEVICE_FLAG_DEVICE_PRIVACY	BIT(1)
+#define DEVICE_FLAG_ADDRESS_RESOLUTION	BIT(2)
 
 #define MGMT_OP_SET_DEVICE_FLAGS	0x0050
 #define MGMT_SET_DEVICE_FLAGS_SIZE	11
diff --git a/src/adapter.c b/src/adapter.c
index 85ddfc16568f..265c3f0edfbc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5696,6 +5696,12 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
 	if (btd_opts.device_privacy && !(flags & DEVICE_FLAG_DEVICE_PRIVACY))
 		flags |= DEVICE_FLAG_DEVICE_PRIVACY & supported & ~pending;
 
+	/* Set Address Resolution if it has not been set the flag yet. */
+	if (btd_opts.defaults.le.addr_resolution &&
+			device_address_is_private(device) &&
+			!(flags & DEVICE_FLAG_ADDRESS_RESOLUTION))
+		flags |= DEVICE_FLAG_ADDRESS_RESOLUTION & supported & ~pending;
+
 	bdaddr = device_get_address(device);
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
diff --git a/src/btd.h b/src/btd.h
index 383bd7c19600..b9c7647ef277 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -59,6 +59,8 @@ struct btd_br_defaults {
 };
 
 struct btd_le_defaults {
+	uint8_t		addr_resolution;
+
 	uint16_t	min_adv_interval;
 	uint16_t	max_adv_interval;
 	uint16_t	adv_rotation_interval;
diff --git a/src/device.c b/src/device.c
index a1dc0750ca41..063e32fe01b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -547,7 +547,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	return FALSE;
 }
 
-static bool device_address_is_private(struct btd_device *dev)
+bool device_address_is_private(struct btd_device *dev)
 {
 	if (dev->bdaddr_type != BDADDR_LE_RANDOM)
 		return false;
@@ -7234,6 +7234,27 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 	store_device_info(device);
 }
 
+bool btd_device_flags_enabled(struct btd_device *dev, uint32_t flags)
+{
+	const char *ll_privacy = "15c0a148-c273-11ea-b3de-0242ac130004";
+
+	if (!dev)
+		return false;
+
+	if (dev->current_flags & flags)
+		return true;
+
+	/* For backward compatibility check for LL Privacy experimental UUID
+	 * since that shall be equivalent to DEVICE_FLAG_ADDRESS_RESOLUTION on
+	 * older kernels.
+	 */
+	if ((flags & DEVICE_FLAG_ADDRESS_RESOLUTION) &&
+			btd_kernel_experimental_enabled(ll_privacy))
+		return true;
+
+	return false;
+}
+
 uint32_t btd_device_get_current_flags(struct btd_device *dev)
 {
 	return dev->current_flags;
diff --git a/src/device.h b/src/device.h
index 3742f6028040..36895db087ac 100644
--- a/src/device.h
+++ b/src/device.h
@@ -28,6 +28,7 @@ bool device_name_known(struct btd_device *device);
 bool device_is_name_resolve_allowed(struct btd_device *device);
 void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
+bool device_address_is_private(struct btd_device *dev);
 void device_set_rpa(struct btd_device *device, bool value);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
@@ -189,6 +190,7 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
 int device_discover_services(struct btd_device *device);
 int btd_device_connect_services(struct btd_device *dev, GSList *services);
 
+bool btd_device_flags_enabled(struct btd_device *dev, uint32_t flags);
 uint32_t btd_device_get_current_flags(struct btd_device *dev);
 uint32_t btd_device_get_supported_flags(struct btd_device *dev);
 uint32_t btd_device_get_pending_flags(struct btd_device *dev);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 6c84b085ca29..92dc15641b9e 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -21,6 +21,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
+#include "lib/mgmt.h"
 #include "btio/btio.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
@@ -737,10 +738,19 @@ static void gap_car_read_cb(struct gatt_db_attribute *attrib,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
-	uint8_t value = 0x01;
+	uint8_t value = 0x00;
 
 	DBG("GAP Central Address Resolution read request\n");
 
+	if (btd_opts.defaults.le.addr_resolution) {
+		struct btd_device *device;
+
+		device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+		if (device)
+			value = btd_device_flags_enabled(device,
+					DEVICE_FLAG_ADDRESS_RESOLUTION);
+	}
+
 	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
 }
 
diff --git a/src/main.c b/src/main.c
index 62453bffaf57..01fef7052108 100644
--- a/src/main.c
+++ b/src/main.c
@@ -108,6 +108,7 @@ static const char *br_options[] = {
 };
 
 static const char *le_options[] = {
+	"CentralAddressResolution",
 	"MinAdvertisementInterval",
 	"MaxAdvertisementInterval",
 	"MultiAdvertisementRotationInterval",
@@ -573,6 +574,11 @@ static void parse_br_config(GKeyFile *config)
 static void parse_le_config(GKeyFile *config)
 {
 	static const struct config_param params[] = {
+		{ "CentralAddressResolution",
+		  &btd_opts.defaults.le.addr_resolution,
+		  sizeof(btd_opts.defaults.le.addr_resolution),
+		  0,
+		  1},
 		{ "MinAdvertisementInterval",
 		  &btd_opts.defaults.le.min_adv_interval,
 		  sizeof(btd_opts.defaults.le.min_adv_interval),
@@ -700,9 +706,21 @@ static bool match_experimental(const void *data, const void *match_data)
 bool btd_kernel_experimental_enabled(const char *uuid)
 {
 	if (!btd_opts.kernel)
-		false;
+		goto done;
 
-	return queue_find(btd_opts.kernel, match_experimental, uuid);
+	if (queue_find(btd_opts.kernel, match_experimental, uuid))
+		return true;
+
+done:
+	/* For backward compatibility set LL Privacy as enabled if
+	 * CentralAddressResolution has been set so old kernel LL Privacy is
+	 * enabled.
+	 */
+	if (!strcmp(uuid, "15c0a148-c273-11ea-b3de-0242ac130004") &&
+			btd_opts.defaults.le.addr_resolution)
+		return true;
+
+	return false;
 }
 
 static const char *valid_uuids[] = {
@@ -1186,6 +1204,7 @@ static void init_defaults(void)
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
 	btd_opts.defaults.br.scan_type = 0xFFFF;
+	btd_opts.defaults.le.addr_resolution = 0x01;
 	btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
diff --git a/src/main.conf b/src/main.conf
index 82040b3fa33f..601cc61f7a26 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -178,6 +178,12 @@
 #MaxSniffInterval=
 
 [LE]
+# Enable/Disable Central Address Resolution.
+# 0: disable
+# 1: enable
+# Defaults to 1
+#CentralAddressResolution = 1
+
 # The following values are used to load default adapter parameters for LE.
 # BlueZ loads the values into the kernel before the adapter is powered if the
 # kernel supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't
-- 
2.45.2

