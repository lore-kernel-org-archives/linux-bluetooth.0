Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v1 10/13] doc: Add API documentation for org.bluez.Service1
Date: Thu,  6 Jun 2013 10:21:42 +0200
Message-Id: <1370506905-19641-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1370506905-19641-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1370506905-19641-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Update the documentation to reflect the newly adopted D-Bus API.
---
 Makefile.am         |  2 +-
 doc/service-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 doc/service-api.txt

diff --git a/Makefile.am b/Makefile.am
index 9d570fb..abab329 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,7 +199,7 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
-		doc/agent-api.txt doc/profile-api.txt \
+		doc/agent-api.txt doc/profile-api.txt doc/service-api.txt \
 		doc/network-api.txt doc/media-api.txt \
 		doc/health-api.txt doc/sap-api.txt
 
diff --git a/doc/service-api.txt b/doc/service-api.txt
new file mode 100644
index 0000000..72b2369
--- /dev/null
+++ b/doc/service-api.txt
@@ -0,0 +1,52 @@
+BlueZ D-Bus Service API description
+***********************************
+
+Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
+
+
+Service hierarchy
+=================
+
+Service		unique name
+Interface	org.bluez.Service1 [Experimental]
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
+								serviceZZZ
+
+Methods		void Connect()
+
+			This method connects a specific service of this
+			device.
+
+			Possible errors: org.bluez.Error.AgentNotAvailable
+					 org.bluez.Error.AlreadyConnected
+					 org.bluez.Error.Canceled
+					 org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+
+		void Disconnect()
+
+			This method disconnects a specific service of this
+			device.
+
+			There is no connection tracking for a service, so
+			as long as the service is registered this will always
+			succeed.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.NotConnected
+
+Properties	object Device [readonly]
+
+			The object path of the device the service belongs to.
+
+		string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected"
+				"connected"
+
+		string UUID [readonly]
+
+			128-bit UUID that representing the remote service.
-- 
1.8.1.4

