Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00490C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C777C20715
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H95yzW87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLCBG0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:06:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33151 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCBG0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 20:06:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so848794pfb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 17:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hpUK9ZBIMphM9rzqP+YZa2i8oL0Tw5HGDAWHY72grw=;
        b=H95yzW87scREq8cDX6kwC18FNWCp60gg6A2mzkDcS18jzs674sVj+bXd+28dSubpWu
         9khnwdL/IaR4b4k/Yv7vNbut/w+yvfshoFvfvl4xo5VvklJDfpIPZ2KtrXJGxuiug5eN
         WB64y3jy2GcsGUYnxwpR4/dyDfjQ6Tv3uGHF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hpUK9ZBIMphM9rzqP+YZa2i8oL0Tw5HGDAWHY72grw=;
        b=OssFqqNKX8bMf0QdUTY9PDsnE0ega23hGkn28aNWvHwmZnhtNSXtLE4AZ1J22C96gr
         akijXMkcfoRccs9H0qn4hZyqWu48IAyYRN0fy9j+17aU1IFz7hWjs4tIE72MHOdgU4TE
         erBFyyEOxOzARjge/KI/VdAOvJ9FaGt7Z6lbqPRCGfA8wKVkmudCX/k2XRoFhtjDeTr+
         +lo7d5lBQn7/VVRQpKCxVqkGfjSn5LP2cercfAlCOWQ2/WSljwmScamero6ftgRx9OIO
         mqTxYclWHOgsJ2Fcs30QwcJhvxZn6skB0RWpVVgJl3Jb+EGOu7iR3WILq+IvrzRwCfE5
         TlTg==
X-Gm-Message-State: APjAAAX9o3MkdHsrdaFnqbkBXM4YKdyWBJ1mtJLXHOTNu77tpjdukbne
        +KwhN15j5jdFSnYrFAhBENZGWg==
X-Google-Smtp-Source: APXvYqzr4xPCHPcLCI5HtfE9qVaheAeOLlwDIfa28rXytOK3F3tgNBaMaFXEWun0e0i8nJvZb0z+DA==
X-Received: by 2002:a62:4ec7:: with SMTP id c190mr1822918pfb.68.1575335185441;
        Mon, 02 Dec 2019 17:06:25 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 143sm741808pfz.67.2019.12.02.17.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:05:28 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 4/4] input: Set uniq attribute
Date:   Mon,  2 Dec 2019 17:04:00 -0800
Message-Id: <20191203010400.216538-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191203010400.216538-1-abhishekpandit@chromium.org>
References: <20191203010400.216538-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set the uniq attribute of /dev/uinput with the peer device address.

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
    ATTR{uniq}=="00:00:00:1a:33:21"

---

This change requires an accompanying change in the kernel that adds the
set uniq ioctl. The change is available here:

https://lore.kernel.org/linux-bluetooth/20191127185139.65048-1-abhishekpandit@chromium.org/T/#u


Changes in v2:
- Split setting uniq to its own commit

 profiles/audio/avctp.c | 4 +++-
 src/uinput.h           | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 5116a5cde..544bc640c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1166,7 +1166,7 @@ static int uinput_create(struct btd_device *device, const char *name,
 {
 	struct uinput_dev dev;
 	int fd, err, i;
-	char src[18];
+	char dest[18], src[18];
 
 	fd = open("/dev/uinput", O_RDWR);
 	if (fd < 0) {
@@ -1222,7 +1222,9 @@ static int uinput_create(struct btd_device *device, const char *name,
 	ioctl(fd, UI_SET_EVBIT, EV_SYN);
 
 	ba2strlc(btd_adapter_get_address(device_get_adapter(device)), src);
+	ba2strlc(device_get_address(device), dest);
 	ioctl(fd, UI_SET_PHYS, src);
+	ioctl(fd, UI_SET_UNIQ, dest);
 
 	for (i = 0; key_map[i].name != NULL; i++)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
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
2.24.0.393.g34dc348eaf-goog

