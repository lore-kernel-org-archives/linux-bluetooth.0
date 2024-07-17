Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F8180A94
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245274; cv=none; b=liEkE7DIu60MJlcBx4BPsGGGlnhjxxVFLWXqpsav8618pfhnsjTK5fzwm7TkeHmgEPx7WEhy9pvuCVlI77HZpTalDe8tPlCTnXlByg1e0fe9wX2vO+NWz9/UBn/SnKcOcC8AN3SWETuQublmNsaVm7J9psSWhBuhPtwHrPmrS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245274; c=relaxed/simple;
	bh=Je79lj6ELy/1/ZTuJAUGVJGkPLH0h7skGdBXUY6Xsa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SuAFPrZmMklIumg6r5juRq8dqyC/JXlUlCPzF1J1SKGndSIUyWqvBjEy7fUBNyY2krltfIvgSPEyAZ8WGB1nG7ze26nt+rRJf7ZSmPUkDuslefiPG4W/3sZiKr4fepHifH2+iDWRsr5n5uJqLzuDhDGXI498FYt47lKL8qHiImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlUX2l0O; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlUX2l0O"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef12e5658bso17266e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245270; x=1721850070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ej7KE1cjQE0tn2Kfv1YeBpmNe5KlH9/Drmd04lhvwA=;
        b=IlUX2l0ORFFLsC91n9FzjnoLFzBXxhJxlqRAuFNDPUqSwUVXDdBEg9WI/H5EphoEUt
         QFoFhLGQWlZdgIHrbsQVxxYo/SfCwv3UTqh/JWmHwHyQRfer6ZtonW9/CsEgNq+Wu/1b
         3vpYYDnVaiU7Fmegc3pJasXjhxlNm+Mky5dOYNHK5iN7/DTpfw0/xqvzKO1ntBHpZ+/4
         9zz2fT3yPNozHMAvk5FXXMjVCr2f+SRRACCEraL2AVMiQjnVPAHNd4DQkReXjA6PwZoC
         U4dW/ZRCJkMIKdPl48z2Sx9/6tWkC0hhA+SKbk8fXqgsFQQilNANUoPLz1du0fM+mknX
         jHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245270; x=1721850070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ej7KE1cjQE0tn2Kfv1YeBpmNe5KlH9/Drmd04lhvwA=;
        b=X/z+0RWIEPlBpjagHvGjGqIAsZUDDdYLW/7CaDtw4sp3u/o/uTWwZohpQuuqhMik8M
         0EMxZvHB1wRo4UwLeHUDzCjl5q2c2wfOxKlw+HjHFXKWd34jBCBZLP9RZmksllAXwDMX
         Sum13nWiHQlrRQhdz7C0OKpjpMbv76zM0gSPYx/XwMojmRY4c8vZRLDJFfoOaOLyDW/J
         D9f15IC6F+ey9gxA9Gm2TwV17BVIg7YS1P4O+WH6w2iocg1ZVj4cu5UchI/QNqVRCAgY
         UN9YZ8y/cFbvug5VZLK4xl7jOuHQTjyJSGJ8/9VywhUMrrBWfEcaywhqHAOSTQPxBYQJ
         s6yw==
X-Gm-Message-State: AOJu0YwK0slPsQx7A/2VJ7vsXvdJ4bc+48TeFaKSvdRgoce1SGzJKm8r
	ho0srqSuQI285QvNJ8Ong3AVU9V+JuPZAugwgcGiWNogSIWQzUNLkEwxPQ==
X-Google-Smtp-Source: AGHT+IELdK+6WB1HFUgvZ2SxQhnE14Mm8GnXK+brwUoY30gixB/oVFCJU7KAhU7Ybx7Jri/wtx9QeA==
X-Received: by 2002:a05:6122:1d07:b0:4ef:4f5d:110c with SMTP id 71dfb90a1353d-4f4df4d4e54mr3494368e0c.0.1721245270218;
        Wed, 17 Jul 2024 12:41:10 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4d72246d7sm557559e0c.48.2024.07.17.12.41.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:41:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] main.conf: Add LE.CentralAddressResolution option
Date: Wed, 17 Jul 2024 15:41:07 -0400
Message-ID: <20240717194108.889208-1-luiz.dentz@gmail.com>
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

