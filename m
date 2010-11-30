Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/2] Sim Access Profile API
Date: Tue, 30 Nov 2010 11:36:04 +0100
Message-ID: <1291113364-6401-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1291113364-6401-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1291113364-6401-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

New API for Sim Access Profile.
---
 Makefile.am     |    2 +-
 doc/sap-api.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletions(-)
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
index 0000000..4e5626e
--- /dev/null
+++ b/doc/sap-api.txt
@@ -0,0 +1,47 @@
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
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed a read-write are changeable.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
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
+Properties	boolean Enabled [readwrite]
+
+			Set to true to start-up SAP server and register SDP record for
+			it. Set to false to shutdown SAP server and remove the SDP record.
+
+		boolean Connected [readonly]
+
+			Indicates if SAP client is connected to the server.
-- 
1.7.0.4
