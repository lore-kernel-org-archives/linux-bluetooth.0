Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E2C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F64B61288
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEKNcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKNcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 09:32:04 -0400
X-Greylist: delayed 428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 May 2021 06:30:58 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A42C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 06:30:58 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1620739428; bh=/9K/BaRMG9AIDEgridVAjIkmV5Eusgu3sUMTW1LTnXk=;
        h=From:To:Cc:Subject:Date:From;
        b=dwnov+bL742APotBXhXEPle+vIDWyZco+MkaI/u6uFlmoO0XtMhPTWtJADEE3On4G
         cDgFKws6KaHNJocGX8fm+WQq6YN9ylaDR43/RkGCqvBHIfxWXGnoFv4vRggbH58jpj
         iI0P2KPYaGSLv21uLcvRFmRwlhZJyYXxrzGgsCYo=
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH BlueZ] tools/mpris-proxy: Ship systemd unit file
Date:   Tue, 11 May 2021 15:22:13 +0200
Message-Id: <20210511132213.150076-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 .gitignore                   |  1 +
 Makefile.am                  |  4 ++++
 Makefile.obexd               |  3 +--
 Makefile.tools               |  8 ++++++++
 tools/mpris-proxy.service.in | 11 +++++++++++
 5 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 tools/mpris-proxy.service.in

diff --git a/.gitignore b/.gitignore
index 9c8393a81..a34dd27f6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -84,6 +84,7 @@ tools/nokfw
 tools/rtlfw
 tools/btiotest
 tools/mpris-proxy
+tools/mpris-proxy.service
 tools/bluetooth-player
 tools/l2cap-tester
 tools/sco-tester
diff --git a/Makefile.am b/Makefile.am
index 497f05f06..7a508404e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -42,6 +42,9 @@ if SYSTEMD
 systemdsystemunitdir = $(SYSTEMD_SYSTEMUNITDIR)
 systemdsystemunit_DATA = src/bluetooth.service
 
+systemduserunitdir = $(SYSTEMD_USERUNITDIR)
+systemduserunit_DATA =
+
 dbussystembusdir = $(DBUS_SYSTEMBUSDIR)
 dbussystembus_DATA = src/org.bluez.service
 endif
@@ -617,6 +620,7 @@ MAINTAINERCLEANFILES = Makefile.in \
 
 SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
+		       -e 's,@bindir\@,$(bindir),g' \
 		< $< > $@
 
 if RUN_RST2MAN
diff --git a/Makefile.obexd b/Makefile.obexd
index 6f5dc04c0..1e3f51296 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if SYSTEMD
-systemduserunitdir = $(SYSTEMD_USERUNITDIR)
-systemduserunit_DATA = obexd/src/obex.service
+systemduserunit_DATA += obexd/src/obex.service
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
diff --git a/Makefile.tools b/Makefile.tools
index c836b5984..c98228de5 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -290,6 +290,14 @@ tools_hex2hcd_SOURCES = tools/hex2hcd.c
 
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
+tools_mpris_proxy_DEPENDENCIES = tools/mpris-proxy.service
+
+if SYSTEMD
+systemduserunit_DATA += tools/mpris-proxy.service
+endif
+
+CLEANFILES += tools/mpris-proxy.service
+EXTRA_DIST += tools/mpris-proxy.service.in
 
 tools_gatt_service_SOURCES = tools/gatt-service.c
 tools_gatt_service_LDADD = $(GLIB_LIBS) $(DBUS_LIBS) gdbus/libgdbus-internal.la
diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
new file mode 100644
index 000000000..c52450f4f
--- /dev/null
+++ b/tools/mpris-proxy.service.in
@@ -0,0 +1,11 @@
+[Unit]
+Description=Bluetooth to MPRIS proxy
+
+[Service]
+Type=simple
+ExecStart=@bindir@/mpris-proxy
+NotifyAccess=main
+LimitNPROC=1
+
+[Install]
+WantedBy=bluetooth.target

base-commit: fa57cb68e13ea4a6cff5532830008d44254e7e83
-- 
2.31.1

