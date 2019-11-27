Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C42E20835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhOv7Ymd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0TJm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:09:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46343 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfK0TJl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 14:09:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so11488412pfc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4noIvRCD2FEI4oOV8oD9ElmwwWAK7BcYQq0j5Yxf2NI=;
        b=dhOv7YmdnCbC5flqU9ZMv+DD+TOnnoWE8/5l8bwDIqFeVnlqPY4j3Lazz47pW06t+/
         YNjLMLnQ1HevCUyAeVGGj6zhxpB08Ilu2vwotZbjHAJKDUwQggZHl0XlRTK1N2HB7Dbq
         FPcF10dG4ntU1FCGDgTPqJffcZxuiFi4L9hM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4noIvRCD2FEI4oOV8oD9ElmwwWAK7BcYQq0j5Yxf2NI=;
        b=O8voMNGo9Tfl994RHQWlY+++juKaup+D1EqfU77svjdwlOmNkv6G0u1TxOV3JEh+So
         yJjrWGVcbXEkyfJEKqPwDAmq3c0OCL0xBrwGCcBax+SzNoO8JxDBBeVjj3mqX0pvzkSr
         eRfc6nFuX758q6vW2Fi0mxz7OHQN9oKry4C/U93VzEwge3JxI2V8expBm251oJ1xmVUE
         JGnZHky7QVid05H+CQJW7V08T/mlQamrKzvFs5cfi1T/z2zLfrR/X7Fyq7mqqak9tA4j
         xGZd2VFAOHqB8qkVSJXIMRAvvw9wRobS9gEPuQXMZtQ5lbZStg0nLnHtjLyUY4nnuyPX
         lyAQ==
X-Gm-Message-State: APjAAAXz+VAISktA9z9/o32IyN0CbV20R5n+as3ZD40rXjkGKGlJK/Si
        7ww5d9bUhnHGL3GVHqsB/qweaA==
X-Google-Smtp-Source: APXvYqxAB69W4YG2E7s0vvqWpaUgjgc2KBk2jbvvLnmZXZrKZLMEFlXo6dZ8rnwHS14WyGf1Q+TmTg==
X-Received: by 2002:aa7:8d93:: with SMTP id i19mr1798367pfr.205.1574881781027;
        Wed, 27 Nov 2019 11:09:41 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id u24sm17280519pfh.48.2019.11.27.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:09:40 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH 1/2] input: Update virtual input devices with correct info
Date:   Wed, 27 Nov 2019 11:09:14 -0800
Message-Id: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update uhid and uinput devices with lowercase addresses (to match how
kernel prints it via %pMR). Also update uinput to include the phys
attribute and correctly set the vendor/product/version during init.

---
I was just checking through udev to see if I could correlate virtual
devices created by bluez (via uhid and uinput) to the hci interface that
owns it. While doing that, I found that the printed addresses were upper
case but other addresses in udev were lower case. (i.e. udevinfo -a -p
/sys/class/net/eth0). To keep things consistent and comparable, I opted
to convert these addresses to lower case.

I was able to compare the `phys` attribute with the value in
/sys/kernel/debug/hci0/identity to figure out which virtual devices were
created for bluetooth.

For systems that don't mount debugfs, would it be a good idea to expose
the identity in sysfs?  i.e. /sys/class/bluetooth/hci0/identity?

Thanks
Abhishek


 lib/bluetooth.c          |  7 +++++++
 lib/bluetooth.h          |  1 +
 profiles/audio/avctp.c   | 21 ++++++++++++++-------
 profiles/input/device.c  |  4 ++--
 profiles/input/hog-lib.c | 10 ++++++++++
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index effc7f49d..7cba509d8 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -81,6 +81,13 @@ int ba2str(const bdaddr_t *ba, char *str)
 		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 }
 
+/* Match kernel's lowercase printing of mac address (%pMR) */
+int ba2strlc(const bdaddr_t *ba, char *str)
+{
+	return sprintf(str, "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
+}
+
 int str2ba(const char *str, bdaddr_t *ba)
 {
 	int i;
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index eb279260e..756dce164 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -325,6 +325,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
 bdaddr_t *strtoba(const char *str);
 char *batostr(const bdaddr_t *ba);
 int ba2str(const bdaddr_t *ba, char *str);
+int ba2strlc(const bdaddr_t *ba, char *str);
 int str2ba(const char *str, bdaddr_t *ba);
 int ba2oui(const bdaddr_t *ba, char *oui);
 int bachk(const char *str);
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 70a3e40b2..42136f94b 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1161,7 +1161,8 @@ failed:
 	return FALSE;
 }
 
-static int uinput_create(char *name)
+static int uinput_create(struct btd_device *device, const char *name,
+			 const char *phys)
 {
 	struct uinput_dev dev;
 	int fd, err, i;
@@ -1185,9 +1186,9 @@ static int uinput_create(char *name)
 		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
 
 	dev.id.bustype = BUS_BLUETOOTH;
-	dev.id.vendor  = 0x0000;
-	dev.id.product = 0x0000;
-	dev.id.version = 0x0000;
+	dev.id.vendor  = btd_device_get_vendor(device);
+	dev.id.product = btd_device_get_product(device);
+	dev.id.version = btd_device_get_version(device);
 
 	if (write(fd, &dev, sizeof(dev)) < 0) {
 		err = -errno;
@@ -1202,6 +1203,9 @@ static int uinput_create(char *name)
 	ioctl(fd, UI_SET_EVBIT, EV_REP);
 	ioctl(fd, UI_SET_EVBIT, EV_SYN);
 
+	/* Also set the phys */
+	ioctl(fd, UI_SET_PHYS, phys);
+
 	for (i = 0; key_map[i].name != NULL; i++)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
 
@@ -1220,7 +1224,7 @@ static int uinput_create(char *name)
 
 static void init_uinput(struct avctp *session)
 {
-	char address[18], name[248 + 1];
+	char address[18], phys[18], name[248 + 1];
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -1230,8 +1234,11 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	ba2str(device_get_address(session->device), address);
-	session->uinput = uinput_create(address);
+	ba2strlc(device_get_address(session->device), address);
+	ba2strlc(btd_adapter_get_address(device_get_adapter(session->device)),
+		 phys);
+
+	session->uinput = uinput_create(session->device, address, phys);
 	if (session->uinput < 0)
 		error("AVRCP: failed to init uinput for %s", address);
 	else
diff --git a/profiles/input/device.c b/profiles/input/device.c
index a711ef527..2cb3811c8 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -855,8 +855,8 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
 	strncpy((char *) ev.u.create.name, req->name, sizeof(ev.u.create.name));
-	ba2str(&idev->src, (char *) ev.u.create.phys);
-	ba2str(&idev->dst, (char *) ev.u.create.uniq);
+	ba2strlc(&idev->src, (char *) ev.u.create.phys);
+	ba2strlc(&idev->dst, (char *) ev.u.create.uniq);
 	ev.u.create.vendor = req->vendor;
 	ev.u.create.product = req->product;
 	ev.u.create.version = req->version;
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index d9ed80689..9c5c814a7 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -32,6 +32,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
+#include <ctype.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -992,6 +993,15 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			BT_IO_OPT_SOURCE, ev.u.create.phys,
 			BT_IO_OPT_DEST, ev.u.create.uniq,
 			BT_IO_OPT_INVALID);
+
+	/* Phys + uniq are the same size (hw address type) */
+	for (i = 0;
+	    i < (int)sizeof(ev.u.create.phys) && ev.u.create.phys[i] != 0;
+	    ++i) {
+		ev.u.create.phys[i] = tolower(ev.u.create.phys[i]);
+		ev.u.create.uniq[i] = tolower(ev.u.create.uniq[i]);
+	}
+
 	if (gerr) {
 		error("Failed to connection details: %s", gerr->message);
 		g_error_free(gerr);
-- 
2.24.0.432.g9d3f5f5b63-goog

