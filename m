Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402A2FFF95
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381464; cv=pass; b=I7O/E9dXeJh2lAChlA2kSzXXLKfGUSZRAFL0mkcohy9c32ltGav6sQP54EeZDO2vrscSl+ox+UKCY5aNnmiYXMWdyfzagqbXfd7fq1sJkVkF/rg/Df/JcFPoAWghhoJ0pvPQNJ+yXXenF/YTTHHkXFL0/5mtI5wwP1SGFnHpuSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381464; c=relaxed/simple;
	bh=KH+JlwIDCpftsCwPo+HGM7+DRXnW0P2PNHmyz3W3Xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXJUcnUN/eqL/1Eyij7Bmz3umXfDasbQMafBwQsohaFFOd8SUQhuhbBGQvJtTWks/Oabge8D0+pHoxJZN8Kbw9Qlr2W8x0jXbOwo9q9/re3iW92U76DpcGFgJqJIcNO4TNyT7O28Jnhw3f0lFzEZAB8i3HhOeYqtzj0j7lSSO2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TaTVjfrB; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TaTVjfrB"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlR3lhZz108n;
	Wed, 10 Dec 2025 17:44:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3PfJpVNYlh3PTAIPP29gg3lR8YEtWCron8l+/gmzTo=;
	b=TaTVjfrBilsTklA0iUlI0W/TYPKKZ9NX+BXH+/LEGcQcUAUaIqzInz7EubqfDB4xI3dUpw
	Ou0laWh2i9vdx2QgCta/+sfkWo261YDCeO/cyAAQ+OaadXKuW2MJt9rShahZ5RCp0YdvbK
	Jbldx/8fnd3MbQUJh48+p8KAtNnpPhk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381459;
	b=jRFcNX4VzEiSwL3sS2sqNZSZMQotYcDPzaFDHPj9rDKMUHsS+2w/cLpaJ8GZPiwz4pdxMi
	T0Bbl4zeOcHf6wjLfsPhx4WjefjmPNPRwAK19Vnv6svvPOHzSFys3v+G6rxOs2KJOd1dRf
	4tJ49w5aGatm5NH6nq31JdBBxszEFEY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3PfJpVNYlh3PTAIPP29gg3lR8YEtWCron8l+/gmzTo=;
	b=iwHwvGXNFDrkxm2QNyyoVXG3Vxvf2UMmlLdhymS9DMCifGIYCMtaNtQX4CJf2+lVt2NA28
	PdSfKHzxkSmMJlCVxwa24IVXJkd/zmiZ9Wd6bpjTRtuVMMu9reUDpTTVLuSJ9srZjTKbS8
	/IFS1dWc5hkB3zAN2C3gerxdmauN2qU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 4/7] avctp: move uinput utilities to uinput-util.c
Date: Wed, 10 Dec 2025 17:44:09 +0200
Message-ID: <aa7fbf557c54a6dcc1004b5ff3846eb188a315d2.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
References: <cover.1765381438.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move basic uinput utilities to a separate file, so they can be reused
for MCS.
---
 Makefile.plugins             |   4 +-
 profiles/audio/avctp.c       | 119 +++--------------------------
 profiles/audio/uinput-util.c | 144 +++++++++++++++++++++++++++++++++++
 profiles/audio/uinput-util.h |  23 ++++++
 4 files changed, 179 insertions(+), 111 deletions(-)
 create mode 100644 profiles/audio/uinput-util.c
 create mode 100644 profiles/audio/uinput-util.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 3572ee845..54647e2ab 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -44,7 +44,9 @@ if AVRCP
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
-			profiles/audio/avrcp.h profiles/audio/avrcp.c
+			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/uinput-util.h \
+			profiles/audio/uinput-util.c
 endif
 
 if NETWORK
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 65eec6f6c..346a97dd1 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -44,6 +44,7 @@
 
 #include "avctp.h"
 #include "avrcp.h"
+#include "uinput-util.h"
 
 /* AV/C Panel 1.23, page 76:
  * command with the pressed value is valid for two seconds
@@ -228,11 +229,7 @@ struct avctp_browsing_pdu_handler {
 	GDestroyNotify destroy;
 };
 
-static const struct {
-	const char *name;
-	uint8_t avc;
-	uint16_t uinput;
-} key_map[] = {
+static const struct uinput_key_map key_map[] = {
 	{ "SELECT",		AVC_SELECT,		KEY_SELECT },
 	{ "UP",			AVC_UP,			KEY_UP },
 	{ "DOWN",		AVC_DOWN,		KEY_DOWN },
@@ -301,25 +298,9 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
-{
-	struct input_event event;
-
-	memset(&event, 0, sizeof(event));
-	event.type	= type;
-	event.code	= code;
-	event.value	= value;
-
-	return write(fd, &event, sizeof(event));
-}
-
 static void send_key(int fd, uint16_t key, int pressed)
 {
-	if (fd < 0)
-		return;
-
-	send_event(fd, EV_KEY, key, pressed);
-	send_event(fd, EV_SYN, SYN_REPORT, 0);
+	uinput_send_key(fd, key, pressed);
 }
 
 static bool auto_release(gpointer user_data)
@@ -401,12 +382,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
 	for (i = 0; key_map[i].name != NULL; i++) {
 		uint8_t key_quirks;
 
-		if ((operands[0] & 0x7F) != key_map[i].avc)
+		if ((operands[0] & 0x7F) != key_map[i].code)
 			continue;
 
 		DBG("AV/C: %s %s", key_map[i].name, status);
 
-		key_quirks = session->key_quirks[key_map[i].avc];
+		key_quirks = session->key_quirks[key_map[i].code];
 
 		if (key_quirks & QUIRK_NO_RELEASE) {
 			if (!pressed) {
@@ -1154,89 +1135,6 @@ failed:
 	return FALSE;
 }
 
-static int uinput_create(struct btd_device *device, const char *name,
-			 const char *suffix)
-{
-	struct uinput_user_dev dev;
-	int fd, err, i;
-	char src[18];
-
-	fd = open("/dev/uinput", O_RDWR);
-	if (fd < 0) {
-		fd = open("/dev/input/uinput", O_RDWR);
-		if (fd < 0) {
-			fd = open("/dev/misc/uinput", O_RDWR);
-			if (fd < 0) {
-				err = -errno;
-				error("Can't open input device: %s (%d)",
-							strerror(-err), -err);
-				return err;
-			}
-		}
-	}
-
-	memset(&dev, 0, sizeof(dev));
-
-	if (name) {
-		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
-		dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-	}
-
-	if (suffix) {
-		int len, slen;
-
-		len = strlen(dev.name);
-		slen = strlen(suffix);
-
-		/* If name + suffix don't fit, truncate the name, then add the
-		 * suffix.
-		 */
-		if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
-			strcpy(dev.name + len, suffix);
-		} else {
-			len = UINPUT_MAX_NAME_SIZE - slen - 1;
-			strncpy(dev.name + len, suffix, slen);
-			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-		}
-	}
-
-	dev.id.bustype = BUS_BLUETOOTH;
-	dev.id.vendor  = btd_device_get_vendor(device);
-	dev.id.product = btd_device_get_product(device);
-	dev.id.version = btd_device_get_version(device);
-
-	if (write(fd, &dev, sizeof(dev)) < 0) {
-		err = -errno;
-		error("Can't write device information: %s (%d)",
-						strerror(-err), -err);
-		close(fd);
-		return err;
-	}
-
-	ioctl(fd, UI_SET_EVBIT, EV_KEY);
-	ioctl(fd, UI_SET_EVBIT, EV_REL);
-	ioctl(fd, UI_SET_EVBIT, EV_REP);
-	ioctl(fd, UI_SET_EVBIT, EV_SYN);
-
-	ba2strlc(btd_adapter_get_address(device_get_adapter(device)), src);
-	ioctl(fd, UI_SET_PHYS, src);
-
-	for (i = 0; key_map[i].name != NULL; i++)
-		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
-
-	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
-		err = -errno;
-		error("Can't create uinput device: %s (%d)",
-						strerror(-err), -err);
-		close(fd);
-		return err;
-	}
-
-	send_event(fd, EV_REP, REP_DELAY, 300);
-
-	return fd;
-}
-
 static void init_uinput(struct avctp *session)
 {
 	char name[UINPUT_MAX_NAME_SIZE];
@@ -1249,7 +1147,8 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	session->uinput = uinput_create(session->device, name, " (AVRCP)");
+	session->uinput = uinput_create(device_get_adapter(session->device),
+				session->device, name, " (AVRCP)", key_map);
 	if (session->uinput < 0)
 		error("AVRCP: failed to init uinput for %s", name);
 	else
@@ -1793,7 +1692,7 @@ static const char *op2str(uint8_t op)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if ((op & 0x7F) == key_map[i].avc)
+		if ((op & 0x7F) == key_map[i].code)
 			return key_map[i].name;
 	}
 
@@ -2232,7 +2131,7 @@ bool avctp_supports_avc(uint8_t avc)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if (key_map[i].avc == avc)
+		if (key_map[i].code == avc)
 			return true;
 	}
 	return false;
diff --git a/profiles/audio/uinput-util.c b/profiles/audio/uinput-util.c
new file mode 100644
index 000000000..845602c84
--- /dev/null
+++ b/profiles/audio/uinput-util.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  Texas Instruments, Inc.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/uinput.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/log.h"
+
+#include "uinput-util.h"
+
+
+static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
+{
+	struct input_event event;
+
+	memset(&event, 0, sizeof(event));
+	event.type	= type;
+	event.code	= code;
+	event.value	= value;
+
+	return write(fd, &event, sizeof(event));
+}
+
+void uinput_send_key(int fd, uint16_t key, int pressed)
+{
+	if (fd < 0)
+		return;
+
+	send_event(fd, EV_KEY, key, pressed);
+	send_event(fd, EV_SYN, SYN_REPORT, 0);
+}
+
+int uinput_create(struct btd_adapter *adapter, struct btd_device *device,
+					const char *name, const char *suffix,
+					const struct uinput_key_map *key_map)
+{
+	struct uinput_user_dev dev;
+	int fd, err, i;
+	char src[18];
+
+	fd = open("/dev/uinput", O_RDWR);
+	if (fd < 0) {
+		fd = open("/dev/input/uinput", O_RDWR);
+		if (fd < 0) {
+			fd = open("/dev/misc/uinput", O_RDWR);
+			if (fd < 0) {
+				err = -errno;
+				error("Can't open input device: %s (%d)",
+							strerror(-err), -err);
+				return err;
+			}
+		}
+	}
+
+	memset(&dev, 0, sizeof(dev));
+
+	if (name) {
+		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
+		dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
+	}
+
+	if (suffix) {
+		int len, slen;
+
+		len = strlen(dev.name);
+		slen = strlen(suffix);
+
+		/* If name + suffix don't fit, truncate the name, then add the
+		 * suffix.
+		 */
+		if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
+			strcpy(dev.name + len, suffix);
+		} else {
+			len = UINPUT_MAX_NAME_SIZE - slen - 1;
+			strncpy(dev.name + len, suffix, slen);
+			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
+		}
+	}
+
+	if (device) {
+		dev.id.bustype = BUS_BLUETOOTH;
+		dev.id.vendor  = btd_device_get_vendor(device);
+		dev.id.product = btd_device_get_product(device);
+		dev.id.version = btd_device_get_version(device);
+	} else {
+		dev.id.bustype = BUS_VIRTUAL;
+		dev.id.vendor  = 0;
+		dev.id.product = 0;
+		dev.id.version = 0;
+	}
+
+	if (write(fd, &dev, sizeof(dev)) < 0) {
+		err = -errno;
+		error("Can't write device information: %s (%d)",
+						strerror(-err), -err);
+		close(fd);
+		return err;
+	}
+
+	ioctl(fd, UI_SET_EVBIT, EV_KEY);
+	ioctl(fd, UI_SET_EVBIT, EV_REL);
+	ioctl(fd, UI_SET_EVBIT, EV_REP);
+	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+
+	ba2strlc(btd_adapter_get_address(adapter), src);
+	ioctl(fd, UI_SET_PHYS, src);
+
+	for (i = 0; key_map[i].name != NULL; i++)
+		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+
+	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
+		err = -errno;
+		error("Can't create uinput device: %s (%d)",
+						strerror(-err), -err);
+		close(fd);
+		return err;
+	}
+
+	send_event(fd, EV_REP, REP_DELAY, 300);
+
+	return fd;
+}
diff --git a/profiles/audio/uinput-util.h b/profiles/audio/uinput-util.h
new file mode 100644
index 000000000..75de8aedd
--- /dev/null
+++ b/profiles/audio/uinput-util.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  Texas Instruments, Inc.
+ *
+ *
+ */
+
+struct uinput_key_map {
+	const char *name;
+	unsigned int code;
+	uint16_t uinput;
+};
+
+int uinput_create(struct btd_adapter *adapter, struct btd_device *device,
+					const char *name, const char *suffix,
+					const struct uinput_key_map *key_map);
+
+void uinput_send_key(int fd, uint16_t key, int pressed);
-- 
2.51.1

