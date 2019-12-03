Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF094C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97D20715
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVPab4z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLCBFa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:05:30 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43966 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCBF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 20:05:29 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so689701pjs.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W3QQ6Z6Oep9RxwjS+yMKxVf2Y00o07I5wmjJljt0FM=;
        b=BVPab4z4EtX93dUSbAgDCJ15cyE944obnBTBqy1fAcXLbmJGonu6zajEEq3XtKxDfw
         ctmEfOryEZU4ueU4KXPIGbAXk9wJo1cM/MwA2rTBBAZ6Xkz/soGTADR0cPj5JpZIKjLG
         KL0EVkyRlcPVp+fyi5cjBqT5U8lM36if5H7yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W3QQ6Z6Oep9RxwjS+yMKxVf2Y00o07I5wmjJljt0FM=;
        b=VyXbDqFSrusYIkDvyIwXLUVr3ppJbx4OiW+hWbiBiePdVDD/KjDp+itvh87JGQN1yn
         G9Ow3F7mfMKljbMu6OUHPCCrpUyee3d98jRDbOhIPO7wN7g7pbwPYmZeM/VKmG7/oYDL
         +MM4n31stAyqGpEfpjNUPXg9cDhoKmcJ9Ksd/ACArQUG53Q/Z+y8ZmIJvTpCp0U4Ac+4
         V+Cj4TYT7asq3sYSC5kCPMiwLjjuHTT6CH6TufXp43rtTmpXuY1SCK9U8rkCfRrWzJHP
         7Zli3PwfsBBExjehZJR8d9mIpETasY2Fb+rt6hdfx18mfX2bV8IILaJ34huDEYD4S860
         pfmA==
X-Gm-Message-State: APjAAAUrS5ADapTrVZeLHdpfVKkm0Ip5Q9DWiM/9F5WqD5BU8EUPeh8N
        IRkX2Gn9b3k28a9ZZAVwzW2SNQ==
X-Google-Smtp-Source: APXvYqwzHH+h5Gbw7fYp3Omxa/UNiujSH86gHh1gnBMI5ZyDppBgThdOhcuR8K6WgiDbRn2RzS4b+Q==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr2283555plo.150.1575335127811;
        Mon, 02 Dec 2019 17:05:27 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 143sm741808pfz.67.2019.12.02.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:05:10 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 3/4] input: Change uinput name and add AVRCP suffix
Date:   Mon,  2 Dec 2019 17:03:59 -0800
Message-Id: <20191203010400.216538-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191203010400.216538-1-abhishekpandit@chromium.org>
References: <20191203010400.216538-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When creating the uinput device, change the name to the peer device
name and add a "(AVRCP)" suffix.

The resulting uinput device will look like this:

$ udevadm info -a -p /sys/devices/virtual/input/input17
...
  looking at device '/devices/virtual/input/input17':
    KERNEL=="input17"
    SUBSYSTEM=="input"
    DRIVER==""
    ATTR{inhibited}=="0"
    ATTR{name}=="BeatsStudio Wireless (AVRCP)"
    ATTR{phys}=="00:00:00:6e:d0:74"
    ATTR{properties}=="0"
    ATTR{uniq}==""

---

Changes in v2:
- Added "(AVRCP)" suffix and moved src address into uinput_create

 profiles/audio/avctp.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 42136f94b..5116a5cde 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1162,10 +1162,11 @@ failed:
 }
 
 static int uinput_create(struct btd_device *device, const char *name,
-			 const char *phys)
+			 const char *suffix);
 {
 	struct uinput_dev dev;
 	int fd, err, i;
+	char src[18];
 
 	fd = open("/dev/uinput", O_RDWR);
 	if (fd < 0) {
@@ -1185,6 +1186,23 @@ static int uinput_create(struct btd_device *device, const char *name,
 	if (name)
 		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
 
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
+			strncpy(dev.name + len, suffix, slen);
+		} else {
+			len = UINPUT_MAX_NAME_SIZE - slen - 1;
+			strncpy(dev.name + len, suffix, slen);
+		}
+	}
+
 	dev.id.bustype = BUS_BLUETOOTH;
 	dev.id.vendor  = btd_device_get_vendor(device);
 	dev.id.product = btd_device_get_product(device);
@@ -1203,8 +1221,8 @@ static int uinput_create(struct btd_device *device, const char *name,
 	ioctl(fd, UI_SET_EVBIT, EV_REP);
 	ioctl(fd, UI_SET_EVBIT, EV_SYN);
 
-	/* Also set the phys */
-	ioctl(fd, UI_SET_PHYS, phys);
+	ba2strlc(btd_adapter_get_address(device_get_adapter(device)), src);
+	ioctl(fd, UI_SET_PHYS, src);
 
 	for (i = 0; key_map[i].name != NULL; i++)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
@@ -1224,7 +1242,7 @@ static int uinput_create(struct btd_device *device, const char *name,
 
 static void init_uinput(struct avctp *session)
 {
-	char address[18], phys[18], name[248 + 1];
+	char name[248 + 1];
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -1234,15 +1252,11 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	ba2strlc(device_get_address(session->device), address);
-	ba2strlc(btd_adapter_get_address(device_get_adapter(session->device)),
-		 phys);
-
-	session->uinput = uinput_create(session->device, address, phys);
+	session->uinput = uinput_create(session->device, name, " (AVRCP)");
 	if (session->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", address);
+		error("AVRCP: failed to init uinput for %s", name);
 	else
-		DBG("AVRCP: uinput initialized for %s", address);
+		DBG("AVRCP: uinput initialized for %s", name);
 }
 
 static struct avctp_queue *avctp_queue_create(struct avctp_channel *chan)
-- 
2.24.0.393.g34dc348eaf-goog

