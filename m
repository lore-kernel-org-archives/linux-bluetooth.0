Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/4] Sim Access Profile API
Date: Thu, 2 Dec 2010 15:14:21 +0100
Message-ID: <1291299261-26016-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

New API for Sim Access Profile.
---
 Makefile.am     |    2 +-
 doc/sap-api.txt |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)
 create mode 100644 doc/sap-api.txt

diff --git a/Makefile.am b/Makefile.am
index 5f96975..97345a3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -354,7 +354,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/sap-api.txt b/doc/sap-api.txt
new file mode 100644
index 0000000..b8b7253
--- /dev/null
+++ b/doc/sap-api.txt
@@ -0,0 +1,34 @@
+BlueZ D-Bus Sim Access Profile API description
+***********************************
+
+Copyright (C) 2010 ST-Ericsson SA
+
+
+Sim Access Profile hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.SimAccess
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void Disconnect()
+
+			Disconnects SAP client from the server.
+
+			Possible errors: org.bluez.Error.Failed
+
+		dict GetProperties()
+
+			Return all properties for the interface. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.Failed
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean Connected [readonly]
+
+			Indicates if SAP client is connected to the server.
-- 
1.7.0.4
