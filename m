Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C506139A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhEDFDG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDFDF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:03:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D87C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:02:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so4162188plr.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PlI9ILPUfQjF7DnuMPKx9v6ZzFuvkCLXnu6vqnwRLYU=;
        b=nokch9UKPfvotMcYov0Opf3BzBHFWy5nOW/1NykyNFRb+OKrpkKV9hZIE+HfTJAtvb
         OV6PQbAhqfPJCJ2cneHuuQB9bnD+zg1EMiwiDlAnWGPHA4PCivrIqdjw5q+KfUc0D1pb
         Z66snYqQcHbkgcTSULh7WoCiTOsHrVsDHARGL1lWxA2eLUNXBm0olw2jbn5ib0VI33oB
         wC/gP93iblMzB5Wn0wBsV1DMN5UXc1n9kLGCrnq0fDV+nE45ULIXPTOQTK0rfFKaUBG0
         1iysVbM1qa6VoqhY24g2D4MBt12m4OY+E0/9YXri73R2czgkyR0sG3Y7TbbkP6IdJe9h
         FZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlI9ILPUfQjF7DnuMPKx9v6ZzFuvkCLXnu6vqnwRLYU=;
        b=VFQxhr8Ekfg5LY3jP2Re+SdFvrwLvPNY85TT4JuhHQScvV+8I6d07WfqyqecBAKqmM
         8Ri9X0xq9+Fz4vFGI9KKxV0tFE4fXkzhmb70X0v/bAyrgYJ8wVfgrT0FaTdCp0H/q+HO
         NB8z7OUK+FmQhfQZ+uWk4DPx3xGbg24QBAMDVHLvSuy/AAzhNGVKA2fgECQ6pfsx4tm3
         JnfbQ94RiGLhvWged/cHxtJBiILp49dM2470MuK21NOd819+AzyPV3A6rpuKZAigurDt
         mab2DFSHkaKqtgBGxAUJDh472rTpqAJbn00iXC5nuZ4TwxeNCMFWx0jqAF1+jo2eH2Ab
         9mEA==
X-Gm-Message-State: AOAM531Qs46g9oErBuF9gtY52jTsoZVOBKku7hGZDJQmtXnTtS2ej4UA
        uS+6EScMUt7/KNYADQCevk8cCFsJwjGBXw==
X-Google-Smtp-Source: ABdhPJzhRKU/ymj0DGluw1aBn/DK6H2GB/I6URsd3YAp6rKZVu3EopxlYn93J4F3Qoz9mgSqF1+Wmg==
X-Received: by 2002:a17:902:6901:b029:ee:e531:ca5f with SMTP id j1-20020a1709026901b02900eee531ca5fmr4455725plk.37.1620104529755;
        Mon, 03 May 2021 22:02:09 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id m20sm1508385pjq.40.2021.05.03.22.02.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:02:09 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 1/4] build: Fix manpage enable flag
Date:   Mon,  3 May 2021 22:02:04 -0700
Message-Id: <20210504050207.841261-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210504050207.841261-1-hj.tedd.an@gmail.com>
References: <20210504050207.841261-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the manpages installation with --enable-manpages option
so the manpages are not installed by default if the option is not set
during the configuration.
---
 Makefile.am    | 19 ++++++++-----------
 Makefile.tools | 33 ++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2a222167f..cb0d5fc0a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,10 +12,6 @@ bin_PROGRAMS =
 
 noinst_PROGRAMS =
 
-dist_man_MANS =
-
-dist_noinst_MANS =
-
 CLEANFILES =
 
 EXTRA_DIST =
@@ -60,6 +56,10 @@ else
 build_plugindir = $(plugindir)
 endif
 
+if MANPAGES
+man_MANS =
+endif
+manual_pages =
 
 plugin_LTLIBRARIES =
 
@@ -342,7 +342,10 @@ nodist_src_bluetoothd_SOURCES = $(builtin_files)
 
 CLEANFILES += $(builtin_files) src/bluetooth.service
 
-man_MANS = src/bluetoothd.8
+if MANPAGES
+man_MANS += src/bluetoothd.8
+endif
+EXTRA_DIST += src/bluetoothd.8
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -591,12 +594,6 @@ if LIBRARY
 pkgconfig_DATA = lib/bluez.pc
 endif
 
-manual_pages = doc/btmon.1
-
-if MANPAGES
-dist_noinst_MANS += $(manual_pages)
-endif
-
 EXTRA_DIST += $(manual_pages:.1=.txt)
 
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
diff --git a/Makefile.tools b/Makefile.tools
index 57e858290..160272212 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -49,7 +49,12 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/tty.h
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
+
+if MANPAGES
+man_MANS += doc/btmon.1
+endif
 endif
+manual_pages += doc/btmon.1
 
 if LOGGER
 pkglibexec_PROGRAMS += tools/btmon-logger
@@ -292,9 +297,9 @@ tools_gatt_service_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) gdbus/libgdbus-internal.la
 profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
-dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1
-
-EXTRA_DIST += tools/bdaddr.1
+if MANPAGES
+man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1
+endif
 
 if MESH
 bin_PROGRAMS += tools/meshctl
@@ -400,17 +405,18 @@ tools_hcidump_LDADD = lib/libbluetooth-internal.la
 
 tools_rfcomm_LDADD = lib/libbluetooth-internal.la
 
-dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
-			tools/hcitool.1 tools/hcidump.1 \
-			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
-else
-EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
+if MANPAGES
+man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
 endif
-else
-EXTRA_DIST += tools/rctest.1 tools/l2ping.1 tools/btattach.1
 endif
+endif
+EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
+			tools/hcitool.1 tools/hcidump.1 \
+			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
+			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
+			tools/bdaddr.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
@@ -419,10 +425,11 @@ udev_PROGRAMS = tools/hid2hci
 
 tools_hid2hci_LDADD = $(UDEV_LIBS)
 
-dist_man_MANS += tools/hid2hci.1
-else
-EXTRA_DIST += tools/hid2hci.1
+if MANPAGES
+man_MANS += tools/hid2hci.1
+endif
 endif
+EXTRA_DIST += tools/hid2hci.1
 
 if READLINE
 noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
-- 
2.26.3

