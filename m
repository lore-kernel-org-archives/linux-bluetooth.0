Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56120C43441
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230CD2080F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230CD2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeKSCfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: from a3.inai.de ([88.198.85.195]:54162 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeKSCfA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:00 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 5233213023DE; Sun, 18 Nov 2018 17:08:09 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 97CE4260D2B2;
        Sun, 18 Nov 2018 17:08:07 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH 1/8] build: rename libexecdir to pkglibexecdir
Date:   Sun, 18 Nov 2018 17:07:55 +0100
Message-Id: <20181118160802.11087-2-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118160802.11087-1-jengelh@inai.de>
References: <20181118160802.11087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When files are to be placed not in libexecdir but a subdirectory of
it, automake has a variable name reserved for exactly that purpose
(and a default value, which Makefile.am will override), called
pkglibexecdir. Let's use it.
---
 Makefile.am                       | 4 ++--
 obexd/src/obex.service.in         | 2 +-
 src/bluetooth.service.in          | 2 +-
 tools/bluetooth-logger.service.in | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0ccf393c6..eee70b88b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,7 +19,7 @@ CLEANFILES =
 
 EXTRA_DIST =
 
-libexecdir = @libexecdir@/bluetooth
+pkglibexecdir = @libexecdir@/bluetooth
 
 libexec_PROGRAMS =
 
@@ -489,7 +489,7 @@ MAINTAINERCLEANFILES = Makefile.in \
 	ltmain.sh depcomp compile missing install-sh mkinstalldirs test-driver
 
 SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
-		$(SED) -e 's,@libexecdir\@,$(libexecdir),g' \
+		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
 		< $< > $@
 
 %.service: %.service.in Makefile
diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index bca3aef66..fc0dce993 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -4,7 +4,7 @@ Description=Bluetooth OBEX service
 [Service]
 Type=dbus
 BusName=org.bluez.obex
-ExecStart=@libexecdir@/obexd
+ExecStart=@pkglibexecdir@/obexd
 
 [Install]
 Alias=dbus-org.bluez.obex.service
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f799f65f0..f9faaa452 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -6,7 +6,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 [Service]
 Type=dbus
 BusName=org.bluez
-ExecStart=@libexecdir@/bluetoothd
+ExecStart=@pkglibexecdir@/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
diff --git a/tools/bluetooth-logger.service.in b/tools/bluetooth-logger.service.in
index 026a2f130..009002731 100644
--- a/tools/bluetooth-logger.service.in
+++ b/tools/bluetooth-logger.service.in
@@ -4,7 +4,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
 
 [Service]
 Type=simple
-ExecStart=@libexecdir@/btmon-logger -p -b /var/log/bluetooth/hci.log
+ExecStart=@pkglibexecdir@/btmon-logger -p -b /var/log/bluetooth/hci.log
 NotifyAccess=main
 CapabilityBoundingSet=CAP_NET_RAW
 LimitNPROC=1
-- 
2.19.1

