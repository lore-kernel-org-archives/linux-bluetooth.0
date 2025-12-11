Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B841EDA3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484172; cv=pass; b=I+gad5KNCsw0qr/boU7m3K9MEq+VE05ClEle9jWOLJme67y20HjfVI8DY1gEcs7oJaxiFYXfG3cLeGxT2TcZJtUw2SjjwC/gr2g3oKjAw6YZBMXfQfWcl7cZmADJ5MDX24POHRpZfmcMk3erjTddb0PEFdcr3sYkh2C7FyXB1qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484172; c=relaxed/simple;
	bh=IiqS9ivKf4vHulVletF6MRswBtUnccEaiW/kB0n7DU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ax2kWqBz/0DLhUEX/SUCS4491GjthcOIJtADP0xFMVcw05XawAqID4VSbZBEw/Uk+aVQHRe+Jveyj7A5Hlmzhbmk5ZPLvaM4aKX305YshWLfdLsQTWG3N9/0XxCEOKpKC5ZV37kSyPz/fNnZI9hFG7wF0ApGpBfmwmByHcuR9gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HWw1EfXs; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HWw1EfXs"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS3kb4QfFzyd7;
	Thu, 11 Dec 2025 22:16:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765484168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CammmK1kTvYnu9C9IS0QmuIBkPPbdvSWXg9K55emZMk=;
	b=HWw1EfXsgOwaLmNNT19NUEaQJUocRhUohwP5LusM/ezeTo+qxL0mcr7YexiJpbHhHfgI0B
	9h1NA7sGsMgF/lFKtCk4YfqHHRBijvmtSVM+zls57Mw0BAdsJsCfg1YNKcrH58im6tYRom
	CHcSo0sHtVQtDcJ1voyYDDEoW4Tiwzg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765484168;
	b=eaIAGW/UkaEu+6RR4ufO6tDmGfJyHo76hdMmRgDxAas9RqtMf2CTPjyzyZIHmvIxLTM0Bk
	TBDDuzFoKpjLAWbOBtHO6+RUc5FxJ79GCVm2UcAvspfxXOk4LlesQlBjaG5oCu32LpqJzs
	zANpHK/kBIf6zJo7EtdaoXWr6zcj6OQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765484168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CammmK1kTvYnu9C9IS0QmuIBkPPbdvSWXg9K55emZMk=;
	b=jvs2F5weGWIthvEyNbAITr+dzPfp4sbGjzqkUbexG6aYsreX3cD7ijPIoV9FXDRGrzdbrI
	N+s8FJPoXO7j3p01ELgjzmQS2QgcDPnzZcErVHbmhvppdmeO8Xdm9Rh0VO160d2Du8rQ0q
	5igN1Vpio2RiJoPMhXVVdK94CQ0O2ec=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 4/7] shared/uinput-util: extract uinput utility function from AVCTP
Date: Thu, 11 Dec 2025 22:15:56 +0200
Message-ID: <e8fd07e902ad1fbc00113ef57eb89b8970d29a84.1765484150.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765484150.git.pav@iki.fi>
References: <cover.1765484150.git.pav@iki.fi>
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
 src/shared/uinput-util.c | 191 +++++++++++++++++++++++++++++++++++++++
 src/shared/uinput-util.h |  31 +++++++
 3 files changed, 225 insertions(+), 1 deletion(-)
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
index 000000000..4e9644661
--- /dev/null
+++ b/src/shared/uinput-util.c
@@ -0,0 +1,191 @@
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
+	if (name)
+		snprintf(dev.name, UINPUT_MAX_NAME_SIZE, "%s", name);
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
+		if (slen >= UINPUT_MAX_NAME_SIZE)
+			slen = UINPUT_MAX_NAME_SIZE - 1;
+		if (len > UINPUT_MAX_NAME_SIZE - slen - 1)
+			len = UINPUT_MAX_NAME_SIZE - slen - 1;
+
+		snprintf(dev.name + len, UINPUT_MAX_NAME_SIZE - len,
+								"%s", suffix);
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

