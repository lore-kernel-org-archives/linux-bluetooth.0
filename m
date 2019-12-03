Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF146C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E4520715
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnNK7o74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCBE4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:04:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45414 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCBE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 20:04:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so870822plz.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 17:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/oMNU6siKDybyjeOxuWIm9qctc/2UmS02+ZIqujbBo=;
        b=VnNK7o74GkBUzAjiWJ15U0TP+rQan0j7r6artM6Ov5zaj4QiFLe2QWg8Ihbyayb4ZX
         tJHVSwSR2mjbhz9gSPbkRkvq/HjBjvrk+2waWxa8bc8E8F2rjlXyU6wNr0jNra/8sfBw
         Z2YTO9vj/clJx4QZvCOQWTh2mNQhcGjxlZMno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/oMNU6siKDybyjeOxuWIm9qctc/2UmS02+ZIqujbBo=;
        b=MLoTJq6YRgWDQpmRu9woJvX7phYEB2wtt1NZfj27xACgTo2hijdRja6ASLqXIcqpaM
         01eZsypZG2aR6j3xYf6/KAD8ISe1xDQiStrNrkiB66vsZXZQYVz/VwtlXFqpRdcedfcH
         L+p/BjUOIYQqpP/APerWw30aHXZBbUW2hXqoID54NAsQsZcoUeRGULrq6PV/V6GzXvNt
         dcio7lQaZI02/ugoUuxiCKyVVn+RHGfjEd3CQ2ILbLKOzaMEPKxg1jgqlhaeNWIbhSkw
         h118FvwRnLiDer80l5ezGo933TBuRpcx3VMPbUHaRGCZakCqT/3La17acTGTIIKn96dn
         +Cbw==
X-Gm-Message-State: APjAAAVB0to7FQYZ8AwRU9BZIeMqqqxiKWND1TwM/7GsEME4eT/LR40y
        XlQ9baKFodckVaYChDtV/8717g==
X-Google-Smtp-Source: APXvYqxEfpP/TzGOgY1lSHUq6k5LUl1A7bqTioFp/rdb3wVFz3+FZDO81O86IL/1uGTF3llbJu2jIQ==
X-Received: by 2002:a17:90a:a383:: with SMTP id x3mr2433625pjp.82.1575335095251;
        Mon, 02 Dec 2019 17:04:55 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 143sm741808pfz.67.2019.12.02.17.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:04:53 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 2/4] input: Update virtual input devices with correct info
Date:   Mon,  2 Dec 2019 17:03:58 -0800
Message-Id: <20191203010400.216538-2-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191203010400.216538-1-abhishekpandit@chromium.org>
References: <20191203010400.216538-1-abhishekpandit@chromium.org>
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

Changes in v2:
- Split into two commits

 profiles/audio/avctp.c   | 21 ++++++++++++++-------
 profiles/input/device.c  |  4 ++--
 profiles/input/hog-lib.c | 10 ++++++++++
 3 files changed, 26 insertions(+), 9 deletions(-)

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
2.24.0.393.g34dc348eaf-goog

