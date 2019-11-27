Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC27C43215
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572B720835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idISh2kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK0TJn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:09:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43649 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfK0TJm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 14:09:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so1324383pfe.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 11:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im3rxYUbSt+ZEUJ3vfRfLw4DYfeHLKewqBxzS3SxPSY=;
        b=idISh2kEa6EFu+0kFIHoX5VlYkI8OTxafIbp3Tm2MB/lMaLfGyL7YAm+Oh/mQJ1UB1
         g6HjTUupT8zIxR3+l5CEbkaDSCsDljiN343MjdL6hFvcIPfcAjyVS57G4t/0wM5618LC
         kAAgexYL5RCc4KiEEHzfAn7mbEjsefSxt4SdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im3rxYUbSt+ZEUJ3vfRfLw4DYfeHLKewqBxzS3SxPSY=;
        b=oK4WL2XqdJqOx5AWDoX5WEJgovGvoVskRd9ygdqXyTPDo12BRzlayFoR4rHlhcfdLG
         QKVe5yv6TRB0oae8Vzhm7Umypud7TMUwraLcrYccbEYEtbiyNP6rT9pYd79FwVhS7pwZ
         LNhcOuHdIONcebEtylIvmPiPCXrN6U7cu8D9kxiCGGCt91BZ4hmqrDwRZo03eP9bsJq1
         MSiGzwwjluxKTDLXBTch8HAZTHRZhnoBwH7hbpmCTcyna0XnqnDu2t3BptJbGtOzyhJt
         kirUHA7xFi5qY9eFK2GAAFy3CJECNzcIGJlIqlTTEMzuzuEgtxdsjFHG66FWdpRqgZ6L
         x8Dw==
X-Gm-Message-State: APjAAAUsN9jjaxmiNEfOsT0JL846S/VTjah4SFMQepF4h8pa4GVtbK2B
        ZDtCS+tJtQS2lQLaypvIptwBAg==
X-Google-Smtp-Source: APXvYqxf1tpVcRLU3TY6Gt31m8JJ3iR2nEeOwY1fYxt/ROa6ct9SxIuHt6/ZlL/i68XCpHuBo44FZQ==
X-Received: by 2002:a63:a357:: with SMTP id v23mr6781997pgn.223.1574881781889;
        Wed, 27 Nov 2019 11:09:41 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id u24sm17280519pfh.48.2019.11.27.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:09:41 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH 2/2] input: Change uinput name and set uniq attribute
Date:   Wed, 27 Nov 2019 11:09:15 -0800
Message-Id: <20191127190941.90789-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
References: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When creating the uinput device, change the name to the peer device
name. Set the peer device address to the uniq attribute instead of the
name.

The resulting uinput device will look like this:

$ udevadm info -a -p /sys/devices/virtual/input/input17
...
  looking at device '/devices/virtual/input/input17':
    KERNEL=="input17"
    SUBSYSTEM=="input"
    DRIVER==""
    ATTR{inhibited}=="0"
    ATTR{name}=="BeatsStudio Wireless"
    ATTR{phys}=="00:00:00:6e:d0:74"
    ATTR{properties}=="0"
    ATTR{uniq}=="00:00:00:cc:1c:f3"

---

This change requires an accompanying change in the kernel that adds the
set uniq ioctl. The change is available here:

https://lore.kernel.org/linux-bluetooth/20191127185139.65048-1-abhishekpandit@chromium.org/T/#u

If this change looks ok, I would like to merge it with the previous
change before merging since they're related.


 profiles/audio/avctp.c | 18 +++++++++---------
 src/uinput.h           |  2 ++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 42136f94b..05df57bd2 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1162,7 +1162,7 @@ failed:
 }
 
 static int uinput_create(struct btd_device *device, const char *name,
-			 const char *phys)
+			 const char *src, const char *dst)
 {
 	struct uinput_dev dev;
 	int fd, err, i;
@@ -1203,8 +1203,8 @@ static int uinput_create(struct btd_device *device, const char *name,
 	ioctl(fd, UI_SET_EVBIT, EV_REP);
 	ioctl(fd, UI_SET_EVBIT, EV_SYN);
 
-	/* Also set the phys */
-	ioctl(fd, UI_SET_PHYS, phys);
+	ioctl(fd, UI_SET_PHYS, src);
+	ioctl(fd, UI_SET_UNIQ, dst);
 
 	for (i = 0; key_map[i].name != NULL; i++)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
@@ -1224,7 +1224,7 @@ static int uinput_create(struct btd_device *device, const char *name,
 
 static void init_uinput(struct avctp *session)
 {
-	char address[18], phys[18], name[248 + 1];
+	char dest[18], src[18], name[248 + 1];
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -1234,15 +1234,15 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	ba2strlc(device_get_address(session->device), address);
+	ba2strlc(device_get_address(session->device), dest);
 	ba2strlc(btd_adapter_get_address(device_get_adapter(session->device)),
-		 phys);
+		 src);
 
-	session->uinput = uinput_create(session->device, address, phys);
+	session->uinput = uinput_create(session->device, name, src, dest);
 	if (session->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", address);
+		error("AVRCP: failed to init uinput for %s", dest);
 	else
-		DBG("AVRCP: uinput initialized for %s", address);
+		DBG("AVRCP: uinput initialized for %s", dest);
 }
 
 static struct avctp_queue *avctp_queue_create(struct avctp_channel *chan)
diff --git a/src/uinput.h b/src/uinput.h
index 20e0941d1..589c22528 100644
--- a/src/uinput.h
+++ b/src/uinput.h
@@ -686,6 +686,8 @@ extern "C" {
 #define UI_SET_FFBIT		_IOW(UINPUT_IOCTL_BASE, 107, int)
 #define UI_SET_PHYS		_IOW(UINPUT_IOCTL_BASE, 108, char*)
 #define UI_SET_SWBIT		_IOW(UINPUT_IOCTL_BASE, 109, int)
+#define UI_SET_PROPBIT		_IOW(UINPUT_IOCTL_BASE, 110, int)
+#define UI_SET_UNIQ		_IOW(UINPUT_IOCTL_BASE, 111, char*)
 
 #ifndef NBITS
 #define NBITS(x) ((((x) - 1) / (sizeof(long) * 8)) + 1)
-- 
2.24.0.432.g9d3f5f5b63-goog

