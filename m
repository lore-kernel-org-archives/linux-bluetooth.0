Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Add Proximity Reporter API
Date: Thu, 19 Jan 2012 15:36:59 -0300
Message-Id: <1326998219-2255-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBfCGV8GjzVdJ-UKRZOuKRZ_ftijCwJ_DRuRssac7+yYiw@mail.gmail.com>
References: <CAKT1EBfCGV8GjzVdJ-UKRZOuKRZ_ftijCwJ_DRuRssac7+yYiw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds API for Immediate Alert Service(IAS) abstraction. IAS is used
by Proximity Monitors and Find Me Locators to notify the user that
reporter/target has been found. This new interface combines Proximity
Reporter and Find Me Target in the same API providing the flexibility
to implement external applications to control alerts(including per
device alerts).

This abstraction allows the development of platform specific
applications to control Immediate Alert coming from Proximity Monitor
and Find Me Locator. This provides flexibility to define different level
and tone for each device. Use case: watch finding a mobile phone.
---
 doc/proximity-api.txt |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index cf64bbf..3e49149 100644
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
@@ -52,3 +52,33 @@ Properties
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
+			This property indicates that Immediate Alert Level
+			characteristic in the local Immediate Alert Service
+			was changed by the remote device. Property shared
+			between Path Loss and Find Me. Values: "none", "mild",
+			"high".
-- 
1.7.8.1

