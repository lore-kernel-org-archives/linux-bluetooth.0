Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB841612A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954815; cv=none; b=JBrCFAw4Et0H4fog9uqHWQCuk7uR0CIb+InXphRoB5vo8wHZ7qCAK39V4zIbXtXt8R8qNrH/r16dxgYLSCcGKXtELNJ5ZVjmfz1mF3Zye9xocRxucSr7Zyp6PeC8PTBGfcIOiC5Q0eCUkmURIkQRrxYLD+s9kx9APwcVLBcQglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954815; c=relaxed/simple;
	bh=oywBdLDEcjZDFq+9iuYfLGLsETO7cHuAYe/JwThlHqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baKrBmgsNMo5ByrDRTwvdr64IcRZWo2ERnapKfqgSA/PJUtQVbYAQT06qeP8P8uv6fcO2D8O+7p21fiHvChupmM+GVflHLe+XHItFIROZpuf6rCeBcf8zW9DhybS3AP0/RJTD3jPi9R0bUmi2DGRi7tzkFu0p7el48VvD5Tn4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz6dHio/; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz6dHio/"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so978267eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954813; x=1792559613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbrAl4iXjYZps9DF+3rtsVZzKDneDB3d0OFOe728cek=;
        b=jz6dHio/ZX11zeezNQHm7aJgxfW4dSL46sKUXLF57aDoMvdctU3+1qi1H5Ohop6V1q
         4Eik0x7dWykCU665WC/vqsPnhSS37hTDcJsC2ITrnTh3dD5FBvAaFw4CBa1lJJIJNqeN
         vbL5VGBBBxLXTwunRO6OFGq+ol3XP3pNBVpKQCB0R0PruG5YUQAWq/W66kdQNVcV2JSm
         JIU4XTF03YbzDq8+hbofA0AzAZMxfMFGPIeZJx3QupK2a/zCHfHE3Qg3cA7DucVsmvAh
         DMtTKaJf0nTwDldolrl7dNRvSow1p9aFg5K9+ZilvVZeEMZ0xCDI0+YdDPDkmJR5FT+B
         FSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954813; x=1792559613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbrAl4iXjYZps9DF+3rtsVZzKDneDB3d0OFOe728cek=;
        b=2lDyIVpsMaA7XjMVw2OWTYlgcogGRUatb+uPm+AiqwsBomcdPzfjB270dp+0Bkgx11
         d6b6IEpUFA0fXNUgSfqnYLxL6E7DlD8gcIPsfIALEG2xq6MGMQREjNlAzChqrmDeZeOe
         HrL+HXLATbZulrGBxrcwC/GUjYwyjl/OyN+2SSM260D8PaxjLoiN+cOgbTKmybqsYBjd
         3JDDNmxT3WWpLjQxnRn7OwmTW8om5HLk2lmQg4Rd+UEK8GqvHBZcgoozEcxSBrSJMTtJ
         jI8ZvvZqhYvykG5XYEJXMOjy07PTHEC7lHUfX713SWYvMuvo9D0u/5Kd3VgYjwATaylz
         pMIg==
X-Forwarded-Encrypted: i=1; AKwUvByvkOsmsMse1gVCwxQJ+NgPxzkAP+DcIh4N7GF8HI0U7fulaZmwJJg80CBo+hL8YcveBFxO0rtnZvlVwk4H03M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI93+jPoGWf+JiF4wfPDIb3d9G/z+JX1Oq+35TszWzHKiy5z3L5
	0s/8O2GB3FoOxM9n3/RE3LWE/69s35CO98xqeLg3ASG2JJa7P8ILff2X
X-Gm-Gg: AYBFou3h7F70xW/7FrgHKWfJVzS3c0MI7bG1NQ0+ECph+etXrEEaIeMZ8GRHzOVin0M
	fattKfP1ETkd2dtYiVzGKYBUAqRdxvot8k1jsmCxWp0bYsEe8OB3Fco3lVm/gS9f/J4mceCAnpY
	uuYCxtXpjc+cTtoT039r95c2sn6tVoVtP4bnXcVkXTkUSDyEeLRqd+DSxO5BCWy0WqCcfbx52Lh
	ylE2bVSkVblOravgdc8fBlZJ+73n5b1DQbHZzWlz5PtQvCOqcTCll0Pt2xbT+rJHXbcGKXWbnTo
	duXSlUP4PPMJn9aByZGbK2l9FYe7VjtkUaea/LnyhEUgyMvGKrzAKt8GCH5JVtCxvtbla6O1ASv
	gYxmDY7aE/9woO2K7JLX55p8OdPZ7OKEx0MtDOhzoHuZQG1buuVEAEZ6BIPZP5to1KmaEOPJCWw
	BSXYUFZj6d9V6SdNDuZ35kGPGsLmixnqoGmv+yjsqJPT1MuIr8woz84KzZHrNt8h5Tm/jSJsEJD
	2nO/HUmrXEf30culz9iRrQFtKK6Hj8P2VNEU+v1Xs4f/GvmtPYv2XaXhj0AR7nZYajlFJkhKg==
X-Received: by 2002:a05:7301:6207:b0:341:5da1:7851 with SMTP id 5a478bee46e88-3537df5970cmr22754300eec.12.1791954813246;
        Tue, 13 Oct 2026 22:13:33 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:32 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] HID: core: Move internal declarations and drop unused exports
Date: Tue, 13 Oct 2026 22:13:21 -0700
Message-ID: <20261014051326.3784498-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several declarations in the public HID header and exported symbols are
used solely within the core HID module (linked together from hid-core,
hid-input, and hid-quirks into hid.o).

Move internal request, input hook, resolution multiplier, and device
matching declarations into a private header shared across core HID
sources, and drop the unused GPL symbol exports.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c   |  3 +--
 drivers/hid/hid-core.h   | 20 ++++++++++++++++++++
 drivers/hid/hid-input.c  |  4 +---
 drivers/hid/hid-quirks.c |  1 +
 include/linux/hid.h      |  8 --------
 5 files changed, 23 insertions(+), 13 deletions(-)
 create mode 100644 drivers/hid/hid-core.h

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af..ec44d99fd416 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -33,6 +33,7 @@
 #include <linux/hid-debug.h>
 #include <linux/hidraw.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 /*
@@ -1243,7 +1244,6 @@ void hid_setup_resolution_multiplier(struct hid_device *hid)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
 
 static int hid_parse_collections(struct hid_device *device)
 {
@@ -2031,7 +2031,6 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__hid_request);
 
 int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
 			 size_t bufsize, u32 size, int interrupt)
diff --git a/drivers/hid/hid-core.h b/drivers/hid/hid-core.h
new file mode 100644
index 000000000000..f20028d499fe
--- /dev/null
+++ b/drivers/hid/hid-core.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __HID_CORE_H
+#define __HID_CORE_H
+
+#include <linux/hid.h>
+
+int __hid_request(struct hid_device *hid, struct hid_report *report,
+		  enum hid_class_request reqtype);
+
+int hidinput_connect(struct hid_device *hid, unsigned int force);
+void hidinput_disconnect(struct hid_device *hid);
+void hidinput_hid_event(struct hid_device *hid, struct hid_field *field,
+			struct hid_usage *usage, __s32 value);
+void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
+
+void hid_setup_resolution_multiplier(struct hid_device *hid);
+bool hid_match_one_id(const struct hid_device *hdev,
+		      const struct hid_device_id *id);
+
+#endif /* __HID_CORE_H */
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..770087c4cf5d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -20,6 +20,7 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 #define unk	KEY_UNKNOWN
@@ -1793,7 +1794,6 @@ void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
 	list_for_each_entry(hidinput, &hid->inputs, list)
 		input_sync(hidinput->input);
 }
-EXPORT_SYMBOL_GPL(hidinput_report_event);
 
 static int hidinput_find_field(struct hid_device *hid, unsigned int type,
 			       unsigned int code, struct hid_field **field)
@@ -2418,7 +2418,6 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 
 	return -1;
 }
-EXPORT_SYMBOL_GPL(hidinput_connect);
 
 void hidinput_disconnect(struct hid_device *hid)
 {
@@ -2440,7 +2439,6 @@ void hidinput_disconnect(struct hid_device *hid)
 	 * synchronously and are safe. */
 	cancel_work_sync(&hid->led_work);
 }
-EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
 void hidinput_reset_resume(struct hid_device *hid)
 {
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b89..db5dda650ed3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/input/elan-i2c-ids.h>
 
+#include "hid-core.h"
 #include "hid-ids.h"
 
 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b240baa95ab5..b956ae6b753c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1019,10 +1019,6 @@ extern void hid_unregister_driver(struct hid_driver *);
 	module_driver(__hid_driver, hid_register_driver, \
 		      hid_unregister_driver)
 
-extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
-extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
-extern int hidinput_connect(struct hid_device *hid, unsigned int force);
-extern void hidinput_disconnect(struct hid_device *);
 void hidinput_reset_resume(struct hid_device *hid);
 
 struct hid_field *hid_find_field(struct hid_device *hdev, unsigned int report_type,
@@ -1036,7 +1032,6 @@ struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
 void hid_output_report(struct hid_report *report, __u8 *data);
-int __hid_request(struct hid_device *hid, struct hid_report *rep, enum hid_class_request reqtype);
 u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device,
@@ -1048,13 +1043,10 @@ struct hid_report *hid_validate_values(struct hid_device *hid,
 				       unsigned int field_index,
 				       unsigned int report_counts);
 
-void hid_setup_resolution_multiplier(struct hid_device *hid);
 int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 void hid_disconnect(struct hid_device *hid);
-bool hid_match_one_id(const struct hid_device *hdev,
-		      const struct hid_device_id *id);
 const struct hid_device_id *hid_match_id(const struct hid_device *hdev,
 					 const struct hid_device_id *id);
 const struct hid_device_id *hid_match_device(struct hid_device *hdev,
-- 
2.56.0.385.gd3acb90ef8-goog
