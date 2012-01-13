Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Add Proximity Reporter API
Date: Fri, 13 Jan 2012 17:19:55 -0300
Message-Id: <1326485995-707-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1326143081-30005-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1326143081-30005-2-git-send-email-claudio.takahasi@openbossa.org>
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
 doc/proximity-api.txt |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index cf64bbf..32d6474 100644
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
@@ -52,3 +52,24 @@ Properties
 			"none" will be emitted after the configured timeout.
 			When changing the level, signal is the confirmation
 			that the value was written in the remote.
+
+Proximity Reporter hierarchy
+===========================
+
+Service used by Proximity Path Loss and Find Me. Allows per device
+alert level handling.
+
+Service		org.bluez
+Interface	org.bluez.ProximityReporter
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods
+
+
+Signals		ImmediateAlertLevelChanged(object device, string value)
+
+			This signal indicates that Immediate Alert Level
+			characteristic was changed by the remote device.
+			Values: "none", "mild", "high".
+
+Properties
-- 
1.7.8.1

