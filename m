Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EB288C3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480146; cv=pass; b=ibidUYJrGD+l9VAjae8VWUjXcL6/WxSMPgRYcAlcErfCdOSK9oKxS3XJZ8qqxzq+LpBWg04j5gu6iftfBMOqZ9bHJWsWUimy/jizxSpCrw8yEL/GznHDLoTIjQovPfXxTxBYXaJkr4J4++or65MINNxKa9EtlX8xPrKtpmPCn6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480146; c=relaxed/simple;
	bh=CyOGtq0w6Zo0WwFJ/ibDS7eS+zM5bhXUfS0VinddG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uArAQWps9YjIhMIWsirIFnilckI9z7yX68e0rWpjymzPB3+fgQ3lzQh3LrhrW0tRqh1wI+5bv8Q4j3I5jh5TVQI1h5bEkLXj4knm81Ce+GdEXTEWP4yBe4Zfls4Q+5XQw9C+TG/9fiKKfb4TAZ8K83Ptx0HYo2wYTyf+ez0E3ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Fhpiw/1d; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Fhpiw/1d"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS2F35YLYzyd7;
	Thu, 11 Dec 2025 21:08:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765480136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X6bU25PCrcX1az+5sUVCe2goKArF1Wxnt796nU6xw0=;
	b=Fhpiw/1dBSCNJoXYbOLSiQwaTF2C/VfQJhNQxqVYWnWP9Eps90ubuob19PsMYN3D460UvK
	UD2zjZ3P87HLIw2jAIcb8LwJWcf2/1jn3e0cTrvJMk7ziWG74Tl7j87hoYG/r0/V3ee3Oj
	Je8uOVMZ+ioNphiE8fJcGrWez5YUdks=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765480136;
	b=JksP3AolIYURaayBwAM16F2yyWPZ2pVxCrRKmS33zl0yQAvb1zhmkpy5QVF1PJQK5B7Hhl
	6XuqssMhMRnbZaYHjoEWJutHgoc4jQP59QxXFlRePHVn1VN+lqtzZ7Fn6MExIvoirJ/d2s
	/deqAt4RGy4XuTSDIwpBol4sKPS7t94=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765480136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X6bU25PCrcX1az+5sUVCe2goKArF1Wxnt796nU6xw0=;
	b=o0yb+J7a9NHLRMI0COQ2E3TbKUU35matFbe8dhZu/eSqRoH7fvr06i8hG6u3nMJqUNBO6+
	yy4FWqy1HHeVpV/ETux76AqJPKs3Vp46XiyJrWQSZvvf7sBplDc15BWTx7DRLu4stE9hUe
	fFPZVB1qkPsbM4dsoozTcNdpeWon6Mo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 4/7] shared/uinput-util: extract uinput utility function from AVCTP
Date: Thu, 11 Dec 2025 21:08:44 +0200
Message-ID: <8afdc593e1d0153a0007d28a57e227e490b9b2ae.1765480081.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765480081.git.pav@iki.fi>
References: <cover.1765480081.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract uinput utility function from AVCTP to src/shared so that it can
be reused for MCS.
---
 Makefile.am              |   4 +-
 src/shared/uinput-util.c | 195 +++++++++++++++++++++++++++++++++++++++
 src/shared/uinput-util.h |  31 +++++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/uinput-util.c
 create mode 100644 src/shared/uinput-util.h

diff --git a/Makefile.am b/Makefile.am
index ba0262d5f..4c7177886 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -247,7 +247,9 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/lc3.h src/shared/tty.h \
 			src/shared/bap-defs.h \
 			src/shared/asha.h src/shared/asha.c \
-			src/shared/battery.h src/shared/battery.c
+			src/shared/battery.h src/shared/battery.c \
+			src/shared/uinput-util.h \
+			src/shared/uinput-util.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/shared/uinput-util.c b/src/shared/uinput-util.c
new file mode 100644
index 000000000..6edcab3df
--- /dev/null
+++ b/src/shared/uinput-util.c
@@ -0,0 +1,195 @@
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
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <linux/uinput.h>
+
+#include "bluetooth/bluetooth.h"
+
+#include "src/shared/util.h"
+#include "src/shared/uinput-util.h"
+
+
+#define DBG(uinput, fmt, arg...) \
+	uinput_debug(uinput->debug_func, uinput->debug_data, "%s:%s() " fmt, \
+						__FILE__, __func__, ## arg)
+
+struct bt_uinput {
+	int fd;
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
+void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pressed)
+{
+	if (!uinput)
+		return;
+
+	DBG(uinput, "%d", key);
+
+	send_event(uinput->fd, EV_KEY, key, pressed ? 1 : 0);
+	send_event(uinput->fd, EV_SYN, SYN_REPORT, 0);
+}
+
+struct bt_uinput *bt_uinput_new(const char *name, const char *suffix,
+					const bdaddr_t *addr,
+					const struct input_id *dev_id,
+					const struct bt_uinput_key_map *key_map,
+					bt_uinput_debug_func_t debug,
+					void *user_data)
+{
+	struct bt_uinput *uinput;
+	struct uinput_user_dev dev;
+	int fd, err, i;
+	char src[18];
+
+	uinput = new0(struct bt_uinput, 1);
+	uinput->debug_func = debug;
+	uinput->debug_data = user_data;
+
+	fd = open("/dev/uinput", O_RDWR);
+	if (fd < 0) {
+		fd = open("/dev/input/uinput", O_RDWR);
+		if (fd < 0) {
+			fd = open("/dev/misc/uinput", O_RDWR);
+			if (fd < 0) {
+				err = errno;
+				DBG(uinput, "Can't open input device: %s (%d)",
+							strerror(err), err);
+				free(uinput);
+				errno = err;
+				return NULL;
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
+			if (slen >= UINPUT_MAX_NAME_SIZE)
+				slen = UINPUT_MAX_NAME_SIZE - 1;
+			len = UINPUT_MAX_NAME_SIZE - slen - 1;
+			strncpy(dev.name + len, suffix, slen);
+			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
+		}
+	}
+
+	if (dev_id) {
+		dev.id.bustype = dev_id->bustype;
+		dev.id.vendor = dev_id->vendor;
+		dev.id.product = dev_id->product;
+		dev.id.version = dev_id->version;
+	} else {
+		dev.id.bustype = BUS_VIRTUAL;
+	}
+
+	if (write(fd, &dev, sizeof(dev)) < 0) {
+		err = errno;
+		DBG(uinput, "Can't write device information: %s (%d)",
+							strerror(err), err);
+		close(fd);
+		free(uinput);
+		errno = err;
+		return NULL;
+	}
+
+	ioctl(fd, UI_SET_EVBIT, EV_KEY);
+	ioctl(fd, UI_SET_EVBIT, EV_REL);
+	ioctl(fd, UI_SET_EVBIT, EV_REP);
+	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+
+	ba2strlc(addr, src);
+	ioctl(fd, UI_SET_PHYS, src);
+
+	for (i = 0; key_map[i].name != NULL; i++)
+		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+
+	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
+		err = errno;
+		DBG(uinput, "Can't create uinput device: %s (%d)",
+							strerror(err), err);
+		close(fd);
+		free(uinput);
+		errno = err;
+		return NULL;
+	}
+
+	send_event(fd, EV_REP, REP_DELAY, 300);
+
+	DBG(uinput, "%p", uinput);
+
+	uinput->fd = fd;
+	return uinput;
+}
+
+void bt_uinput_destroy(struct bt_uinput *uinput)
+{
+	if (!uinput)
+		return;
+
+	DBG(uinput, "%p", uinput);
+
+	ioctl(uinput->fd, UI_DEV_DESTROY);
+	close(uinput->fd);
+	free(uinput);
+}
diff --git a/src/shared/uinput-util.h b/src/shared/uinput-util.h
new file mode 100644
index 000000000..fb8f7e6bd
--- /dev/null
+++ b/src/shared/uinput-util.h
@@ -0,0 +1,31 @@
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
+					const bdaddr_t *addr,
+					const struct input_id *dev_id,
+					const struct bt_uinput_key_map *key_map,
+					bt_uinput_debug_func_t debug,
+					void *user_data);
+void bt_uinput_destroy(struct bt_uinput *uinput);
+
+void bt_uinput_send_key(struct bt_uinput *uinput, uint16_t key, bool pressed);
-- 
2.51.1

