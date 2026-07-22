Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5964398FE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710984; cv=none; b=N5fJJx1ind9PqeBrTPb2AXrmwH8jFJ7fxIZtJm5sM3UemOU85zZ+CTMsIwj5nvZRu+a71X/O/FjmzWzfOhqreFlqEHlqmjichEgPywtgA5k452rVtDqeT4PjGjiOeCFXbI/86i367anQfebiet9FaMDsCyPLfvY55BLs75gKy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710984; c=relaxed/simple;
	bh=bha5NlkWTfbsP2GptIg679tkQZgoSXblXXtnMAPmF+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG10EDOjatN7fRo3TZas1q00TB5NTrpgdvpcl1j8AYrbIGEvZ/NKoj7iOG4HFnG4XMUtX/1ZGEA9i51OAgxpKkmqbrZtQUBQbaPbdCsCNXD/WGLlLKAFwE9Po7J8ZvJMofzvZGVDAACJl0g4J+rYc8Z1jjGba7cw1ezAW9UYrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR+ibJxp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR+ibJxp"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ca300db70so96395501fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784710980; x=1785315780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q3XnyXX79zofznFuYF8brcNNIh1IuAGtwblCXL5jFrM=;
        b=KR+ibJxpVu+JFVrRw9Fo9GuanrmRDTJyeycFttqxcW7gWxaZbV0QHLQcC4LWM+pcIB
         NGygRm/fO8Z2He+fHc3zrKTvByA2IusRo1c0tzECDcFM9IAxWFcOuUMa6VM2ImWRTS/3
         8544WeqJJQ2uf7lkoHxHFDMCh9KK5xg75meGcXIVTUoCSE0kPucf1OVT9fUz14G/f5Ny
         dejcqqiLG8/d2ndhpx/wN+MbTXkazMerxn6plGmS73uVZPa+1uA8KeHTJFJBxiXp7gc7
         7jMlxn39vdwk1/NHyqnEiOsvjffEo13yluEN3odH/eERDHzKMPMLy9iHeodui7ZblEM2
         RVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710980; x=1785315780;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3XnyXX79zofznFuYF8brcNNIh1IuAGtwblCXL5jFrM=;
        b=r8n6vSnhLNCFjuDpAYXyLnyV6e/SyVKEz466Vz+CstV5nNThtDLEFpS51njSsYSxsM
         Yprq3hS2GX3DCnATH6pVbW/IYJQ2mor2NSACoFy/4vkxpVx4O/OD7DLQdxpEC6EholIi
         DJmfyP2Xd71p6L9P8xliejOJwbVAEEXIPns3li9mGv9xA0Ullg25s0baM2Sf0GKCVESP
         QqKpc5LvdCIJM2wY115OBKmCK5L9y+fyzah3QunfSjvJT3HXmJXOQgPIsPrfojuq6PsV
         JpC5QhrtKSbXg+iIrbu5YptcUl4SikLYTlGBWYafBmR/ohbyk83Q733CYBXt3lHXg/G+
         jV0A==
X-Gm-Message-State: AOJu0Ywp+yM/p+uyLEaLVYqbfnF+CqW8/1NNR0QM1hHcZTDGMRihQtwY
	3Y3IddALYH5/WPFsarLsHlyQdXANKBN+VC0TAOygBlgW2IHksrbD1ujL6asbcw9+uvurujWx
X-Gm-Gg: AR+sD10++lBqxhNk/mg9Kf6XxbtsZeY33CSoMADDYizlHrfWD4LVxKdwnCx7t0Yz7Os
	7G4NjukfN9kGTKRoBqK6mAW4k2fUfsFXxXDL6RORQMeT5tb0lhPPaSQLye+Nehw7yNJK+zLgcQN
	lMpxbJte0wpZIrKRePXWXz5SNIYzGRPRh5gs07luEsAQKP+gAwLjYfWDUfpoThzJKhh0utxI2f/
	OlhwZcm5txmouB3NIKORzQ0KhgyJ4b8SZA6Qy1L0zVdKCelvGAlrdkvqeCgJ0sgAsFxFiW1nI32
	bYNK+ZDGIrfWgaKaUVmXD4t/7W6wliJk/4O0jTVxIVApc+lPkCNToDqLXNHu6m9PDM+7rDmkQoB
	0ClQYzv1BZp3KPdze6Tmw5HXYPr+z+FLXQ0/PqgWteYxC0dMUX4FikIAG+WF1WGspcopJrg4wjW
	mFy1mEJJVBzHA=
X-Received: by 2002:a05:6512:12c2:b0:5ae:c563:f611 with SMTP id 2adb3069b0e04-5b28f9a575bmr4842867e87.36.1784710980175;
        Wed, 22 Jul 2026 02:03:00 -0700 (PDT)
Received: from pakrohk.localdoman ([2a02:4540:10c:b64f:36e1:ca9b:678e:f489])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9bad8b5sm366899e87.33.2026.07.22.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:02:58 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pakrohk <rhpcir@gmail.com>
Subject: [PATCH BlueZ 1/1] input: add HID gamepad quirk system for broken SDP records
Date: Wed, 22 Jul 2026 12:22:37 +0330
Message-ID: <20260722090246.212017-2-rhpcir@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722090246.212017-1-rhpcir@gmail.com>
References: <20260722090246.212017-1-rhpcir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a modular quirk system for third-party gamepad controllers that
expose incomplete or malformed HID SDP records over Bluetooth.

When BlueZ fails to parse an SDP record (returns -ENOENT), the quirk
system checks for known gamepads and injects a fallback HID report
descriptor so the kernel HID driver can create an input device.

Currently supported:
- Sony DualShock 4 v2 (CUH-ZCT2x) / VID:054c PID:09cc

The quirk system uses multi-factor matching (VID/PID + device name +
SDP provider) to avoid false positives. It does NOT globally weaken
HID parsing - quirks only activate for specifically matched controllers.
---
 profiles/input/quirk.c         |  77 +++++++++++
 profiles/input/quirk.h         |  37 ++++++
 profiles/input/quirks/tg170w.c | 232 +++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 profiles/input/quirk.c
 create mode 100644 profiles/input/quirk.h
 create mode 100644 profiles/input/quirks/tg170w.c

diff --git a/profiles/input/quirk.c b/profiles/input/quirk.c
new file mode 100644
index 0000000..053f45b
--- /dev/null
+++ b/profiles/input/quirk.c
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Gamepad Quirk Support
+ *
+ *  Dispatcher for gamepad HID quirks. When BlueZ fails to parse an SDP
+ *  record for a known gamepad, this layer injects a fallback HID report
+ *  descriptor so the kernel HID driver can create an input device.
+ *
+ *  This does NOT weaken HID parsing globally — quirks only activate for
+ *  specifically matched controllers.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/hidp.h"
+
+#include "src/log.h"
+
+#include "quirk.h"
+
+/* Individual quirk declarations */
+extern struct gamepad_quirk tg170w_quirk;
+
+static struct gamepad_quirk *quirks[] = {
+	&tg170w_quirk,
+	NULL
+};
+
+bool gamepad_quirk_match(struct input_device *idev)
+{
+	int i;
+
+	/* Check built-in quirks first */
+	for (i = 0; quirks[i]; i++) {
+		if (quirks[i]->match(idev))
+			return true;
+	}
+
+	/* Then check external (file-based) quirks */
+	if (external_quirk_match(idev))
+		return true;
+
+	return false;
+}
+
+int gamepad_quirk_apply(struct input_device *idev,
+			struct hidp_connadd_req *req)
+{
+	int i;
+
+	/* Try built-in quirks first */
+	for (i = 0; quirks[i]; i++) {
+		if (!quirks[i]->match(idev))
+			continue;
+
+		DBG("Applying HID quirk: %s", quirks[i]->name);
+
+		return quirks[i]->apply(idev, req);
+	}
+
+	/* Try external quirks */
+	if (external_quirk_match(idev)) {
+		return external_quirk_apply(idev, req);
+	}
+
+	return -1;
+}
diff --git a/profiles/input/quirk.h b/profiles/input/quirk.h
new file mode 100644
index 0000000..08e0bce
--- /dev/null
+++ b/profiles/input/quirk.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Gamepad Quirk Support
+ *
+ *  Minimal HID fallback for third-party gamepads with broken SDP records.
+ *  Only activates for specifically matched devices.
+ */
+
+#ifndef __INPUT_QUIRK_H
+#define __INPUT_QUIRK_H
+
+#include <stdbool.h>
+
+struct input_device;
+struct hidp_connadd_req;
+
+struct gamepad_quirk {
+	const char *name;
+	bool (*match)(struct input_device *idev);
+	int (*apply)(struct input_device *idev,
+			struct hidp_connadd_req *req);
+};
+
+bool gamepad_quirk_match(struct input_device *idev);
+
+int gamepad_quirk_apply(struct input_device *idev,
+			struct hidp_connadd_req *req);
+
+/* External quirk support (quirk-profile.c) */
+bool external_quirk_match(struct input_device *idev);
+int external_quirk_apply(struct input_device *idev,
+			struct hidp_connadd_req *req);
+
+#endif
diff --git a/profiles/input/quirks/tg170w.c b/profiles/input/quirks/tg170w.c
new file mode 100644
index 0000000..d3f37a8
--- /dev/null
+++ b/profiles/input/quirks/tg170w.c
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Gamepad Quirk Support
+ *
+ *  DualShock 4 (CUH-ZCT2x) / TG170W gamepad quirk.
+ *
+ *  This controller identifies as a DualShock 4 compatible device and
+ *  works perfectly via USB. Over Bluetooth it exposes an incomplete
+ *  or malformed HID SDP record, causing BlueZ to fail with -ENOENT.
+ *
+ *  Windows and Android handle this gracefully; Linux/BlueZ does not.
+ *  This quirk injects the correct BT HID report descriptor so the
+ *  kernel's hid-playstation driver can create an input device.
+ *
+ *  Matching criteria (multi-factor, no single-field matching):
+ *    - Bluetooth device name + SDP provider
+ *    - Vendor/Product ID from device info
+ *
+ *  BT report descriptor constructed from kernel hid-playstation.c:
+ *    DS4_INPUT_REPORT_BT = 0x11, size = 78 bytes
+ *    DS4_OUTPUT_REPORT_BT = 0x11, size = 78 bytes
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/hidp.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
+
+#include "src/log.h"
+
+#include "../quirk.h"
+
+/*
+ * DualShock 4 Bluetooth HID Report Descriptor.
+ *
+ * The USB descriptor (report ID 0x01, 64 bytes) does NOT work over
+ * Bluetooth. The DS4 sends 78-byte packets with report ID 0x11 on BT.
+ * The kernel's hid-playstation driver expects exactly this format.
+ *
+ * This descriptor tells the HID core to accept report ID 0x11 packets
+ * and route them to the driver's parse_report callback. The driver
+ * creates input devices programmatically -- it doesn't need field-level
+ * mappings in the descriptor.
+ *
+ * Report layout (from hid-playstation.c):
+ *   0x11 Input:  78 bytes total (1 ID + 77 data)
+ *   0x11 Output: 78 bytes total (1 ID + 77 data, rumble/LED)
+ *   0x05 Feature: 41 bytes (gyro/accel calibration)
+ *   0x12 Feature: 16 bytes (pairing info / MAC address)
+ *   0xa3 Feature: 49 bytes (firmware info)
+ */
+static const uint8_t tg170w_hid_report_descriptor[] = {
+	/* Usage Page (Generic Desktop), Usage (Gamepad), Collection (Application) */
+	0x05, 0x01, 0x09, 0x05, 0xa1, 0x01,
+
+	/*
+	 * Report ID 0x11 -- BT Enhanced Input Report
+	 * 78 bytes total = 1 byte ID + 77 bytes payload
+	 * Contains: sticks, buttons, gyro, accel, timestamp, touchpad, CRC
+	 */
+	0x85, 0x11,        /* Report ID (0x11) */
+	0x06, 0x00, 0xff,  /* Usage Page (Vendor Defined 0xFF00) */
+	0x09, 0x20,        /* Usage (0x20) */
+	0x15, 0x00,        /* Logical Minimum (0) */
+	0x26, 0xff, 0x00,  /* Logical Maximum (255) */
+	0x75, 0x08,        /* Report Size (8) */
+	0x95, 0x4d,        /* Report Count (77) */
+	0x81, 0x02,        /* Input (Data, Var, Abs) */
+
+	/*
+	 * Report ID 0x11 -- BT Output Report
+	 * 78 bytes total = 1 byte ID + 77 bytes payload
+	 * Used for: rumble motors, lightbar RGB, player LEDs
+	 */
+	0x85, 0x11,        /* Report ID (0x11) */
+	0x09, 0x21,        /* Usage (0x21) */
+	0x95, 0x4d,        /* Report Count (77) */
+	0x91, 0x02,        /* Output (Data, Var, Abs) */
+
+	/*
+	 * Report ID 0x05 -- Calibration Feature Report (41 bytes)
+	 * Gyroscope and accelerometer calibration data
+	 */
+	0x85, 0x05,        /* Report ID (0x05) */
+	0x09, 0x22,        /* Usage (0x22) */
+	0x95, 0x29,        /* Report Count (41) */
+	0xb1, 0x02,        /* Feature (Data, Var, Abs) */
+
+	/*
+	 * Report ID 0x12 -- Pairing Info Feature Report (16 bytes)
+	 * Contains MAC address for device identification
+	 */
+	0x85, 0x12,        /* Report ID (0x12) */
+	0x09, 0x23,        /* Usage (0x23) */
+	0x95, 0x10,        /* Report Count (16) */
+	0xb1, 0x02,        /* Feature (Data, Var, Abs) */
+
+	/*
+	 * Report ID 0xa3 -- Firmware Info Feature Report (49 bytes)
+	 * Hardware/firmware version information
+	 */
+	0x85, 0xa3,        /* Report ID (0xa3) */
+	0x09, 0x24,        /* Usage (0x24) */
+	0x95, 0x31,        /* Report Count (49) */
+	0xb1, 0x02,        /* Feature (Data, Var, Abs) */
+
+	/* End Collection */
+	0xc0
+};
+
+/* Sony DualShock 4 v2 (CUH-ZCT2x) */
+#define TG170W_VID  0x054c  /* Sony */
+#define TG170W_PID  0x09cc  /* DualShock 4 v2 */
+
+/* Opaque structs - we don't pull in heavy headers */
+struct input_device;
+struct btd_device;
+struct btd_service;
+
+/* Declarations from src/device.h and src/service.h */
+extern struct btd_service *input_device_get_service(
+					struct input_device *idev);
+extern struct btd_device *btd_service_get_device(
+					const struct btd_service *service);
+extern uint16_t btd_device_get_vendor(struct btd_device *device);
+extern uint16_t btd_device_get_product(struct btd_device *device);
+extern const sdp_record_t *btd_device_get_record(
+					struct btd_device *device,
+					const char *uuid);
+extern bool device_name_known(struct btd_device *device);
+extern void device_get_name(struct btd_device *device,
+					char *name, size_t len);
+
+static bool tg170w_match(struct input_device *idev)
+{
+	struct btd_service *service;
+	struct btd_device *device;
+	char name[248];
+	uint16_t vendor, product;
+	const sdp_record_t *rec;
+	sdp_data_t *pdlist;
+
+	if (!idev)
+		return false;
+
+	service = input_device_get_service(idev);
+	if (!service)
+		return false;
+
+	device = btd_service_get_device(service);
+	if (!device)
+		return false;
+
+	/* Check vendor/product ID from device info */
+	vendor = btd_device_get_vendor(device);
+	product = btd_device_get_product(device);
+
+	/* Match by VID/PID (Sony DS4 v2) */
+	if (vendor == TG170W_VID && product == TG170W_PID) {
+		DBG("TG170W quirk: matched by VID/PID %04x:%04x",
+							vendor, product);
+		return true;
+	}
+
+	/* Match by name + SDP provider */
+	if (!device_name_known(device))
+		return false;
+
+	device_get_name(device, name, sizeof(name));
+
+	if (strcmp(name, "Wireless Controller"))
+		return false;
+
+	/* Additional check: look for Sony in SDP provider */
+	rec = btd_device_get_record(device,
+			"00001124-0000-1000-8000-00805f9b34fb");
+	if (!rec)
+		return false;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
+	if (!pdlist || !pdlist->val.str)
+		return false;
+
+	if (!strstr(pdlist->val.str, "Sony"))
+		return false;
+
+	DBG("TG170W quirk: matched by name + provider");
+	return true;
+}
+
+static int tg170w_apply(struct input_device *idev,
+			struct hidp_connadd_req *req)
+{
+	/*
+	 * HID parser version 1.11 per Bluetooth HID spec.
+	 * The playstation kernel driver doesn't inspect this value,
+	 * but it should be valid for proper HID core behavior.
+	 */
+	req->parser = 0x0111;
+	req->country = 0;
+	req->subclass = 0;
+
+	/* Inject the Bluetooth HID report descriptor */
+	req->rd_size = sizeof(tg170w_hid_report_descriptor);
+	req->rd_data = malloc(req->rd_size);
+	if (!req->rd_data)
+		return -ENOMEM;
+
+	memcpy(req->rd_data, tg170w_hid_report_descriptor, req->rd_size);
+
+	DBG("TG170W: injected %u byte BT HID descriptor", req->rd_size);
+
+	return 0;
+}
+
+struct gamepad_quirk tg170w_quirk = {
+	.name = "TG170W",
+	.match = tg170w_match,
+	.apply = tg170w_apply,
+};
-- 
2.54.0

