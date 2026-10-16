Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632546AA76
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190536; cv=none; b=IzABGTDoRP4Pg7OQfUVlWYo7pVtNhObMfvknRUDe05aKd0NhhP+B1caqTgrpf+jLA2PCDMDWxf9HjvWKxQZN0b3Bj0tlreq2f+EEeFm1IKeltYSAHLbtA10JV2SO0CYHOcrRsL0C20X+5YK/MtVkLxRvQJNKI9W6Sov6JmEa3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190536; c=relaxed/simple;
	bh=Rw9aV4le86GVAEmQTP31OJXRV0V+qY5c0x7bP9ImTYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujzlX9viwemPERIQo9nhtu411WwAOpCoSPn+Ifggvwhgt3tA41gi4el2mR2X/V4Nb/igKAjswiFSHeX0pRBNeXTWZftbrAsT54Mqkcy95ZQINxhQLLdE4UuGTPam62Nk8olbcgGrZoWQDkWOqg5xt2fzez115V2pnKcCsLOyPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU7RV4dH; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU7RV4dH"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-144f79153f5so1238153c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190534; x=1792795334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjuLIsLQ3Bd+lun4kkKhpyxvOHsckr/v5FH4N+lOssM=;
        b=kU7RV4dH7TS6qo2U6eYb8Wz4VdQwzF0sh7iO+dI7KULziRBbge7am/jinDfi+eBn+j
         3NcYQUO9m0g5tuybHYNNGP4thwZMChqIrlJmGz/5CUdMpZO8ut4qgaAGFjd/ixQEB1LT
         2wa0S8rVhhaFwTbrnwJfHTXhvacwMjXIpgTnm7gpkGjZs492qwk/6wUuKcyOpMY7kKNX
         QLKXMRrpjxWzbMxZiPGkKkyv1LYqhNxBO/lwD1aTc2Ihb1bcPq1hC9FKvURKQvmolca7
         DAyin/ll6/BdM3O2AgwFy+eYT9PUiaHSiD2d36FxPgfxgYCVv9AZ10VhI5+O3stxR2zJ
         gnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190534; x=1792795334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjuLIsLQ3Bd+lun4kkKhpyxvOHsckr/v5FH4N+lOssM=;
        b=YhKLX9D16UOzj2UvYbJmFHAIOTwswW1NMIxyXEP6ZHhe8njICikZiOUe34MFFRAWMJ
         V1QlJCeu5ZHCsIv83LvPyYm4Wlt8H+DNRLQ170p/FxF3Y1kRoiGzUmYIFJe8MqylbABH
         12RvZKk6XNiANr6kWRNCo+0A6fvlU460g5KbWlfXl5s2IKFA+klnl8873b96HtgX0S9G
         gGEiGKzzyQhDSPsHGxvfi5MEdUA4j9llLW1UMSz/ZYm6KdGWz60tw85sJnblsDgJvNof
         cGBuiwij5oW9DYyErktLlCV27sYb1si6tHnhMHmfTIpmso8QVu2joGtzUbdDozgbEzh7
         SpSA==
X-Forwarded-Encrypted: i=1; AKwUvBxxJYLiue5poske/xLDlKUkCVK1VxJ9M/h4/dzJli7YwUdvxb/CZjv9ier/6UjOaHwhdbwlfQdx9VivkrbRFcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjKjw6TITn4zIn/5sWfw4k3XL3fw7RNKUIEzid2+eXAWQ90+rC
	+gmvgzbpoBJWrjKCw1LlGdWcOtLx6S5teTI3IynkyREkqM32XTBHK+v/
X-Gm-Gg: AYBFou0hWrPQISWimJq2+0eoCkWLuTXo/icqBuP3/G5775wPr6erhUVrKbgvBoQ39SV
	t4BVsHhpUFCp+gHCijsPD7aN7JoetTsyJqwZNjf3ZaPE9B790cWJYJQp8Yb/cu9SDG99kK7UCxA
	b5avEJdunxSn44zbWnlpWly3GnEHCizxI+zs0zomFc8pQEjRYUV1wtK+JdR4M9TPPrBNFb6Wwb/
	RPuBSYaht/8rvQLZmSFwUGE+ADsQekfZBjnl+j5jMgHUYIWX3Sky0PSMinTpinLYYyi6boNlMtc
	yMjPyonXo9CiI6TDbktHE/rJI+N565kqiR0tBSrydQVsK0Dgb4xwlV13pSHiNpYDBsCrb3HWgl5
	2J9ZHfKpG5MWY79BjU72T3TTE48qLXT2gJ4YNDWOSpvZxwPmDEp+DCiHUa5yzmyQ8oeMqnu2SHB
	619rWQwiunba8jEfrk3M5sdEJ0RRNNS/FNprgm83ljqH83oiUTe1w3Fs+DHb3troxw5TfbwJ74W
	D3Z0oasJXUSWYgYeEMgW12E1N0M8kJaJHm/hahdpLYA6Mh1lqaIdWcLrhI2IcU=
X-Received: by 2002:a05:7022:1407:b0:183:840:1dad with SMTP id a92af1059eb24-18308402161mr4345887c88.14.1792190533933;
        Fri, 16 Oct 2026 15:42:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm8252348c88.21.2026.10.16.15.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:42:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 16 Oct 2026 15:41:52 -0700
Subject: [PATCH v2 5/5] HID: hidraw: Make hidraw.h private to HID subsystem
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-test-hidraw-base-v2-5-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Michael Zaidman <michael.zaidman@gmail.com>, Rishi Gupta <gupt21@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrej Shadura <andrew@shadura.me>, 
 Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

With all external consumers converted to use the hidraw instance helper,
hidraw.h no longer needs to be exposed in include/linux.

Move the header into drivers/hid, keep private buffer and list
structures internal to hidraw.c, and drop unneeded symbol exports
since hidraw and hid-core are built into the same module.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c                  |  2 +-
 drivers/hid/hid-cp2112.c                |  2 +-
 drivers/hid/hid-led.c                   |  2 +-
 drivers/hid/hid-u2fzero.c               |  2 +-
 drivers/hid/hidraw.c                    | 33 +++++++++++++++++++++++++++++----
 {include/linux => drivers/hid}/hidraw.h | 29 +----------------------------
 6 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 85433f64bda1..8ee3be98811a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -31,10 +31,10 @@
 #include <linux/hid.h>
 #include <linux/hiddev.h>
 #include <linux/hid-debug.h>
-#include <linux/hidraw.h>
 
 #include "hid-core.h"
 #include "hid-ids.h"
+#include "hidraw.h"
 
 /*
  * Version Information
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 148946b04bff..0f65ce44e677 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -20,7 +20,6 @@
 #include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -28,6 +27,7 @@
 #include <linux/string_choices.h>
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
+#include "hidraw.h"
 
 /**
  * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 63fd723d9e69..f5a798c7979e 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -8,12 +8,12 @@
  */
 
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 
 #include "hid-ids.h"
+#include "hidraw.h"
 
 enum hidled_report_type {
 	RAW_REQUEST,
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 83e223c12cd6..4b9271b4e45e 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/hw_random.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -21,6 +20,7 @@
 
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
+#include "hidraw.h"
 
 #define DRIVER_SHORT		"u2fzero"
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 949e7546339f..9d0df711ed5d 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -27,8 +27,36 @@
 #include <linux/mutex.h>
 #include <linux/sched/signal.h>
 #include <linux/string.h>
+#include <uapi/linux/hidraw.h>
+
+#include "hidraw.h"
+
+struct hidraw {
+	unsigned int minor;
+	int exist;
+	int open;
+	wait_queue_head_t wait;
+	struct hid_device *hid;
+	struct device *dev;
+	spinlock_t list_lock;
+	struct list_head list;
+};
+
+struct hidraw_report {
+	__u8 *value;
+	int len;
+};
 
-#include <linux/hidraw.h>
+struct hidraw_list {
+	struct hidraw_report buffer[HIDRAW_BUFFER_SIZE];
+	int head;
+	int tail;
+	struct fasync_struct *fasync;
+	struct hidraw *hidraw;
+	struct list_head node;
+	struct mutex read_mutex;
+	bool revoked;
+};
 
 static int hidraw_major;
 static struct cdev hidraw_cdev;
@@ -594,7 +622,6 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	wake_up_interruptible(&dev->wait);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hidraw_report_event);
 
 int hidraw_connect(struct hid_device *hid)
 {
@@ -651,7 +678,6 @@ int hidraw_connect(struct hid_device *hid)
 	return result;
 
 }
-EXPORT_SYMBOL_GPL(hidraw_connect);
 
 void hidraw_disconnect(struct hid_device *hid)
 {
@@ -663,7 +689,6 @@ void hidraw_disconnect(struct hid_device *hid)
 
 	up_write(&minors_rwsem);
 }
-EXPORT_SYMBOL_GPL(hidraw_disconnect);
 
 /**
  * hidraw_instance - get hidraw instance minor number for a HID device
diff --git a/include/linux/hidraw.h b/drivers/hid/hidraw.h
similarity index 63%
rename from include/linux/hidraw.h
rename to drivers/hid/hidraw.h
index 3021454ba513..a822007ce5f8 100644
--- a/include/linux/hidraw.h
+++ b/drivers/hid/hidraw.h
@@ -6,35 +6,8 @@
 #define _HIDRAW_H
 
 #include <linux/errno.h>
-#include <uapi/linux/hidraw.h>
 
-
-struct hidraw {
-	unsigned int minor;
-	int exist;
-	int open;
-	wait_queue_head_t wait;
-	struct hid_device *hid;
-	struct device *dev;
-	spinlock_t list_lock;
-	struct list_head list;
-};
-
-struct hidraw_report {
-	__u8 *value;
-	int len;
-};
-
-struct hidraw_list {
-	struct hidraw_report buffer[HIDRAW_BUFFER_SIZE];
-	int head;
-	int tail;
-	struct fasync_struct *fasync;
-	struct hidraw *hidraw;
-	struct list_head node;
-	struct mutex read_mutex;
-	bool revoked;
-};
+struct hid_device;
 
 #ifdef CONFIG_HIDRAW
 int hidraw_init(void);

-- 
2.56.0.176.g3575e65682-goog

