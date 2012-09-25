Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/14] thermometer: Update API document
Date: Tue, 25 Sep 2012 16:52:34 +0200
Message-ID: <1348584763-22824-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates Thermometer API document to reflect changes in
Thermometer interface and introduction of ThermometerManager
interface.
---
 doc/thermometer-api.txt | 59 +++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index 2271270..b0b0fe2 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -3,28 +3,14 @@ BlueZ D-Bus Thermometer API description
 
 	Santiago Carot-Nemesio <sancane@gmail.com>
 
-Health Thermometer Profile hierarchy
-=====================================
-
-Service		org.bluez
-Interface	org.bluez.Thermometer
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-
-Methods		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			read-write properties can be changed. On success
-			this will emit a PropertyChanged signal.
+Health Thermometer Manager hierarchy
+============================
 
-			Possible Errors: org.bluez.Error.InvalidArguments
+Service 	org.bluez
+Interface	org.bluez.ThermometerManager
+Object path	[variable prefix]/{hci0,hci1,...}
 
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			Properties section for the available properties.
-
-		RegisterWatcher(object agent)
+Methods 	RegisterWatcher(object agent)
 
 			Registers a watcher to monitor scanned measurements.
 			This agent will be notified about final temperature
@@ -36,30 +22,45 @@ Methods		void SetProperty(string name, variant value)
 
 			Unregisters a watcher.
 
-			Final and intermediate temperatures won't be notified to
-			this agent any more.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-					org.bluez.Error.NotFound
-
 		EnableIntermediateMeasurement(object agent)
 
 			Enables intermediate measurement notifications for this
-			agent if the thermometer supports it.
+			agent. Intermediate measurements will be enabled only
+			for thermometers which support it.
 
 			Possible Errors: org.bluez.Error.InvalidArguments
-					org.bluez.Error.NotSupported
 
 		DisableIntermediateMeasurement(object agent)
 
 			Disables intermediate measurement notifications for this
-			agent. It will disable notifications in the thermometer
+			agent. It will disable notifications in thermometers
 			when the last agent removes the watcher for intermediate
 			measurements.
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 					org.bluez.Error.NotFound
 
+Health Thermometer Profile hierarchy
+=====================================
+
+Service		org.bluez
+Interface	org.bluez.Thermometer
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+
+Methods		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			read-write properties can be changed. On success
+			this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
-- 
1.7.11.3

