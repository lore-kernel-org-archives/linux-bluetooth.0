Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BF33E364
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073023; cv=none; b=JgnCF9F2+EI57X58v9ckP/E6NP34CMUR3VWkbW4ZgvRWKW5bR7YDOdyNlv5FWB8bM8Dy9jJhOAjc1H+tgejcJKWu/eEDJZWIYYJmvk+J8GJnTbkjbaudhx72iG/PTzyaMW7NtolPHGmnS+nGTNcNDYhcjeiN35xnqggzC/RuAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073023; c=relaxed/simple;
	bh=4g2DQ/+I8mRqIaFW8MdVRIQDj9o+f6OlE3jBdDWlmYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNfB08WFNw7QdxIcnet5kGChpL5LyUUq7RAiMVv5uzfRfMyshRO7PWx8sxn/2TmpZxfzGeOtHQ75tCJ+VEQjb6USB8dclJtv756aXlgsyoDUBlb9t5iOwyRSU0Gb+YH6pzs/6ZlbtUewNqNPqO0E2BjQzjr9xFBELIkfsgchhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8C2D41B5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:12 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 2/9] doc: Move all the man pages to doc/
Date: Thu, 22 Jan 2026 10:05:01 +0100
Message-ID: <20260122091003.398400-3-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122091003.398400-1-hadess@hadess.net>
References: <20260122091003.398400-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefggfelfefhteejudetjeduteehgfduheehueejvdejfeefjeetfeeuteevfffhteenucffohhmrghinheprhhsthdrihhnpdgslhhuvgiirdgtrghllhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffkeevvdffgeduueehhfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

No modifications are made to the documentation files, their sources (rst
or rst.in) are just moved to doc/ and the autotools build files adjusted
for the new path.
---
 Makefile.am                                |  4 +-
 Makefile.mesh                              |  4 +-
 Makefile.tools                             | 68 +++++++++++-----------
 configure.ac                               |  4 +-
 {tools => doc}/bdaddr.rst                  |  0
 {mesh => doc}/bluetooth-meshd.rst.in       |  0
 {client => doc}/bluetoothctl-admin.rst     |  0
 {client => doc}/bluetoothctl-advertise.rst |  0
 {client => doc}/bluetoothctl-assistant.rst |  0
 {client => doc}/bluetoothctl-bredr.rst     |  0
 {client => doc}/bluetoothctl-endpoint.rst  |  0
 {client => doc}/bluetoothctl-gatt.rst      |  0
 {client => doc}/bluetoothctl-hci.rst       |  0
 {client => doc}/bluetoothctl-le.rst        |  0
 {client => doc}/bluetoothctl-mgmt.rst      |  0
 {client => doc}/bluetoothctl-monitor.rst   |  0
 {client => doc}/bluetoothctl-player.rst    |  0
 {client => doc}/bluetoothctl-scan.rst      |  0
 {client => doc}/bluetoothctl-telephony.rst |  0
 {client => doc}/bluetoothctl-transport.rst |  0
 {client => doc}/bluetoothctl.rst           |  0
 {src => doc}/bluetoothd.rst.in             |  0
 {tools => doc}/btattach.rst                |  0
 {tools => doc}/btmgmt.rst                  |  0
 {monitor => doc}/btmon.rst                 |  0
 {tools => doc}/ciptool.rst                 |  0
 {tools => doc}/hciattach.rst               |  0
 {tools => doc}/hciconfig.rst               |  0
 {tools => doc}/hcidump.rst                 |  0
 {tools => doc}/hcitool.rst                 |  0
 {tools => doc}/hid2hci.rst                 |  0
 {tools => doc}/isotest.rst                 |  0
 {tools => doc}/l2ping.rst                  |  0
 {tools => doc}/rctest.rst                  |  0
 {tools => doc}/rfcomm.rst                  |  0
 {tools => doc}/sdptool.rst                 |  0
 36 files changed, 40 insertions(+), 40 deletions(-)
 rename {tools => doc}/bdaddr.rst (100%)
 rename {mesh => doc}/bluetooth-meshd.rst.in (100%)
 rename {client => doc}/bluetoothctl-admin.rst (100%)
 rename {client => doc}/bluetoothctl-advertise.rst (100%)
 rename {client => doc}/bluetoothctl-assistant.rst (100%)
 rename {client => doc}/bluetoothctl-bredr.rst (100%)
 rename {client => doc}/bluetoothctl-endpoint.rst (100%)
 rename {client => doc}/bluetoothctl-gatt.rst (100%)
 rename {client => doc}/bluetoothctl-hci.rst (100%)
 rename {client => doc}/bluetoothctl-le.rst (100%)
 rename {client => doc}/bluetoothctl-mgmt.rst (100%)
 rename {client => doc}/bluetoothctl-monitor.rst (100%)
 rename {client => doc}/bluetoothctl-player.rst (100%)
 rename {client => doc}/bluetoothctl-scan.rst (100%)
 rename {client => doc}/bluetoothctl-telephony.rst (100%)
 rename {client => doc}/bluetoothctl-transport.rst (100%)
 rename {client => doc}/bluetoothctl.rst (100%)
 rename {src => doc}/bluetoothd.rst.in (100%)
 rename {tools => doc}/btattach.rst (100%)
 rename {tools => doc}/btmgmt.rst (100%)
 rename {monitor => doc}/btmon.rst (100%)
 rename {tools => doc}/ciptool.rst (100%)
 rename {tools => doc}/hciattach.rst (100%)
 rename {tools => doc}/hciconfig.rst (100%)
 rename {tools => doc}/hcidump.rst (100%)
 rename {tools => doc}/hcitool.rst (100%)
 rename {tools => doc}/hid2hci.rst (100%)
 rename {tools => doc}/isotest.rst (100%)
 rename {tools => doc}/l2ping.rst (100%)
 rename {tools => doc}/rctest.rst (100%)
 rename {tools => doc}/rfcomm.rst (100%)
 rename {tools => doc}/sdptool.rst (100%)

diff --git a/Makefile.am b/Makefile.am
index c7a356b2cbd7..5deea67eff00 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -364,7 +364,7 @@ nodist_src_bluetoothd_SOURCES = $(builtin_files)
 CLEANFILES += $(builtin_files)
 
 if MANPAGES
-man_MANS += src/bluetoothd.8
+man_MANS += doc/bluetoothd.8
 man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 doc/iso.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.Bearer.LE.5 doc/org.bluez.Bearer.BREDR.5 \
@@ -400,7 +400,7 @@ man_MANS += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 		doc/org.bluez.obex.Image.5
 man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 endif
-manual_pages += src/bluetoothd.8
+manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
 		doc/iso.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
diff --git a/Makefile.mesh b/Makefile.mesh
index e4c9fa6a32e6..bd3a542b7e6c 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -48,9 +48,9 @@ mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 
 if MANPAGES
-man_MANS += mesh/bluetooth-meshd.8
+man_MANS += doc/bluetooth-meshd.8
 endif
-manual_pages += mesh/bluetooth-meshd.8
+manual_pages += doc/bluetooth-meshd.8
 
 endif
 
diff --git a/Makefile.tools b/Makefile.tools
index cc8aab55cc9f..b9a092f87168 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -64,10 +64,10 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(UDEV_LIBS) -ldl
 
 if MANPAGES
-man_MANS += monitor/btmon.1
+man_MANS += doc/btmon.1
 endif
 endif
-manual_pages += monitor/btmon.1
+manual_pages += doc/btmon.1
 
 if LOGGER
 pkglibexec_PROGRAMS += tools/btmon-logger
@@ -355,15 +355,15 @@ profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
-man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
-		tools/btmgmt.1 client/bluetoothctl.1 \
-		client/bluetoothctl-mgmt.1 \
-		client/bluetoothctl-monitor.1 client/bluetoothctl-admin.1 \
-		client/bluetoothctl-advertise.1 client/bluetoothctl-endpoint.1 \
-		client/bluetoothctl-gatt.1 client/bluetoothctl-player.1 \
-		client/bluetoothctl-scan.1 client/bluetoothctl-transport.1 \
-		client/bluetoothctl-assistant.1 client/bluetoothctl-hci.1 \
-		client/bluetoothctl-telephony.1
+man_MANS += doc/rctest.1 doc/l2ping.1 doc/btattach.1 doc/isotest.1 \
+		doc/btmgmt.1 doc/bluetoothctl.1 \
+		doc/bluetoothctl-mgmt.1 \
+		doc/bluetoothctl-monitor.1 doc/bluetoothctl-admin.1 \
+		doc/bluetoothctl-advertise.1 doc/bluetoothctl-endpoint.1 \
+		doc/bluetoothctl-gatt.1 doc/bluetoothctl-player.1 \
+		doc/bluetoothctl-scan.1 doc/bluetoothctl-transport.1 \
+		doc/bluetoothctl-assistant.1 doc/bluetoothctl-hci.1 \
+		doc/bluetoothctl-telephony.1
 
 endif
 
@@ -474,30 +474,30 @@ tools_hcidump_LDADD = lib/libbluetooth-internal.la
 tools_rfcomm_LDADD = lib/libbluetooth-internal.la
 
 if MANPAGES
-man_MANS += tools/hciattach.1 tools/hciconfig.1 \
-			tools/hcitool.1 tools/hcidump.1 \
-			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
+man_MANS += doc/hciattach.1 doc/hciconfig.1 \
+			doc/hcitool.1 doc/hcidump.1 \
+			doc/rfcomm.1 doc/sdptool.1 doc/ciptool.1
 endif
 endif
 endif
-manual_pages += tools/hciattach.1 tools/hciconfig.1 \
-			tools/hcitool.1 tools/hcidump.1 \
-			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
-			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
-			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1 \
-			client/bluetoothctl.1 \
-			client/bluetoothctl-mgmt.1 \
-			client/bluetoothctl-monitor.1 \
-			client/bluetoothctl-admin.1 \
-			client/bluetoothctl-advertise.1 \
-			client/bluetoothctl-endpoint.1 \
-			client/bluetoothctl-gatt.1 \
-			client/bluetoothctl-player.1 \
-			client/bluetoothctl-scan.1 \
-			client/bluetoothctl-transport.1 \
-			client/bluetoothctl-assistant.1 \
-			client/bluetoothctl-hci.1 \
-			client/bluetoothctl-telephony.1
+manual_pages += doc/hciattach.1 doc/hciconfig.1 \
+			doc/hcitool.1 doc/hcidump.1 \
+			doc/rfcomm.1 doc/sdptool.1 doc/ciptool.1 \
+			doc/rctest.1 doc/l2ping.1 doc/btattach.1 \
+			doc/bdaddr.1 doc/isotest.1 doc/btmgmt.1 \
+			doc/bluetoothctl.1 \
+			doc/bluetoothctl-mgmt.1 \
+			doc/bluetoothctl-monitor.1 \
+			doc/bluetoothctl-admin.1 \
+			doc/bluetoothctl-advertise.1 \
+			doc/bluetoothctl-endpoint.1 \
+			doc/bluetoothctl-gatt.1 \
+			doc/bluetoothctl-player.1 \
+			doc/bluetoothctl-scan.1 \
+			doc/bluetoothctl-transport.1 \
+			doc/bluetoothctl-assistant.1 \
+			doc/bluetoothctl-hci.1 \
+			doc/bluetoothctl-telephony.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
@@ -507,10 +507,10 @@ udev_PROGRAMS = tools/hid2hci
 tools_hid2hci_LDADD = $(UDEV_LIBS)
 
 if MANPAGES
-man_MANS += tools/hid2hci.1
+man_MANS += doc/hid2hci.1
 endif
 endif
-manual_pages += tools/hid2hci.1
+manual_pages += doc/hid2hci.1
 
 if READLINE
 noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
diff --git a/configure.ac b/configure.ac
index b6f6789bea52..a21cac81f5c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -523,11 +523,11 @@ AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
 AC_CONFIG_FILES(
 	lib/bluez.pc
 	Makefile
-	mesh/bluetooth-meshd.rst
+	doc/bluetooth-meshd.rst
 	mesh/bluetooth-mesh.service
 	obexd/src/obex.service
 	obexd/src/org.bluez.obex.service
-	src/bluetoothd.rst
+	doc/bluetoothd.rst
 	src/bluetooth.service
 	tools/bluetooth-logger.service
 	tools/mpris-proxy.service
diff --git a/tools/bdaddr.rst b/doc/bdaddr.rst
similarity index 100%
rename from tools/bdaddr.rst
rename to doc/bdaddr.rst
diff --git a/mesh/bluetooth-meshd.rst.in b/doc/bluetooth-meshd.rst.in
similarity index 100%
rename from mesh/bluetooth-meshd.rst.in
rename to doc/bluetooth-meshd.rst.in
diff --git a/client/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
similarity index 100%
rename from client/bluetoothctl-admin.rst
rename to doc/bluetoothctl-admin.rst
diff --git a/client/bluetoothctl-advertise.rst b/doc/bluetoothctl-advertise.rst
similarity index 100%
rename from client/bluetoothctl-advertise.rst
rename to doc/bluetoothctl-advertise.rst
diff --git a/client/bluetoothctl-assistant.rst b/doc/bluetoothctl-assistant.rst
similarity index 100%
rename from client/bluetoothctl-assistant.rst
rename to doc/bluetoothctl-assistant.rst
diff --git a/client/bluetoothctl-bredr.rst b/doc/bluetoothctl-bredr.rst
similarity index 100%
rename from client/bluetoothctl-bredr.rst
rename to doc/bluetoothctl-bredr.rst
diff --git a/client/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
similarity index 100%
rename from client/bluetoothctl-endpoint.rst
rename to doc/bluetoothctl-endpoint.rst
diff --git a/client/bluetoothctl-gatt.rst b/doc/bluetoothctl-gatt.rst
similarity index 100%
rename from client/bluetoothctl-gatt.rst
rename to doc/bluetoothctl-gatt.rst
diff --git a/client/bluetoothctl-hci.rst b/doc/bluetoothctl-hci.rst
similarity index 100%
rename from client/bluetoothctl-hci.rst
rename to doc/bluetoothctl-hci.rst
diff --git a/client/bluetoothctl-le.rst b/doc/bluetoothctl-le.rst
similarity index 100%
rename from client/bluetoothctl-le.rst
rename to doc/bluetoothctl-le.rst
diff --git a/client/bluetoothctl-mgmt.rst b/doc/bluetoothctl-mgmt.rst
similarity index 100%
rename from client/bluetoothctl-mgmt.rst
rename to doc/bluetoothctl-mgmt.rst
diff --git a/client/bluetoothctl-monitor.rst b/doc/bluetoothctl-monitor.rst
similarity index 100%
rename from client/bluetoothctl-monitor.rst
rename to doc/bluetoothctl-monitor.rst
diff --git a/client/bluetoothctl-player.rst b/doc/bluetoothctl-player.rst
similarity index 100%
rename from client/bluetoothctl-player.rst
rename to doc/bluetoothctl-player.rst
diff --git a/client/bluetoothctl-scan.rst b/doc/bluetoothctl-scan.rst
similarity index 100%
rename from client/bluetoothctl-scan.rst
rename to doc/bluetoothctl-scan.rst
diff --git a/client/bluetoothctl-telephony.rst b/doc/bluetoothctl-telephony.rst
similarity index 100%
rename from client/bluetoothctl-telephony.rst
rename to doc/bluetoothctl-telephony.rst
diff --git a/client/bluetoothctl-transport.rst b/doc/bluetoothctl-transport.rst
similarity index 100%
rename from client/bluetoothctl-transport.rst
rename to doc/bluetoothctl-transport.rst
diff --git a/client/bluetoothctl.rst b/doc/bluetoothctl.rst
similarity index 100%
rename from client/bluetoothctl.rst
rename to doc/bluetoothctl.rst
diff --git a/src/bluetoothd.rst.in b/doc/bluetoothd.rst.in
similarity index 100%
rename from src/bluetoothd.rst.in
rename to doc/bluetoothd.rst.in
diff --git a/tools/btattach.rst b/doc/btattach.rst
similarity index 100%
rename from tools/btattach.rst
rename to doc/btattach.rst
diff --git a/tools/btmgmt.rst b/doc/btmgmt.rst
similarity index 100%
rename from tools/btmgmt.rst
rename to doc/btmgmt.rst
diff --git a/monitor/btmon.rst b/doc/btmon.rst
similarity index 100%
rename from monitor/btmon.rst
rename to doc/btmon.rst
diff --git a/tools/ciptool.rst b/doc/ciptool.rst
similarity index 100%
rename from tools/ciptool.rst
rename to doc/ciptool.rst
diff --git a/tools/hciattach.rst b/doc/hciattach.rst
similarity index 100%
rename from tools/hciattach.rst
rename to doc/hciattach.rst
diff --git a/tools/hciconfig.rst b/doc/hciconfig.rst
similarity index 100%
rename from tools/hciconfig.rst
rename to doc/hciconfig.rst
diff --git a/tools/hcidump.rst b/doc/hcidump.rst
similarity index 100%
rename from tools/hcidump.rst
rename to doc/hcidump.rst
diff --git a/tools/hcitool.rst b/doc/hcitool.rst
similarity index 100%
rename from tools/hcitool.rst
rename to doc/hcitool.rst
diff --git a/tools/hid2hci.rst b/doc/hid2hci.rst
similarity index 100%
rename from tools/hid2hci.rst
rename to doc/hid2hci.rst
diff --git a/tools/isotest.rst b/doc/isotest.rst
similarity index 100%
rename from tools/isotest.rst
rename to doc/isotest.rst
diff --git a/tools/l2ping.rst b/doc/l2ping.rst
similarity index 100%
rename from tools/l2ping.rst
rename to doc/l2ping.rst
diff --git a/tools/rctest.rst b/doc/rctest.rst
similarity index 100%
rename from tools/rctest.rst
rename to doc/rctest.rst
diff --git a/tools/rfcomm.rst b/doc/rfcomm.rst
similarity index 100%
rename from tools/rfcomm.rst
rename to doc/rfcomm.rst
diff --git a/tools/sdptool.rst b/doc/sdptool.rst
similarity index 100%
rename from tools/sdptool.rst
rename to doc/sdptool.rst
-- 
2.52.0

