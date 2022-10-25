Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829AAFA373E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJYVNF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJYVNE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 17:13:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8D106A56
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 14:13:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r1so1361201ilg.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygM60BjTK/Gp3D6hT+2zvWdUnoEjruIpLetF6G5CN4c=;
        b=GMrmHZL+v8HAi54XLvlIYuiKB78jSMkQv7J8rSPq4uLhsos0lYxOY8LRggaDsr6BED
         fSXjrlyImUKZmBLk9+l0jIV0noT7fpUJb0ELhCzfhJVKe4wl/lvNDuMdWY5wtGvFCtmI
         +0tuz1avJDA4xE3iPJaz2r3MazQro36AZulKDaVwvEpBVQWtE0+T3UK2OLZYAj9GfBwO
         GcYKGxNJTNjqRqfnyEmLjLwIMTR54EXhCSrRpH7HIuFgTWMhQWATSAfehmTflj6VKcjv
         Ecpbyek/HQB3Le1tvqKM9pN6OO7hSdAKiM4ARSzqC97mCZWKNnt4CdcE4zPRD6j/0SCD
         63rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygM60BjTK/Gp3D6hT+2zvWdUnoEjruIpLetF6G5CN4c=;
        b=ADTkowkrQ5FJypCaGOaEsC/EGRFIX5QjLfZXDIu5u+IuL230vDw4crP+Ih/ni/MFVK
         fYCT9sE6i/Sdki1lya7L2QojFnAVLcqbIIFecaHNgpscM9CHMEtfIsxknaYo3cox6bh/
         vVponPEdj8rsUD/3CEhX0SV4TJtDzmKkeHBRg8wihW81GE913tXWyOl0Rw9DqVT5kaqX
         E+uCCwjd3GQbEE8jvVBZ9AbDT+bRlvG5KNkkTgv/w1kIxpS+fbrSt9TJRhXPWo4lltYM
         M/r9WfmAPyu8OgpQckvBE+UFMuIISBh8KlpK2/aht5XenSSJULKomh+1tgGlY20cnJPO
         6Q9w==
X-Gm-Message-State: ACrzQf1W4C4ckZTMR5zWFRKCLA8ZfwcHbpv5TjtbkHccCsitFtmw2wUG
        ax/CM77uofD48yCrAIkvyZyTj5ixeAA=
X-Google-Smtp-Source: AMsMyM6DBuaHaS2iVOgcUkBhApddIgPw4T4JrL9da0OeKU0g6jB39FctRVYPgcg3hl1fKjJg74O3jQ==
X-Received: by 2002:a92:1912:0:b0:2fc:f539:9da9 with SMTP id 18-20020a921912000000b002fcf5399da9mr25546353ilz.262.1666732381126;
        Tue, 25 Oct 2022 14:13:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w11-20020a02394b000000b003636c046e73sm1253337jae.95.2022.10.25.14.12.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 14:13:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Add CONFIG_BT_HCIBTUSB_POLL_SYNC
Date:   Tue, 25 Oct 2022 14:12:57 -0700
Message-Id: <20221025211258.1385541-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds CONFIG_BT_HCIBTUSB_POLL_SYNC which can be used to set the
default behavior of Bluetooth USB controller with respect to poll
synchronization of its endpoits.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/Kconfig | 10 ++++++++++
 drivers/bluetooth/btusb.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e30707405455..fc36057d546d 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -45,6 +45,16 @@ config BT_HCIBTUSB_AUTOSUSPEND
 	  This can be overridden by passing btusb.enable_autosuspend=[y|n]
 	  on the kernel commandline.
 
+config BT_HCIBTUSB_POLL_SYNC
+	bool "Enable USB poll_sync for Bluetooth USB devices by default"
+	depends on BT_HCIBTUSB
+	help
+	  poll_sync synchronizes the USB data and event endpoints by
+	  prioritizing the later.
+
+	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
+	  default.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30dd443f395f..bf978d3659cb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -32,6 +32,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
+static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -3973,6 +3974,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
+	data->poll_sync = enable_poll_sync;
+
 	err = hci_register_dev(hdev);
 	if (err < 0)
 		goto out_free_dev;
-- 
2.37.3

