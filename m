Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E5C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9416D64EBA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhBRTL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhBRTGf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 14:06:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AEC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 11:05:54 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a17so7442417ljq.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAXgGci66qbhAJq8l5ejLymuCWSkeyTNArYeTD6BWP4=;
        b=2Ooi9JMtm364bq8N9i2w4A01+5zl7lREhzfD9gYa7xKs75vG+ZwJXh7sDkw7+3ZPWT
         nFJMwc+OJzTC+WSMfmSSix6sWlL/2F3ZI3TLomcdzpmntnLChEOGLpj5Rqz5bcp7C+Yp
         sEQXm+WAU+JbdFUc1t4TEcFwIUs9jrcre3ZObbcFmBevsOcGccH78D5frCOQT9W9AuPE
         UXBpsuTsay25t9RhIUXU0uQSkDzlJ0F2CjXJutOB7zlD83SKkvbB2z3YLa9xZzRH5+Bf
         2aF4QJ9t83mZsQuJK0IOSdoJBvN5mZz+v3PbH6jOjGZ5tyLGuytvGvWTAVKy21FCXivO
         EgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAXgGci66qbhAJq8l5ejLymuCWSkeyTNArYeTD6BWP4=;
        b=qoupQGOtPLKd6tFGz1Jfu6tYhamr0C+BpAigmRmCz9QsRat2HxlxJ8ugwGQPULD8Kr
         dGoNuqlZgY/dSXqdepymjnhfTdpSLAddNsXlZcae0wDienIirLJPzz0YlFZe77yTEI8A
         VX99sdy5l0cS1tTX9lzDLyPHBPDxN4mjy0SPwNXKmE7QGQIITSJ3cac+4LZIwkv/Yxr8
         q9XY9+08cnmVUEzgyPkqwpxnt93gPVuUawLfdTi8PX1YCyC4yP97qSH+Ae/cbdgJ+byu
         X6a4W0D/UnPiSfB4MVN28M0UwHdhnlMslqXHjAHrReneS0ZZ7QbMYXXj7p3xqt2CuJDk
         pI/A==
X-Gm-Message-State: AOAM5338A36er4KLaz66ZtpaGVQL87VlAF8qbNiJSqL+7Z7SBQbjdbIt
        t7/pkZ6A2EDj4kxk2PPJwWjpHlFz0CO4MA==
X-Google-Smtp-Source: ABdhPJw85ox31xB3vg4ppgCUgzQbPf90Nc7GaFjI34tfWaVT5qQpt9yccVYsejVW44+iOCG1RjpCpQ==
X-Received: by 2002:a19:7d1:: with SMTP id 200mr3285656lfh.110.1613675153153;
        Thu, 18 Feb 2021 11:05:53 -0800 (PST)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id w21sm689138lfe.33.2021.02.18.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 11:05:52 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] sixaxis: Fix Bluetooth PS3 clone joypad being named like the original
Date:   Thu, 18 Feb 2021 20:05:45 +0100
Message-Id: <20210218190545.109454-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When cable pairing a PS3 clone device, we should try and keep the USB device
name to create a new btd_device so that the joypad is named after its USB name
when connecting through Bluetooth.

If that isn't done, "Shanwan" clone joypads are named like the genuine joypads, and
kernel Bluetooth quirks aren't applied.

gh-issue: https://github.com/bluez/bluez/issues/46
---
 plugins/sixaxis.c        |  5 ++++-
 profiles/input/server.c  |  2 +-
 profiles/input/sixaxis.h | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index d693a86c0..517cecc47 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -387,6 +387,7 @@ get_pairing_type_for_device(struct udev_device *udevice, uint16_t *bus,
 						char **sysfs_path)
 {
 	struct udev_device *hid_parent;
+	const char *hid_name;
 	const char *hid_id;
 	const struct cable_pairing *cp;
 	uint16_t vid, pid;
@@ -401,7 +402,9 @@ get_pairing_type_for_device(struct udev_device *udevice, uint16_t *bus,
 	if (!hid_id || sscanf(hid_id, "%hx:%hx:%hx", bus, &vid, &pid) != 3)
 		return NULL;
 
-	cp = get_pairing(vid, pid);
+	hid_name = udev_device_get_property_value(hid_parent, "HID_NAME");
+
+	cp = get_pairing(vid, pid, hid_name);
 	*sysfs_path = g_strdup(udev_device_get_syspath(udevice));
 
 	return cp;
diff --git a/profiles/input/server.c b/profiles/input/server.c
index d8b413744..79cf08a66 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -120,7 +120,7 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	vid = btd_device_get_vendor(device);
 	pid = btd_device_get_product(device);
 
-	cp = get_pairing(vid, pid);
+	cp = get_pairing(vid, pid, NULL);
 	if (cp && (cp->type == CABLE_PAIRING_SIXAXIS ||
 					cp->type == CABLE_PAIRING_DS4))
 		return true;
diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index a3cda70e4..ab8831995 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -29,7 +29,7 @@ struct cable_pairing {
 };
 
 static inline const struct cable_pairing *
-get_pairing(uint16_t vid, uint16_t pid)
+get_pairing(uint16_t vid, uint16_t pid, const char *name)
 {
 	static const struct cable_pairing devices[] = {
 		{
@@ -40,6 +40,14 @@ get_pairing(uint16_t vid, uint16_t pid)
 			.version = 0x0000,
 			.type = CABLE_PAIRING_SIXAXIS,
 		},
+		{
+			.name = "SHANWAN PS3 GamePad",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x0268,
+			.version = 0x0000,
+			.type = CABLE_PAIRING_SIXAXIS,
+		},
 		{
 			.name = "Navigation Controller",
 			.source = 0x0002,
@@ -73,6 +81,9 @@ get_pairing(uint16_t vid, uint16_t pid)
 		if (devices[i].pid != pid)
 			continue;
 
+		if (name && strcmp(name, devices[i].name))
+			continue;
+
 		return &devices[i];
 	}
 
-- 
2.29.2

