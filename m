Return-Path: <SRS0=aznX=T7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD3C28CC2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9626E14
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 May 2019 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEaSyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 May 2019 14:54:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:38242 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfEaSyw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 May 2019 14:54:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 11:54:52 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.252.132.160])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2019 11:54:51 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2 v2] build: Add support for systemd bluetooth-mesh service
Date:   Fri, 31 May 2019 11:54:48 -0700
Message-Id: <20190531185449.9133-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531185449.9133-1-inga.stotland@intel.com>
References: <20190531185449.9133-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for installing systemd bluetooth-mesh service unit
and dbus service file that references this systemd unit.
---
 Makefile.am                    |  2 +-
 Makefile.mesh                  | 14 ++++++++++++--
 mesh/bluetooth-mesh.service.in | 12 ++++++++++++
 mesh/org.bluez.mesh.service    |  5 +++++
 4 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 mesh/bluetooth-mesh.service.in
 create mode 100644 mesh/org.bluez.mesh.service

diff --git a/Makefile.am b/Makefile.am
index f84a1faba..3f398dc5a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -560,7 +560,7 @@ SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
 		< $< > $@
 
-%.service: %.service.in Makefile
+%.service: %.service.in Makefile Makefile.mesh
 	$(SED_PROCESS)
 
 %.1: %.txt
diff --git a/Makefile.mesh b/Makefile.mesh
index d494287ab..9cd6e73d6 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -4,6 +4,11 @@ if DATAFILES
 dbus_DATA += mesh/bluetooth-mesh.conf
 endif
 
+if SYSTEMD
+systemdsystemunit_DATA += mesh/bluetooth-mesh.service
+dbussystembus_DATA += mesh/org.bluez.mesh.service
+endif
+
 mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/net-keys.h mesh/net-keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
@@ -32,7 +37,12 @@ libexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
-mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
+mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
+				mesh/bluetooth-mesh.service
+
+EXTRA_DIST += mesh/bluetooth-mesh.conf mesh/bluetooth-mesh.service.in \
+		mesh/org.bluez.mesh.service
+
+CLEANFILES += mesh/bluetooth-mesh.service
 
-EXTRA_DIST += mesh/bluetooth-mesh.conf
 endif
diff --git a/mesh/bluetooth-mesh.service.in b/mesh/bluetooth-mesh.service.in
new file mode 100644
index 000000000..36f2a1d4a
--- /dev/null
+++ b/mesh/bluetooth-mesh.service.in
@@ -0,0 +1,12 @@
+[Unit]
+Description=Bluetooth mesh service
+ConditionPathIsDirectory=/sys/class/bluetooth
+
+[Service]
+Type=dbus
+BusName=org.bluez.mesh
+ExecStart=@pkglibexecdir@/bluetooth-meshd
+NotifyAccess=main
+LimitNPROC=1
+ProtectHome=true
+ProtectSystem=full
diff --git a/mesh/org.bluez.mesh.service b/mesh/org.bluez.mesh.service
new file mode 100644
index 000000000..a61c44455
--- /dev/null
+++ b/mesh/org.bluez.mesh.service
@@ -0,0 +1,5 @@
+[D-BUS Service]
+Name=org.bluez.mesh
+Exec=/bin/false
+User=root
+SystemdService=dbus-org.bluez.mesh.service
-- 
2.21.0

