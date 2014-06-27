Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <scott@netsplit.com>
Subject: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
Date: Fri, 27 Jun 2014 12:16:29 -0700
Message-Id: <1403896589-6135-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes an extension to the D-Bus Adapter API to permit
the application to specify whether it wishes to discover BR/EDR
or LE devices.

Rationale is to permit an application, only interested in an LE device
with intent on using GATT to not cause the large power drain of
performing BR/EDR Inquiry.
---
 doc/adapter-api.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..668644d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -22,6 +22,29 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		void StartDiscoveryWithOptions(dict options)
+
+			This method starts the device discovery session, as
+			StartDiscovery(), but lets the client specify
+			additional options. Use StopDiscovery to release the
+			sessions acquired.
+
+			possible options:
+
+				boolean Classic:
+
+					Specifies whether discovery of BR/EDR
+					devices should be performed.
+
+				boolean LowEnergy:
+
+					Specifies whether discovery of LE
+					devices should be performed.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
+
 		void StopDiscovery()
 
 			This method will cancel any previous StartDiscovery
-- 
1.9.3 (Apple Git-50)

