Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 09/15] GATT server: add test/test-gatt-profile example
Date: Wed, 16 Mar 2011 21:00:33 -0400
Message-Id: <1300323639-13296-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This script registers an example GATT profile, replacing the old
built-in example server (attrib/example.c).
---
 test/test-gatt-profile |   80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 test/test-gatt-profile

diff --git a/test/test-gatt-profile b/test/test-gatt-profile
new file mode 100755
index 0000000..7234cd1
--- /dev/null
+++ b/test/test-gatt-profile
@@ -0,0 +1,80 @@
+#!/usr/bin/python
+import dbus
+import dbus.mainloop.glib
+import gobject
+
+profile = """
+<?xml version="1.0" encoding="UTF-8" ?>
+<gatt-profile>
+
+<!-- Battery state service -->
+<primary-service uuid="0xA002">
+<characteristic properties="0x12" uuid="0xA003" value="04"/>
+</primary-service>
+
+<!-- Thermometer service -->
+<primary-service uuid="0xA004">
+<include id="manufacturer1"/>
+<include id="vendor-specific"/>
+
+<characteristic properties="0x02" uuid="0xA006" value="8A02">
+<presentation format="0x0E" exponent="-2" unit="0x272F" namespace="0x01" description="0xA008"/>
+<user-description value="Outside Temperature"/>
+</characteristic>
+
+<characteristic properties="0x02" uuid="0xA009" value="27">
+<presentation format="0x04" exponent="0" unit="0x27AD" namespace="0x01" description="0xA008"/>
+<user-description value="Outside Relative Humidity"/>
+</characteristic>
+</primary-service>
+
+<!-- Manufacturer1 service -->
+<secondary-service id="manufacturer1" uuid="0xA005">
+<characteristic properties="0x02" uuid="0xA00C" value="41434D452054656D70657261747572652053656E736F7200"/>
+<characteristic properties="0x02" uuid="0xA00D" value="3233373439352D333238322D4100"/>
+</secondary-service>
+
+<!-- Manufacturer2 service -->
+<secondary-service id="manufacturer2" uuid="0xA005">
+<characteristic properties="0x02" uuid="0xA00C" value="41434D45205765696768696E67205363616C657300"/>
+<characteristic properties="0x02" uuid="0xA00D" value="31313236372D3233323741303032333900"/>
+</secondary-service>
+
+<!-- Vendor specific service -->
+<secondary-service id="vendor-specific" uuid="0xA00E">
+<characteristic properties="0x02" uuid="0xA00F" value="56656E646F72"/>
+</secondary-service>
+
+<!-- Weight service -->
+<primary-service uuid="4f0ac096-35d4-4911-9631-dea8dc74eefe">
+<include id="manufacturer2"/>
+
+<characteristic properties="0x02" uuid="8088f218-902c-450b-b6c4-62891e8c25e9" value="82550000">
+<presentation format="0x08" exponent="-3" unit="0x2702" namespace="0x01" description="0xA011"/>
+<user-description value="Rucksack Weight"/>
+</characteristic>
+</primary-service>
+
+<!-- for aggregates (not supported yet):
+<presentation id="p1" .../>
+<presentation id="p2" .../>
+<aggregate>
+<presentation id="p1"/>
+<presentation id="p2"/>
+</aggregate>
+-->
+
+</gatt-profile>
+"""
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+bus = dbus.SystemBus()
+manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+adapter_path = manager.DefaultAdapter()
+
+gatt_profile = dbus.Interface(bus.get_object("org.bluez", adapter_path), "org.bluez.GattProfile")
+gatt_profile.AddProfile(profile)
+
+mainloop = gobject.MainLoop()
+mainloop.run()
-- 
1.7.0.4

