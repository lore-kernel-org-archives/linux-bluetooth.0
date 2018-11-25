Return-Path: <SRS0=yWLZ=OE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE4C43441
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900FD20868
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900FD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeKYUK4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:10:56 -0500
Received: from a3.inai.de ([88.198.85.195]:54028 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeKYUK4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Nov 2018 15:10:56 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id D2DA3F8B17; Sun, 25 Nov 2018 10:20:17 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 2A9F2F8B1B;
        Sun, 25 Nov 2018 10:20:14 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] build: add missing UDEV_CFLAGS
Date:   Sun, 25 Nov 2018 10:20:10 +0100
Message-Id: <20181125092012.8001-7-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125092012.8001-1-jengelh@inai.de>
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
 <20181125092012.8001-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some targets link UDEV_LIBS, which means they also need UDEV_CFLAGS
in their (or the global) CPPFLAGS.
---
 Makefile.tools | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 55e769d8c..35412ca61 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -38,6 +38,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/intel.h monitor/intel.c \
 				monitor/broadcom.h monitor/broadcom.c \
 				monitor/tty.h
+monitor_btmon_CPPFLAGS = $(AM_CPPFLAGS) $(UDEV_CFLAGS)
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la $(UDEV_LIBS)
 endif
@@ -187,6 +188,7 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/gatt-service profiles/iap/iapd
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
+tools_bdaddr_CPPFLAGS = $(AM_CPPFLAGS) $(UDEV_CFLAGS)
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
 
 tools_avinfo_LDADD = lib/libbluetooth-internal.la
@@ -336,6 +338,7 @@ tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c
 tools_hciconfig_LDADD = lib/libbluetooth-internal.la
 
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c
+tools_hcitool_CPPFLAGS = $(AM_CPPFLAGS) $(UDEV_CFLAGS)
 tools_hcitool_LDADD = lib/libbluetooth-internal.la $(UDEV_LIBS)
 
 tools_hcidump_SOURCES = tools/hcidump.c \
@@ -389,6 +392,7 @@ udevdir = $(UDEV_DIR)
 
 udev_PROGRAMS = tools/hid2hci
 
+tools_hid2hci_CPPFLAGS = $(AM_CPPFLAGS) $(UDEV_CFLAGS)
 tools_hid2hci_LDADD = $(UDEV_LIBS)
 
 dist_man_MANS += tools/hid2hci.1
-- 
2.19.1

