Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAE236A8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572369; cv=pass; b=IP9keEvdluJabmsr90F26Jhnbp+/sNpzXTgL30T6Mom8kwsc6KXiaqmU5shX0FesIUU5jowcKT8azHN0eN6U5pzYrWUZ5l8VR9+L/uwlNrNbxr/8RojShiGsfs2Am2i3w6FoVh9BGMFKnC2GN6mdBnxuvqDjbUVSaKHK6IykO8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572369; c=relaxed/simple;
	bh=D7KVNQbzl+BmaWb92kO66vEmmqhow8GWvSuvFBzuGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEjv1xXAiiJtoESPZGbhr6rFagk62cEu/uHC4LuoQgO3PkaDNYSH0i9LAjRb7lVkzeeE8dOtQstQOkR4gjJrtGIN3rYqn9IUKUOO2K+cVWzKlsBKUwqxjvckaTbAcAuyAphtBGAsmN1E1sRbXvPVYOHT+HIgASX1sfwgi9VTkKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BxBqNv/P; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BxBqNv/P"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLh5gqVz106X;
	Fri, 12 Dec 2025 22:46:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdJdFHejFzivH0K4HrpPqfVJQpqXhlK9JXl5+TwJA8I=;
	b=BxBqNv/PBWa/k/ox8va/98brdvoZipKPqcQS7Ti1Od61lPP9DVgCzjiqCQ3rzEYoCPumP1
	/r29Dz2R6gs4vhpdWjjidcoRd5FNQD/D76sGOQeE+8cVcuFPiM2Y/DPb+ieZ/XmEtbHQR5
	H5neOL3F7mwf3mdEkWs5p5+rGCcK8VE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572365;
	b=CjPfyhJKRNRVS9+HrSELiAO4BNAxsz+wnxDGSeH8i0zg0F4n7oLlyEst28DkdIOCdawZC3
	s/OKSe4m7zeWe79kN4HY+uuoDfBp7nF9IW3ey92c9tsMPn7Ed0gRJKLZ5jcj37X0Fl54s5
	YzuZDDLLPGkiyXlhGmEHkpo6fM2RVBA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OdJdFHejFzivH0K4HrpPqfVJQpqXhlK9JXl5+TwJA8I=;
	b=WqkjqE2OVRBoJUTxocQcHQz7iTNlNfPzN8eKSAEiEs+0YiiXuBwyvfGYMq9Oi1ARzrg3RA
	563QgQzv+EcamzQ9cliZ2C5MjcmNlLiKUH0qLqo3kPlB8PKUVCegQNVH5c2uflkrlzqP42
	eOThMCBKPd62oXHuu2pZ+/j/+d5apF4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 4/9] shared/uinput: add uinput utility functions
Date: Fri, 12 Dec 2025 22:45:49 +0200
Message-ID: <cc47d799a85bf48e834fb360680e53c6199bbfcf.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
References: <cover.1765572338.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uinput utility function that can be used both for AVCTP and MCS.
---
 Makefile.am         |   3 +-
 src/shared/uinput.c | 204 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/uinput.h |  32 +++++++
 3 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/uinput.c
 create mode 100644 src/shared/uinput.h

diff --git a/Makefile.am b/Makefile.am
index 795d0d403..3adfa6cd5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -247,7 +247,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/lc3.h src/shared/tty.h \
 			src/shared/bap-defs.h \
 			src/shared/asha.h src/shared/asha.c \
-			src/shared/battery.h src/shared/battery.c
+			src/shared/battery.h src/shared/battery.c \
+			src/shared/uinput.h src/shared/uinput.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/shared/uinput.c b/src/shared/uinput.c
new file mode 100644
index 000000000..f1f2b4ec1
--- /dev/null
+++ b/src/shared/uinput.c
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen
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
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <linux/uinput.h>
+
+#include "bluetooth/bluetooth.h"
+
+#include "src/shared/util.h"
+#include "src/shared/uinput.h"
+
+
+#define DBG(uinput, fmt, arg...) \
+	uinput_debug(uinput->debug_func, uinput->debug_data, "%s:%s() " fmt, \
+						__FILE__, __func__, ## arg)
+
+struct bt_uinput {
+	struct input_id dev_id;
+	char name[UINPUT_MAX_NAME_SIZE];
+	bdaddr_t addr;
+	int fd;
+
+	bt_uinput_debug_func_t debug_func;
+	void *debug_data;
+};
+
+static void uinput_debug(bt_uinput_debug_func_t debug_func, void *debug_data,
+							const char *format, ...)
+{
+	va_list ap;
+
+	if (!debug_func || !format)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(debug_func, debug_data, format, ap);
+	va_end(ap);
+}
+
+static int uinput_emit(struct bt_uinput *uinput, uint16_t type, uint16_t code,
+								int32_t val)
+{
+	struct input_event ie;
+
+	memset(&ie, 0, sizeof(ie));
+
+	ie.type = type;
+	ie.code = code;
+	ie.value = val;
+
+	return write(uinput->fd, &ie, sizeof(ie));
+}
+
+void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pressed)
+{
+	if (!uinput)
+		return;
+
+	DBG(uinput, "%d", key);
+
+	uinput_emit(uinput, EV_KEY, key, pressed ? 1 : 0);
+	uinput_emit(uinput, EV_SYN, SYN_REPORT, 0);
+}
+
+struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
+				const bdaddr_t *addr,
+				const struct input_id *dev_id)
+{
+	struct bt_uinput *uinput;
+	const size_t name_max = sizeof(uinput->name);
+
+	uinput = new0(struct bt_uinput, 1);
+	uinput->fd = -1;
+
+	if (name)
+		snprintf(uinput->name, name_max, "%s", name);
+
+	if (suffix) {
+		size_t name_len = strlen(uinput->name);
+		size_t suffix_len = strlen(suffix);
+		size_t pos = name_len;
+
+		if (suffix_len > name_max - 1)
+			suffix_len = name_max - 1;
+		if (pos + suffix_len > name_max - 1)
+			pos = name_max - 1 - suffix_len;
+
+		snprintf(uinput->name + pos, name_max - pos, "%s", suffix);
+	}
+
+	if (addr)
+		bacpy(&uinput->addr, addr);
+
+	if (dev_id) {
+		uinput->dev_id.bustype = dev_id->bustype;
+		uinput->dev_id.product = dev_id->product;
+		uinput->dev_id.vendor = dev_id->vendor;
+		uinput->dev_id.version = dev_id->version;
+	} else {
+		uinput->dev_id.bustype = BUS_BLUETOOTH;
+	}
+
+	return uinput;
+}
+
+void bt_uinput_set_debug(struct bt_uinput *uinput,
+					bt_uinput_debug_func_t debug_func,
+					void *user_data)
+{
+	if (!uinput)
+		return;
+
+	uinput->debug_func = debug_func;
+	uinput->debug_data = user_data;
+}
+
+int bt_uinput_create(struct bt_uinput *uinput,
+					const struct bt_uinput_key_map *key_map)
+{
+	int fd = -1;
+	struct uinput_user_dev dev;
+	size_t i;
+	int err;
+	char addr[18];
+
+	if (!uinput || uinput->fd >= 0)
+		return -EINVAL;
+
+	fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
+	if (fd < 0)
+		fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
+	if (fd < 0)
+		fd = open("/dev/misc/uinput", O_WRONLY | O_NONBLOCK);
+	if (fd < 0) {
+		err = -errno;
+		DBG(uinput, "Failed to open /dev/uinput: %s", strerror(-err));
+		goto fail;
+	}
+
+	ioctl(fd, UI_SET_EVBIT, EV_KEY);
+	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+	for (i = 0; key_map[i].name; ++i)
+		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+
+	ba2strlc(&uinput->addr, addr);
+	ioctl(fd, UI_SET_PHYS, addr);
+
+	memset(&dev, 0, sizeof(dev));
+	dev.id = uinput->dev_id;
+	snprintf(dev.name, sizeof(dev.name), "%s", uinput->name);
+
+	if (write(fd, &dev, sizeof(dev)) < 0) {
+		err = -errno;
+		DBG(uinput, "Failed to write setup: %s", strerror(-err));
+		goto fail;
+	}
+
+	if (ioctl(fd, UI_DEV_CREATE) < 0) {
+		err = -errno;
+		DBG(uinput, "Failed to create device: %s", strerror(-err));
+		goto fail;
+	}
+
+	DBG(uinput, "%p", uinput);
+
+	uinput->fd = fd;
+	return 0;
+
+fail:
+	if (fd >= 0)
+		close(fd);
+	return err;
+}
+
+void bt_uinput_destroy(struct bt_uinput *uinput)
+{
+	if (!uinput)
+		return;
+
+	DBG(uinput, "%p", uinput);
+
+	if (uinput->fd >= 0) {
+		ioctl(uinput->fd, UI_DEV_DESTROY);
+		close(uinput->fd);
+	}
+
+	free(uinput);
+}
diff --git a/src/shared/uinput.h b/src/shared/uinput.h
new file mode 100644
index 000000000..a15e4b3b4
--- /dev/null
+++ b/src/shared/uinput.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen
+ */
+
+struct bt_uinput;
+
+struct bt_uinput_key_map {
+	const char *name;
+	unsigned int code;
+	uint16_t uinput;
+};
+
+typedef void (*bt_uinput_debug_func_t)(const char *str, void *user_data);
+
+struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
+				const bdaddr_t *addr,
+				const struct input_id *dev_id);
+
+void bt_uinput_set_debug(struct bt_uinput *uinput,
+					bt_uinput_debug_func_t debug_func,
+					void *user_data);
+
+int bt_uinput_create(struct bt_uinput *uinput,
+				const struct bt_uinput_key_map *key_map);
+
+void bt_uinput_destroy(struct bt_uinput *uinput);
+
+void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pressed);
-- 
2.51.1

