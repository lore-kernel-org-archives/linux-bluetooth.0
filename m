Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, <suraj@atheros.com>, Waldemar
 Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/4] Sim Access Profile API
Date: Wed, 20 Oct 2010 14:11:18 +0200
Message-ID: <1287576681-12669-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

New API for Sim Access Profile.
---
 Makefile.am     |    2 +-
 doc/sap-api.txt |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)
 create mode 100644 doc/sap-api.txt

diff --git a/Makefile.am b/Makefile.am
index 6e8fc7d..eeb1780 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -352,7 +352,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/sap-api.txt b/doc/sap-api.txt
new file mode 100644
index 0000000..7951f56
--- /dev/null
+++ b/doc/sap-api.txt
@@ -0,0 +1,57 @@
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
+Methods		void Enable()
+
+			Start up SAP server and register SDP record for it.
+
+			Possible errors: org.bluez.Error.Failed
+
+		void Disable()
+
+			Shudown SAP server and remove the SDP record.
+
+			Possible errors: org.bluez.Error.Failed
+
+		void Disconnect(boolean type)
+
+			Disconnect SAP client from the server. The 'type'
+			parameter indicates disconnection type.
+
+			True  - gracefull disconnection
+			False - immediate disconnection
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
+
+Properties	boolean Enabled [readonly]
+
+				Indicates the state of the server. True if the server
+				is enabled and False otherwise.
+
+			boolean Connected [readonly]
+
+				Indicates if SAP client is connected to the server.
+
-- 
1.7.0.4
