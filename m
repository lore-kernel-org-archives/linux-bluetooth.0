Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Add Link Loss Alert for Proximity Reporter API
Date: Fri, 13 Jan 2012 17:20:16 -0300
Message-Id: <1326486016-755-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LinkLossAlertLevelChanged signal is emitted when a given remote device
writes a new value for the Alert Level characteristic. Each platform
is free to define the actions for the detected signal.
---
 doc/proximity-api.txt |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index 32d6474..3666067 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -56,8 +56,7 @@ Properties
 Proximity Reporter hierarchy
 ===========================
 
-Service used by Proximity Path Loss and Find Me. Allows per device
-alert level handling.
+Service used by Proximity and Find Me. Allows per device alert level handling.
 
 Service		org.bluez
 Interface	org.bluez.ProximityReporter
@@ -72,4 +71,10 @@ Signals		ImmediateAlertLevelChanged(object device, string value)
 			characteristic was changed by the remote device.
 			Values: "none", "mild", "high".
 
+		LinkLossAlertLevelChanged(object device, string value)
+
+			This signal indicates that Alert Level characteristic
+			of the Link Loss service was changed by the remote
+			device. Values: "none", "mild", "high".
+
 Properties
-- 
1.7.8.1

