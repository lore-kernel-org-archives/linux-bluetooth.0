Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DB261B8A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014051; cv=none; b=s79GYmoNyXoRRhoDEqX8/g33s8tfYqgl3C6oeV3KSIB2n+k/1WfvFarm/UEd61deEspdTTcLWFHQgS8QbO7ctkZU9rkbvBuvCwofvpIz0eikhsckim9kBBi5CDPAtFCWV7/0hoBmyeFxHDV26zZtcwqlYGndbaBEP7XDUP+eAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014051; c=relaxed/simple;
	bh=uwNJ3pP01YBiRdaoIvp86oNGpi3uflH2O8FYroJlhsg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bIt6Y7BNnweY03OYjwJWyQW9EVdzy8cJnTKoT4aHMpEK2vMyy708Ix6sq5ppukeiN//DTuL+L7ue5fP8hYrAds1jo235sf+0S4j0j3PMK3m63NzTYyVvJHAz9wqyWbP90z2xdX56xwNhK6LTKXpT0dG4BNiP7ITTOcf59RVLniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMNBQBqh; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMNBQBqh"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95d04f205beso1946423241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778014048; x=1778618848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXa4lztr4WgV2fOjC6do+0SWrKZy96ZROolAYXDfxeg=;
        b=RMNBQBqh+c3+0HOaoeCMnUi50EjawgIxeGY8G8EWr/gc21eiz9JnZ+cczhpuOqbSsq
         dAvoafGw7/Eur3aSUKSW8VoghTwp3Qaui2pBms4yb4TOThdu3iUAg+jsOBXYfxR2NpkN
         uQYXpGBGZE6D4o1E2bgvi3rlQn/UbHdtner7CshDW1KynGeRxq2biAAfEYkXV3o3LF/q
         gBnbSXi3oCUkRuwibuxLU+ETYLvkKYOzD9sI6f3Jqc0ZSH/6wEDfDOJhOixI0LitQU/E
         v5jEyC5Tzyq3SN8ftpmOpdBZtaOQwszrI/4I0GFAXmL0alGACXCcKxDO7odxs07UfQIp
         ec9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014048; x=1778618848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXa4lztr4WgV2fOjC6do+0SWrKZy96ZROolAYXDfxeg=;
        b=oDJD6FqE+eErfN2++T9O2yzqavnKK5kyudbTNx7Sa2CVZd8+X5sqRXpJr/YZJ3kWZS
         HL4k7hedsXVLYgICQsAXztq64O5eBy2PuHHmezAH6Nyx88u104wzo/owAa0DzdkVQpTl
         FfE/w3SQjHs2wRfU89/RNy9O1flRkBTD+jfaYgmiV9QSyHyNU4sCDsRVrgNCi0KO//Fl
         gPbm8odrSw/O/XS+9L1mA5nQuBlKyQxMi+ZYlcLyafQezqo9eNvWyE1nNsKeIh+kLIFv
         BewqGas7LU+3ZZIkE9G9u9dccMGajEGvhvjJdYRCKv9cZaJknHOXDoSG/wYk3T0eyPyA
         732A==
X-Gm-Message-State: AOJu0YzAJSO3B38Xr6NxS9278QXlrEWXCAxebXbORDwD8taWIC46Au2W
	L/a4XPDIdbhCdbV00ne5J23xUEU21kblbnvFoHkKlpwK6ZgX1dE/tvkgPyXw6Gru
X-Gm-Gg: AeBDiesNo6ihboZHGKkD0pgxaIonYGUNuhw59KBdwmEnA7+50VFyfzh0DrU/L0aH5Ds
	xORf4f+2Nc4YbKuQy9EOxKV492q3ZHYReC4HDdy17ArH3toBPHS65+UQYckk2s69a4WihJ7+vAb
	cAHNiUHVPqeAw6+bn+kv0ocOzvCdzhGKyIkf/JSjIQ97M+RAPCsjD13IJilX95ntITuiC4PqPnI
	7JZ3HQJqpwDaAIvGMXP0PQgCM4/80CoZslmTyjkQCEyjZNxUnLOtGYDo+Y+6UbHmWUz7tBrvFwo
	I7yLfWalLDHU+PvTfudsJ/A9whKR3RimlZyDdq5VkgmRWrgno+nj8S2rXgmxJoLsThmTGpZbEcO
	TwhcXXfZH4WRT7pjchPHDQBUOq2rumFmj2SkBns691ahUBWIq3ysj//mbN+0ljfV4xeXLa8faf7
	PUb/aUslBkpFAXHWJTrQYH6jNsM67xe+9CLpd9sH8HqIUaOqWRnT0xoMx3fuLhS9gP8i5fChZEo
	I1eAhmbkNu7kS4r/oYjJhCKhD4x
X-Received: by 2002:a05:6102:4b10:b0:607:a151:d63 with SMTP id ada2fe7eead31-630f8eb1962mr182944137.7.1778014048518;
        Tue, 05 May 2026 13:47:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14f1aasm8006629137.2.2026.05.05.13.47.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:47:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] emulator/vhci: Add debug messages to error paths
Date: Tue,  5 May 2026 16:47:16 -0400
Message-ID: <20260505204719.1348473-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add debug_callback, debug_destroy and debug_data fields to struct vhci
so vhci_set_debug stores the callback locally in addition to passing it
to btdev. Introduce a variadic vhci_debug() helper using util_debug_va
and add debug messages to the following error paths:

 - vhci_write_callback: failed io_send
 - vhci_read_callback: failed read
 - vhci_debugfs_write: failed open and failed write
---
 emulator/vhci.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 22ca15796872..05fcfd0b77cb 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -19,6 +19,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdarg.h>
 #include <sys/uio.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -29,6 +30,7 @@
 #include "bluetooth/hci.h"
 
 #include "src/shared/io.h"
+#include "src/shared/util.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 #include "vhci.h"
@@ -41,8 +43,23 @@ struct vhci {
 	uint16_t index;
 	struct io *io;
 	struct btdev *btdev;
+	vhci_debug_func_t debug_callback;
+	vhci_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
+static void vhci_debug(struct vhci *vhci, const char *format, ...)
+{
+	va_list ap;
+
+	if (!vhci || !format || !vhci->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(vhci->debug_callback, vhci->debug_data, format, ap);
+	va_end(ap);
+}
+
 static void vhci_destroy(void *user_data)
 {
 	struct vhci *vhci = user_data;
@@ -61,7 +78,7 @@ static void vhci_write_callback(const struct iovec *iov, int iovlen,
 
 	written = io_send(vhci->io, iov, iovlen);
 	if (written < 0)
-		return;
+		vhci_debug(vhci, "Failed to write: %s", strerror(-written));
 }
 
 static bool vhci_read_callback(struct io *io, void *user_data)
@@ -72,8 +89,10 @@ static bool vhci_read_callback(struct io *io, void *user_data)
 	ssize_t len;
 
 	len = read(fd, buf, sizeof(buf));
-	if (len < 1)
+	if (len < 1) {
+		vhci_debug(vhci, "Failed to read: %s", strerror(errno));
 		return false;
+	}
 
 	btdev_receive_h4(vhci->btdev, buf, len);
 
@@ -86,6 +105,13 @@ bool vhci_set_debug(struct vhci *vhci, vhci_debug_func_t callback,
 	if (!vhci)
 		return false;
 
+	if (vhci->debug_destroy)
+		vhci->debug_destroy(vhci->debug_data);
+
+	vhci->debug_callback = callback;
+	vhci->debug_destroy = destroy;
+	vhci->debug_data = user_data;
+
 	return btdev_set_debug(vhci->btdev, callback, user_data, destroy);
 }
 
@@ -205,14 +231,20 @@ static int vhci_debugfs_write(struct vhci *vhci, char *option, const void *data,
 	sprintf(path, DEBUGFS_PATH "/hci%d/%s", vhci->index, option);
 
 	fd = open(path, O_RDWR);
-	if (fd < 0)
+	if (fd < 0) {
+		vhci_debug(vhci, "Failed to open %s: %s", path,
+							strerror(errno));
 		return -errno;
+	}
 
 	n = write(fd, data, len);
 	if (n == len)
 		err = 0;
-	else
+	else {
 		err = -errno;
+		vhci_debug(vhci, "Failed to write %s: %s", option,
+							strerror(-err));
+	}
 
 	close(fd);
 
-- 
2.53.0

