Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ] Add Proximity Reporter interface - Proposal 2
Date: Mon,  9 Jan 2012 18:04:41 -0300
Message-Id: <1326143081-30005-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1326143081-30005-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1326143081-30005-1-git-send-email-claudio.takahasi@openbossa.org>
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
and tone for each device.
---
 doc/proximity-api.txt |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index cf64bbf..c825fc7 100644
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
+Shared service used by Proximity Path Loss and Find Me. Allows per device
+alert level handling.
+
+Service		org.bluez
+Interface	org.bluez.ProximityReporter
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods
+
+
+Signals		ImmediateAlertChanged(object device, string value)
+
+			This signal indicates that Immediate Alert Level
+			characteristic was changed by the remote device.
+			Values: "none", "mild", "high".
+
+Properties
-- 
1.7.8.1

