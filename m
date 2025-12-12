Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FB2D9786
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570368; cv=pass; b=QQ72Q/6rcnpHTlHRBre+Hwj5rTJOkIXfp7I7T4/NQsfTtDlKTN81iqhC0ElxAuC8czbD/64pnBdcSzzmqMlpFjiayvwwwi9PiaJtxw60DMfxEmX86JyBK39dtfywDlDXGljGbJgABxBhGGA03UPfnPzcUriSzcWklM1Q+akoJ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570368; c=relaxed/simple;
	bh=XxWVH2hQsTlByrXC1nUNJtvR5Y59pnlETwdNBuVEcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/6VH3+fv3f9ThYBVsjvIqzqbrCV97CTaGfPDssaVfGrTb7aJcZ41swfMzTT/ZaXBmv8Ear8BLZXVXSqIUn3x83f7r1vB9fFxiaqdMyQ4p1m4QlskTTjuTu5cL9fEH3yM72xMgdc+KhoS/v/aMt1n54n45KKJpyaEfetNdG5UYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=w9jpt13U; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="w9jpt13U"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSgc84pXDz107f;
	Fri, 12 Dec 2025 22:12:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765570361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4oesjIVWt2H0Z57T9oQXDFXpJd6hYy6QZwIzp7TBy4=;
	b=w9jpt13UGRDr4unomADkbbTBMmIJI8iDZaMAOOsPJIyvgV26pJsx7MzT6UFHCe5MAmSAmk
	ukfRzfxMKJ7mkSaY5bmWGiSt7G49CdQtt4VsJI33SUbI6xMsdMl9tfi0e6ZVz9G3jueYui
	cOXZR3XzfRnvOF9EvAsY9mg9mt/HrzM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765570361;
	b=xD86+T6CMeEOiXR+rLSmqyVkgOgLZZQVMuImqVDplsVQdvbJZatxhR80fdRPCJ6CQnvj2k
	kAPtHTuHd9X+6nkAIokzjy0e6lBvXZpoXdJOH52f4BjwzLYlw1nRAEyTN+UMqKKgz2Ft7B
	pU0bgJ0RIxJ0jKztvygzjS4dPXBZy0U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765570361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4oesjIVWt2H0Z57T9oQXDFXpJd6hYy6QZwIzp7TBy4=;
	b=FcK5t+9+Axv8VFYalDLzWa2DywbKAn+SR46sZfXJQCOy6sjgXCy0vF/M8WUNy/jCDKNvOC
	DDThCYNPLWcdwrJuUCqeGtNtp3GESpc0TeQysDjMe2zTdCparf+erDPWgmV2PVOVMlFA4y
	B6rx6mK9fOCeviQ39lXxP5fpujl5ZCI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 4/9] shared/uinput: add uinput utility functions
Date: Fri, 12 Dec 2025 22:12:26 +0200
Message-ID: <bfdabc3f228c68b2855e335de32c3eb083916c63.1765570334.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765570334.git.pav@iki.fi>
References: <cover.1765570334.git.pav@iki.fi>
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
index 000000000..4856f93cf
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
+static void uinput_emit(struct bt_uinput *uinput, uint16_t type, uint16_t code,
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
+	write(uinput->fd, &ie, sizeof(ie));
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

