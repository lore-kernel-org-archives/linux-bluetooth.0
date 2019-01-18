Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14555C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 03:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4B420850
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 03:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfARDrB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:47:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:36812 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfARDrB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jan 2019 22:47:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 19:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208,217";a="126767679"
Received: from xiaolin2-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.105.175])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2019 19:46:59 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
Date:   Thu, 17 Jan 2019 19:46:52 -0800
Message-Id: <20190118034652.4018-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds new D-Bus policy file btmesh.conf
---
 Makefile.mesh    |  6 ++++++
 mesh/btmesh.conf | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 mesh/btmesh.conf

diff --git a/Makefile.mesh b/Makefile.mesh
index ea6c5e939..e15718116 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -1,5 +1,9 @@
 if MESH
 
+if DATAFILES
+dbus_DATA += mesh/btmesh.conf
+endif
+
 mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/net_keys.h mesh/net_keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
@@ -27,4 +31,6 @@ libexec_PROGRAMS += mesh/meshd
 mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
+
+EXTRA_DIST += mesh/btmesh.conf
 endif
diff --git a/mesh/btmesh.conf b/mesh/btmesh.conf
new file mode 100644
index 000000000..f05545065
--- /dev/null
+++ b/mesh/btmesh.conf
@@ -0,0 +1,24 @@
+<!-- This configuration file specifies the required security policies
+     for Bluetooth Mesh daemon to work. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+
+  <!-- ../system.conf have denied everything, so we just punch some holes -->
+
+  <policy user="root">
+    <allow own="org.bluez.mesh"/>
+    <allow send_destination="org.bluez.mesh"/>
+    <allow send_interface="org.bluez.mesh.Application1"/>
+    <allow send_interface="org.bluez.mesh.Element1"/>
+    <allow send_interface="org.bluez.mesh.ProvisionAgent1"/>
+    <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
+    <allow send_interface="org.freedesktop.DBus.Properties"/>
+  </policy>
+
+  <policy context="default">
+    <allow send_destination="org.bluez.mesh"/>
+  </policy>
+
+</busconfig>
-- 
2.17.2

