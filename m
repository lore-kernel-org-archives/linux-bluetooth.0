Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ] Add Proximity Reporter interface - Proposal 1
Date: Mon,  9 Jan 2012 18:04:40 -0300
Message-Id: <1326143081-30005-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds API for Immediate Alert Service(IAS) abstraction. Abstraction for
Link Loss is not planned. IAS is used by Proximity Monitors and Find
Me Locators to notify the user that the device(or key fob) has been
found. This new interface combines Proximity Reporter and Find Me
Target in the same API providing the flexibility to implement external
applications to control the alerts(including per device alerts).

This abstraction allows the development of platform specific
applications to control Immediate Alert coming from Proximity Monitor
and Find Me Locator. This provides flexibility to define different level
and tone for each known device.

--
Alternatively, ImmediateAlertChanged signal containing device object
path and the alert level could be exposed avoiding the device object
path in the Proximity Reporter hierarchy. For this case Adapter object
path should be used. Use the Adapter object path makes more difficult
to track alert level changes related to a given device, on other hand
it is more aligned with the current BR/EDR APIs.
---
 doc/proximity-api.txt |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index cf64bbf..10f4fa6 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -4,8 +4,8 @@ BlueZ D-Bus Proximity API description
 Copyright (C) 2011  Claudio Takahasi <claudio.takahasi@openbossa.org>
 
 
-Proximity hierarchy
-=================
+Proximity Monitor hierarchy
+===========================
 
 Service		org.bluez
 Interface	org.bluez.ProximityMonitor
@@ -52,3 +52,32 @@ Properties
 			"none" will be emitted after the configured timeout.
 			When changing the level, signal is the confirmation
 			that the value was written in the remote.
+
+Proximity Reporter hierarchy
+===========================
+
+Shared service used by Proximity Path Loss and Find Me. Allows per device
+alert level handling.
+
+Service		org.bluez
+Interface	org.bluez.ProximityReporter
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of a given
+			property.
+
+Properties
+
+		string ImmediateAlertLevel [readonly]
+
+			New Immediate Alert Level Characteristic value
+			has been written by the remote device. Property
+			shared between Path Loss and Find Me. Values:
+			"none", "mild", "high". Default value is "none".
-- 
1.7.8.1

