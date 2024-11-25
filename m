Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931B1B87DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567639; cv=none; b=e0PABJApe39Ln2TkaM1YqWUOefSYF/588c/R8xwjgzWOTGXOmKBjKot3d7CcDfth+B+ELPyLVuaJYPVHlcfK4nWuUb5q80vmKUPji6lBue0s4rF4Na+SZmfesymUFtDxMe0wWm89c2v+CCOt16fRNFG1wiQTwysMiXPmgA/Rc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567639; c=relaxed/simple;
	bh=b0Q2GOPLOYa1a7gfFUx2MZY+M0oD+S5EY08rPZGSiD0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bH4kuaj8eun/oN2g56BoAgpuVDD7T44NyBoe3uDetWtHa2UuHnt6jJFvlKkgMum7wPeDPaCSdB3wY/lNE1PQlA0iEzZvHu2sJfCi1DFDDPfX92uUWksHFlyhnGviJSOkclCg0+Nw+yIOHtL+WVhBlJ8bnd0FGx4nnkFcB/N7kII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZahwLd7i; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZahwLd7i"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-856e7566b2cso1378863241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567634; x=1733172434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9W+g0++ePsGFTTYR0SaR3E53bonNAuLspg309JKEHQk=;
        b=ZahwLd7iR2kXibUPb5YBPvexub1zm1vmZsqt7/KYQXcxy438+jDhdquiCEpcYIu+Z9
         JTwrVbB6FsyULoHt0H4Gl4BE90nN5GcaqKvtvMj3MnI78lh+i0z9hDJGNVuG3s3UjzcE
         aKLrMH6gJ/4hytV5Bp1eWrXitIlMtkKpN3h46pwB390BaFpI14pwvVCuzvvD384tfBw4
         o1jeXHGf826maDv910wqM/2d528R6PfPBBxQgUIBG8WPPyWFTLdTWozgW6mqMIhQz5QO
         Ug8l/J2Hmzu3VE7SGVFTNZa4lBoby4NPjXj3kCov08oAJDXEfv1A4ZwiH3WM6KyUKc+i
         fYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567634; x=1733172434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9W+g0++ePsGFTTYR0SaR3E53bonNAuLspg309JKEHQk=;
        b=YRgrNIKsMk3hX1L6yn11YJxYBxBuvNTMNDHpyzNk59BYqLZI4Wp21uObEnGqcdSqeb
         mND+ru+fNyLZu/Je1xGAxtZpq2Lg3B78E8Q8Jjjrw5DAdl0NnGUFofBQB/eFTwhYgaoi
         FkwuzBvi7+WHm5Cxl/6vdEhMb20SRTokwSKjZzaGkmERdeUd9dSiNsSidDhJusnc65mF
         nJK0VQoq7UorHY7COwnZu7rDdisPMfoP/NFtbT24zdRQ/qWqUEnaK18Xls5fc3TfoMTV
         aycbnGvuy9i0ev8uYMb417PxRkjlHohqMCHdcM4NlCfAHZ8/fX2MjBF8TMnkjRFXhTgT
         stXA==
X-Gm-Message-State: AOJu0YwiqhLZ5VVb9TMd6VporlCGYm9j6WcpRTJkseF5hyGeS/UfGNCT
	1HWE5Bawj0s5dQ1lPuJO5Al/TRZB/paDmuWOoVtTOCKrezOtpCnTWxkXtw==
X-Gm-Gg: ASbGncs5I27lZ5JuNqNBEnum9V0ZDcatUAXU/Um05Duo92diIjQITn5D+wzSTeG7BeL
	+GqKp2MiMJNC+6XJKHlBV/Z+aDxcs/ZWs9XzmYoKeUAvNA/C6h6cRsuAUrwOolkv8vv6QXC5amO
	O7za72k5fpL3Qv4+fE4jXE9aZPLFU/RwsU3D8g4C5kOMGuXJKGIGCRvSqRPRoFu9ePsQdWu/FDZ
	EePpu0m6oOmlK91c3NL9tEbIQmdLOK88XS/yJRdgYOTDfqLGBlk+TPFFK7a5DvuSV7jthbhGive
	XG+prAndysbJqfTuMiYBEw==
X-Google-Smtp-Source: AGHT+IG3fvM4vu6FvPT9O1KY0Z96yxclflhvYiHViMySUShw+ABvKqJgzDMsn3WMN5Nl+ByrMBPUsw==
X-Received: by 2002:a05:6102:3e92:b0:4ad:4fc1:5783 with SMTP id ada2fe7eead31-4addcbd9449mr15246927137.10.1732567634406;
        Mon, 25 Nov 2024 12:47:14 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm73829241.1.2024.11.25.12.47.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:47:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] main.conf: Add LE.CentralAddressResolution option
Date: Mon, 25 Nov 2024 15:47:08 -0500
Message-ID: <20241125204711.719853-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Fixes: https://github.com/bluez/bluez/issues/1028
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
index f784dcada191..6a397645bcf2 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -678,6 +678,7 @@ struct mgmt_rp_get_device_flags {
 
 #define DEVICE_FLAG_REMOTE_WAKEUP	BIT(0)
 #define DEVICE_FLAG_DEVICE_PRIVACY	BIT(1)
+#define DEVICE_FLAG_ADDRESS_RESOLUTION	BIT(2)
 
 #define MGMT_OP_SET_DEVICE_FLAGS	0x0050
 #define MGMT_SET_DEVICE_FLAGS_SIZE	11
diff --git a/src/adapter.c b/src/adapter.c
index f422bbaae155..5d4117a49cfd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5701,6 +5701,12 @@ void adapter_set_device_flags(struct btd_adapter *adapter,
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
index 07205aa69486..6af44e3e4857 100644
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
index 2b3d19f552fa..2d3ac71f6878 100644
--- a/src/device.c
+++ b/src/device.c
@@ -548,7 +548,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	return FALSE;
 }
 
-static bool device_address_is_private(struct btd_device *dev)
+bool device_address_is_private(struct btd_device *dev)
 {
 	if (dev->bdaddr_type != BDADDR_LE_RANDOM)
 		return false;
@@ -7338,6 +7338,27 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
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
index 97536774ed5f..2e4a9771d585 100644
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
index a86e528fd0e2..a5a01add40f7 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -22,6 +22,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
+#include "lib/mgmt.h"
 #include "btio/btio.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
@@ -738,10 +739,19 @@ static void gap_car_read_cb(struct gatt_db_attribute *attrib,
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
index 41c3271a7457..794a51dbf586 100644
--- a/src/main.c
+++ b/src/main.c
@@ -109,6 +109,7 @@ static const char *br_options[] = {
 };
 
 static const char *le_options[] = {
+	"CentralAddressResolution",
 	"MinAdvertisementInterval",
 	"MaxAdvertisementInterval",
 	"MultiAdvertisementRotationInterval",
@@ -581,6 +582,11 @@ static void parse_br_config(GKeyFile *config)
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
@@ -708,9 +714,21 @@ static bool match_experimental(const void *data, const void *match_data)
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
@@ -1205,6 +1223,7 @@ static void init_defaults(void)
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
 	btd_opts.defaults.br.scan_type = 0xFFFF;
+	btd_opts.defaults.le.addr_resolution = 0x01;
 	btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
diff --git a/src/main.conf b/src/main.conf
index fff13ed2ff31..ca45c6ed0e25 100644
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
2.47.0

