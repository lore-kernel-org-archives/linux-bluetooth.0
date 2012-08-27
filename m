Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 14/33] doc: Add Observer D-Bus API documentation
Date: Mon, 27 Aug 2012 13:03:06 -0400
Message-Id: <1346087005-24693-15-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a "high level" API for Observer GAP role.
---
 doc/adapter-api.txt |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 23f0a2f..9e2e652 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -173,6 +173,57 @@ Methods		dict GetProperties()
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+		void RegisterServiceObserver(object observer,
+							uint16 match_value)
+
+			Registers an observer agent to monitor Service Data
+			broadcasts. This agent will be notified whenever a
+			broadcast is received that matches that filter. It is
+			possible use same object path for two observers:
+			Service Data and Manufacturer Specific Data.
+
+			The match_value parameter must be the 16-bit UUID for
+			the service whose data is to be monitored.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void RegisterManufacturerObserver(object observer,
+							uint16 match_value)
+
+			Registers an observer agent to monitor Manufacturer
+			Specific Data broadcasts. This agent will be notified
+			whenever a broadcast is received that matches that
+			filter. It is possible use same object path for two
+			observers: Service Data and Manufacturer Specific Data.
+
+			The match_value parameter must be the 16-bit Company
+			Identifier Code for the manufacturer whose data is to
+			be monitored.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterServiceObserver(object observer)
+
+			Unregisters a Service Data observer. Broadcasts will
+			not be notified to this agent anymore. The observer
+			will be destroyed only if no Manufacturer Specific Data
+			was registered with the same object path.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
+		void UnregisterManufacturerObserver(object observer)
+
+			Unregisters a Manufacturer Specific Data observer.
+			Broadcasts will	not be notified to this agent anymore.
+			The observer will be destroyed only if no Service Data
+			was registered with the same object path.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
@@ -275,3 +326,27 @@ Properties	string Address [readonly]
 
 			List of 128-bit UUIDs that represents the available
 			local services.
+
+Observer hierarchy
+==================
+
+Service		unique name
+Interface	org.bluez.Observer
+Object path	freely definable
+
+Methods		void ServiceReceived(string address, uint16 uuid, variant data)
+
+			This callback gets called when a broadcast data has
+			arrived that matches filter used in
+			RegisterServiceObserver.
+
+			Note: data is a bytearray.
+
+		void ManufacturerReceived(string address, uint16 cid,
+								variant data)
+
+			This callback gets called when a broadcast data has
+			arrived that matches filter used in
+			RegisterManufacturerObserver.
+
+			Note: data is a bytearray.
-- 
1.7.9.5

