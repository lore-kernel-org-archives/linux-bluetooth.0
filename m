Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC84C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 05:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DF561209
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 05:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhEQFZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 01:25:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:14898 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhEQFZU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 01:25:20 -0400
IronPort-SDR: mPU6UVhx2ySKY+ron/M0rpppCULqnKE14JO5waMCBWX1haq0evle9p7NfPrsL3ZK/TlXZw9nl5
 w2rjdeWleWyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197298863"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="197298863"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 22:24:04 -0700
IronPort-SDR: IV5GaB7+2lLo+roz6EgGVW54nIMF5iZbhFhWYXRmFxvpjaWZtiYf/bgXZ60nh9Zah9QZo95Ala
 pIi1jxiOC6dg==
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="437539958"
Received: from jard-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.127.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 22:24:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add manpage for bluetooth-meshd daemon
Date:   Sun, 16 May 2021 22:23:57 -0700
Message-Id: <20210517052357.360724-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds manpage with a brief description of BLuettoth Mesh daemon
command line options.
---
 .gitignore                  |  2 +
 Makefile.mesh               |  5 +++
 configure.ac                |  3 +-
 mesh/bluetooth-meshd.rst.in | 74 +++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 mesh/bluetooth-meshd.rst.in

diff --git a/.gitignore b/.gitignore
index 9c8393a81..9f57aa193 100644
--- a/.gitignore
+++ b/.gitignore
@@ -145,6 +145,8 @@ tools/meshctl
 tools/mesh-cfgclient
 tools/mesh-cfgtest
 mesh/bluetooth-meshd
+mesh/bluetooth-meshd.8
+mesh/bluetooth-meshd.rst
 
 src/bluetoothd.8
 src/bluetoothd.rst
diff --git a/Makefile.mesh b/Makefile.mesh
index 73eaded4a..fc28b0557 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -47,6 +47,11 @@ mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
 				mesh/bluetooth-mesh.service
 
+if MANPAGES
+man_MANS += mesh/bluetooth-meshd.8
+endif
+manual_pages += mesh/bluetooth-meshd.8
+
 CLEANFILES += mesh/bluetooth-mesh.service
 
 endif
diff --git a/configure.ac b/configure.ac
index 5157da1b5..af700eb13 100644
--- a/configure.ac
+++ b/configure.ac
@@ -392,6 +392,7 @@ AC_SUBST(CONFIGDIR, "${configdir}")
 
 AC_DEFINE_UNQUOTED(MESH_STORAGEDIR, "${storagedir}/mesh",
 			[Directory for the mesh daemon storage files])
+AC_SUBST(MESH_STORAGEDIR, "${storagedir}/mesh")
 
 AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 			[enable BlueZ for Android]),
@@ -415,4 +416,4 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc)
+AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
diff --git a/mesh/bluetooth-meshd.rst.in b/mesh/bluetooth-meshd.rst.in
new file mode 100644
index 000000000..06cdb69da
--- /dev/null
+++ b/mesh/bluetooth-meshd.rst.in
@@ -0,0 +1,74 @@
+===============
+bluetooth-meshd
+===============
+
+---------------------
+Bluetooth Mesh daemon
+---------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: March 2021
+:Manual section: 8
+:Manual group: Linux Connectivity
+
+SYNOPSIS
+========
+
+**bluetooth-meshd** [*options* ...]
+
+DESCRIPTION
+===========
+
+Daemon for managing Bluetooth Mesh connections on Linux.
+
+OPTIONS
+=======
+
+-h, --help
+    Print bluetooth-meshd options and exit.
+
+-n, --nodetach
+    Enable logging in foreground. Directs log output to the controlling
+    terminal in addition to syslog.
+
+-i <type>, --io <type>
+    Specifies I/O interface type:
+
+    *hci<index>* - Use generic HCI io on interface hci<index>,
+    or, if no idex is specified, the first available one.
+
+    *unit:<fd_path>*- Specifies open file descriptor for
+    daemon testing.
+
+    By default, if no type is specified, uses generic I/O
+    on the first available HCI interface.
+
+-c <file>, --config <file>
+    Specifies an explicit config file path instead of relying on the
+    default path(*@CONFIGDIR@/mesh-main.conf*) for the config file.
+
+-s <dir_path>, --storage <dir path>
+    Specifies an explicit storage directory path instead of the default
+    path(*@MESH_STORAGEDIR@*) for storing mesh node(s) configuration.
+
+-d, --debug         Enable debug output.
+
+-b, --dbus-debug    Enable D-Bus debug output.
+
+FILES
+=====
+
+*@CONFIGDIR@/mesh-main.conf*
+    Location of the global configuration file containing mesh daemon settings.
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 
2.26.3

