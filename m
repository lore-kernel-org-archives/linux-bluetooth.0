Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE241537C3
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264538; cv=none; b=t/y7ySZFJNdnZDGwWpp31DeT06f5FJ2E1RfPemhKg0Of+689GERy7KXNXqbtXfV8eVA9Rp7i+iX1TOtY1LUH3Py1diPMkkDVknP7D5K7ma8LN+jEs2NZL4Wzbyh5jJdrrxPLCiZeosb2f1UxlWNXvsGsXZeWV9fXa5aA+QH4fZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264538; c=relaxed/simple;
	bh=W5NZK7KIy+Inplry4B0UXBadMl222NitGabsNH8E8+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9mEDmwiRu3sy+iGEA2NVP6ppJ8bZchWVw5W9bfOdHKACCV2DFwXp6fmiN4GZLIb7hCcJB03ymbBRx5FjXNuRaJQXmbGBGj7GrxHw4mHi9wy9Ie/WvnRuiskmNQWbZcgB9ErEsAOyie6GVgWix7lH5dq1CMDT0Y//ytjdbBplz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYJBLq+G; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYJBLq+G"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-518a861612eso6909639e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736264534; x=1736869334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQwsgiFMkdpdDQj+PmEbQreX5JhLkcN9gZBCLQQcqmE=;
        b=MYJBLq+GvOQrIkurlNsy4hG6OYhk5GFuhrCpG8yGuT6NyOaAz94brBs+mDJeIFbujs
         RZ/qA9gqQ0SLS+h/fdc7z4haFHQcY5ZXpbVD2r13GuhFtG8sog3JWI4jzLcuzmRdOsVK
         Wfqpvs9+rzHspswp8x83sGuQA1kcMc77ckxlK8gnd7oMpbyYHNHl2fm1sitF/cVf8jPl
         ULWKOnoH9jHmowEzhl2Uoo9Zt/yH3xLc6+qt/Go37whu+NDD7R0TeZ4kQGpAAYKIHRi8
         s9ze4l85qPa8UdWLJhIz8hhznjZyXH5MFgr/K/c45nys9r8hHddBJ92uqR+vKae5mpQi
         GmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264534; x=1736869334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQwsgiFMkdpdDQj+PmEbQreX5JhLkcN9gZBCLQQcqmE=;
        b=ctAatAUMk5FqpG1qufrXPpBAIFhQ7Bp+MEPaFIfTQH8Bw9raE02wxMVXM2p0x6Gu7T
         rYfV8RxVgy5CdKCWb/Mxz/4azBFMHVdY3PPFx7F8ZrNHu4+uzcsMCI6CDxpcQvw9dnvO
         7/Jz/PSQYkP4FoCFdMbl6lsxQ41u6UDrsL4xL8SPJgdxN+Yj3O6xvQkUeRfaswNMeWpU
         tK+iwnDBjXVrmF3LP8SE1b0p/yJRDDgDwjJDIB72+jTIrCkNnlXHAxbHYUBLfEPLz09K
         5Fq/87GAPRSpzkyrx+LDxQl2q/mRw/H0cRW8CM3C9ZaYzJPADzcZyGuRi+4+Tx3YwEmt
         EY4A==
X-Gm-Message-State: AOJu0YzJNPrjHGwvTpdeKz3qAUEyQOzBnY1Z/XlNvuWW4EWv1jCNjm6x
	9B8Sbkai6yfaQ/mVYtVUaNPYTWMQG6nLGYuRhcDQwYDUIGhjCrqjgRBfpQ==
X-Gm-Gg: ASbGncs2oWPQxinuiQs3i3R24lNdMgkQnpi0AGxsDIMsXz6Hk/L3OpRxAe+CSkhkprh
	L5hdwz4mZkc31OoFTO7m65pqFpXXtm51PiqclPWicYtBprHlFdoroRP3bRxnbKtYfbA+V0nEt7a
	C6I1XAK7VouE3Ea4alDzuHiVwJivV5BTS6mavJANHGwubmrJAvnusapGbDr4jTpav8NAs0deKSA
	Ak+tI/gBKtDtSJ1vcCZXufnikbWw+Ll69RA8u0j6HqiVSQQU1Q1xEKZli2lvY+UUg5pdElN6Ugd
	fSP086bGjbk+A6euSw4EP5DyfUJ6
X-Google-Smtp-Source: AGHT+IH/J5y9unzzZG2GjPBih9vbv8TfKd41UHf1jzGStwFbhguNR5Lu9WsUP+lS/m9O4gy6PlIAGA==
X-Received: by 2002:a05:6122:488e:b0:515:1fde:1cb1 with SMTP id 71dfb90a1353d-51c5e5e1bedmr2367676e0c.3.1736264533720;
        Tue, 07 Jan 2025 07:42:13 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ad5a3fesm7999762241.33.2025.01.07.07.42.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:42:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] build: Remove wiimote plugin
Date: Tue,  7 Jan 2025 10:42:08 -0500
Message-ID: <20250107154208.1414463-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107154208.1414463-1-luiz.dentz@gmail.com>
References: <20250107154208.1414463-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.plugins  |   3 --
 plugins/wiimote.c | 130 ----------------------------------------------
 2 files changed, 133 deletions(-)
 delete mode 100644 plugins/wiimote.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 9da29a3ce43a..7644041b3b6d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -2,9 +2,6 @@
 builtin_modules += hostname
 builtin_sources += plugins/hostname.c
 
-builtin_modules += wiimote
-builtin_sources += plugins/wiimote.c
-
 builtin_modules += autopair
 builtin_sources += plugins/autopair.c
 
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
deleted file mode 100644
index 9c4e0a58b0c8..000000000000
--- a/plugins/wiimote.c
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012 David Herrmann <dh.herrmann@googlemail.com>
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdbool.h>
-
-#include <glib.h>
-
-#include "bluetooth/bluetooth.h"
-#include "bluetooth/sdp.h"
-
-#include "src/plugin.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/log.h"
-#include "src/storage.h"
-
-/*
- * Nintendo Wii Remote devices require the bdaddr of the host as pin input for
- * authentication. This plugin registers a pin-callback and forces this pin
- * to be used for authentication.
- *
- * There are two ways to place the wiimote into discoverable mode.
- *  - Pressing the red-sync button on the back of the wiimote. This module
- *    supports pairing via this method. Auto-reconnect should be possible after
- *    the device was paired once.
- *  - Pressing the 1+2 buttons on the front of the wiimote. This module does
- *    not support this method since this method never enables auto-reconnect.
- *    Hence, pairing is not needed. Use it without pairing if you want.
- * After connecting the wiimote you should immediately connect to the input
- * service of the wiimote. If you don't, the wiimote will close the connection.
- * The wiimote waits about 5 seconds until it turns off again.
- * Auto-reconnect is only enabled when pairing with the wiimote via the red
- * sync-button and then connecting to the input service. If you do not connect
- * to the input service, then auto-reconnect is not enabled.
- * If enabled, the wiimote connects to the host automatically when any button
- * is pressed.
- */
-
-static uint16_t wii_ids[][2] = {
-	{ 0x057e, 0x0306 },		/* 1st gen */
-	{ 0x054c, 0x0306 },		/* LEGO wiimote */
-	{ 0x057e, 0x0330 },		/* 2nd gen */
-};
-
-static const char *wii_names[] = {
-	"Nintendo RVL-CNT-01",		/* 1st gen */
-	"Nintendo RVL-CNT-01-TR",	/* 2nd gen */
-	"Nintendo RVL-CNT-01-UC",	/* Wii U Pro Controller */
-	"Nintendo RVL-WBC-01",		/* Balance Board */
-};
-
-static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
-						char *pinbuf, bool *display,
-						unsigned int attempt)
-{
-	uint16_t vendor, product;
-	char addr[18], name[25];
-	unsigned int i;
-
-	/* Only try the pin code once per device. If it's not correct then it's
-	 * an unknown device. */
-	if (attempt > 1)
-		return 0;
-
-	ba2str(device_get_address(device), addr);
-
-	vendor = btd_device_get_vendor(device);
-	product = btd_device_get_product(device);
-
-	device_get_name(device, name, sizeof(name));
-
-	for (i = 0; i < G_N_ELEMENTS(wii_ids); ++i) {
-		if (vendor == wii_ids[i][0] && product == wii_ids[i][1])
-			goto found;
-	}
-
-	for (i = 0; i < G_N_ELEMENTS(wii_names); ++i) {
-		if (g_str_equal(name, wii_names[i]))
-			goto found;
-	}
-
-	return 0;
-
-found:
-	DBG("Forcing fixed pin on detected wiimote %s", addr);
-	memcpy(pinbuf, btd_adapter_get_address(adapter), 6);
-	return 6;
-}
-
-static int wii_probe(struct btd_adapter *adapter)
-{
-	btd_adapter_register_pin_cb(adapter, wii_pincb);
-
-	return 0;
-}
-
-static void wii_remove(struct btd_adapter *adapter)
-{
-	btd_adapter_unregister_pin_cb(adapter, wii_pincb);
-}
-
-static struct btd_adapter_driver wii_driver = {
-	.name	= "wiimote",
-	.probe	= wii_probe,
-	.remove	= wii_remove,
-};
-
-static int wii_init(void)
-{
-	return btd_register_adapter_driver(&wii_driver);
-}
-
-static void wii_exit(void)
-{
-	btd_unregister_adapter_driver(&wii_driver);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(wiimote, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_LOW, wii_init, wii_exit)
-- 
2.47.1

