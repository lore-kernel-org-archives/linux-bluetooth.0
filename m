Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 10/25] doc: Add Broadcaster/Observer D-Bus API documentation
Date: Fri, 21 Dec 2012 16:26:37 -0400
Message-Id: <1356121612-15172-11-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 62c7a27..e8ca305 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -43,6 +43,102 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
 
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
+			Broadcasts will not be notified to this agent anymore.
+			The observer will be destroyed only if no Service Data
+			was registered with the same object path.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
+		void SetServiceData(uint16 uuid, array{byte} data)
+
+			Set Service Data for broadcast. Different applications
+			can register different Adv. data types, and they are
+			all concatenated to form the Adv. data. Broadcasting is
+			enabled as soon as the first SetServiceData() call is
+			made.
+
+			This method can be used to update service data already
+			being broadcasted.
+
+			Use ClearBroadcastData() to release any Adv. data for
+			the application. Advertising data is also released when
+			application exits, and once the last Broadcaster exits,
+			advertising is disabled.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void SetManufacturerData(uint16 cid, array{byte} data)
+
+			Set Manufacturer Specific Data for broadcast. Different
+			applications can register different Adv. data types,
+			and they are all concatenated to form the Adv. data.
+			Broadcasting is enabled as soon as the first
+			SetManufacturerData() call is made.
+
+			This method can be used to update manufacturer data
+			already being broadcasted.
+
+			Use ClearBroadcastData() to release any Adv. data for
+			the application. Advertising data is also released when
+			application exits, and once the last Broadcaster exits,
+			advertising is disabled.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void ClearBroadcastData()
+
+			This method will release any previously set Advertising
+			data.
+
+			Possible errors: org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
@@ -118,3 +214,24 @@ Properties	string Address [readonly]
 
 			List of 128-bit UUIDs that represents the available
 			local services.
+
+Observer hierarchy
+==================
+
+Service		unique name
+Interface	org.bluez.Observer1
+Object path	freely definable
+
+Methods		void ServiceReceived(string address, uint16 uuid,
+							array{byte} data)
+
+			This callback gets called when a broadcast data has
+			arrived that matches filter used in
+			RegisterServiceObserver.
+
+		void ManufacturerReceived(string address, uint16 cid,
+							array{byte} data)
+
+			This callback gets called when a broadcast data has
+			arrived that matches filter used in
+			RegisterManufacturerObserver.
-- 
1.7.9.5

