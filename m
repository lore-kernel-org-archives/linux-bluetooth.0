Return-Path: <SRS0=Orb+=UD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B26CC282CE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030A620874
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDU3Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:29:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:34192 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFDU3Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jun 2019 16:29:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 13:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,550,1549958400"; 
   d="scan'208";a="181680789"
Received: from bgix-dell-lap.sea.intel.com ([10.254.84.39])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2019 13:29:23 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        ludwig.nussel@suse.de, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: [PATCH BlueZ v4 2/3] build: Add support for systemd bluetooth-mesh service
Date:   Tue,  4 Jun 2019 13:28:51 -0700
Message-Id: <20190604202852.12656-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190604202852.12656-1-brian.gix@intel.com>
References: <20190604202852.12656-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

This adds support for installing systemd bluetooth-mesh service unit
and D-Bus service file that references this systemd unit.
---
 Makefile.mesh                  | 14 ++++++++++++--
 mesh/bluetooth-mesh.service.in | 17 +++++++++++++++++
 mesh/org.bluez.mesh.service    |  5 +++++
 3 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 mesh/bluetooth-mesh.service.in
 create mode 100644 mesh/org.bluez.mesh.service

diff --git a/Makefile.mesh b/Makefile.mesh
index 8dacc104c..85b88eba4 100644
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
@@ -32,7 +37,12 @@ pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
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
index 000000000..818319132
--- /dev/null
+++ b/mesh/bluetooth-mesh.service.in
@@ -0,0 +1,17 @@
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
+Restart=on-failure
+
+[Install]
+WantedBy=bluetooth.target
+Alias=dbus-org.bluez.mesh.service
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
2.14.5

