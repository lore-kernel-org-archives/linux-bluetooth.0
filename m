Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools: Remove simple-service
Date: Mon, 14 Apr 2014 15:40:01 +0300
Message-Id: <1397479202-3632-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

simple-service no longer works since the API it uses no longer exists and
Profile API already has a similar tool.
---
 test/simple-service | 128 ----------------------------------------------------
 1 file changed, 128 deletions(-)
 delete mode 100755 test/simple-service

diff --git a/test/simple-service b/test/simple-service
deleted file mode 100755
index 02d7648..0000000
--- a/test/simple-service
+++ /dev/null
@@ -1,128 +0,0 @@
-#!/usr/bin/python
-
-from __future__ import absolute_import, print_function, unicode_literals
-
-import sys
-import time
-import dbus
-import bluezutils
-
-xml = ' \
-<?xml version="1.0" encoding="UTF-8" ?> 	\
-<record>					\
-  <attribute id="0x0001">			\
-    <sequence>					\
-      <uuid value="0x1101"/>			\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x0002">			\
-     <uint32 value="0"/>			\
-  </attribute>					\
-						\
-  <attribute id="0x0003">			\
-    <uuid value="00001101-0000-1000-8000-00805f9b34fb"/> \
-  </attribute>					\
-						\
-  <attribute id="0x0004">			\
-    <sequence>					\
-      <sequence>				\
-        <uuid value="0x0100"/>			\
-      </sequence>				\
-      <sequence>				\
-        <uuid value="0x0003"/>			\
-        <uint8 value="23"/>			\
-      </sequence>				\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x0005">			\
-    <sequence>					\
-      <uuid value="0x1002"/>			\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x0006">			\
-    <sequence>					\
-      <uint16 value="0x656e"/>			\
-      <uint16 value="0x006a"/>			\
-      <uint16 value="0x0100"/>			\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x0007">			\
-     <uint32 value="0"/>			\
-  </attribute>					\
-						\
-  <attribute id="0x0008">			\
-     <uint8 value="0xff"/>			\
-  </attribute>					\
-						\
-  <attribute id="0x0009">			\
-    <sequence>					\
-      <sequence>				\
-        <uuid value="0x1101"/>			\
-        <uint16 value="0x0100"/>		\
-      </sequence>				\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x000a">			\
-    <url value="http://www.bluez.org/"/>	\
-  </attribute>					\
-						\
-  <attribute id="0x000b">			\
-    <url value="http://www.bluez.org/"/>	\
-  </attribute>					\
-						\
-  <attribute id="0x000c">			\
-    <url value="http://www.bluez.org/"/>	\
-  </attribute>					\
-						\
-  <attribute id="0x0100">			\
-    <text value="Serial Port"/>			\
-  </attribute>					\
-						\
-  <attribute id="0x0101">			\
-    <text value="Serial Port Service"/>		\
-  </attribute>					\
-						\
-  <attribute id="0x0102">			\
-     <text value="BlueZ"/>			\
-  </attribute>					\
-						\
-  <attribute id="0x0200">			\
-    <sequence>					\
-      <uint16 value="0x0100"/>			\
-    </sequence>					\
-  </attribute>					\
-						\
-  <attribute id="0x0201">			\
-     <uint32 value="0"/>			\
-  </attribute>					\
-</record>					\
-'
-
-bus = dbus.SystemBus()
-
-if len(sys.argv) > 1:
-	path = bluezutils.find_adapter(sys.argv[1]).object_path
-else:
-	path = bluezutils.find_adapter().object_path
-
-service = dbus.Interface(bus.get_object("org.bluez", path),
-						"org.bluez.Service")
-
-handle = service.AddRecord(xml)
-
-print("Service record with handle 0x%04x added" % (handle))
-
-print("Press CTRL-C to remove service record")
-
-try:
-	time.sleep(1000)
-	print("Terminating session")
-except:
-	pass
-
-service.RemoveRecord(dbus.UInt32(handle))
-- 
1.9.0

