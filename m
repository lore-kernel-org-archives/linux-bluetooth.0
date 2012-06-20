Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 1/5] doc: Add Observer and Broadcaster DBus API documentation
Date: Wed, 20 Jun 2012 14:05:14 -0400
Message-Id: <1340215518-6694-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a "high level" API for Observer and Broadcaster GAP roles.
---
 doc/adapter-api.txt | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index dccb6bf..8d026e3 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -182,6 +182,77 @@ Methods		dict GetProperties()
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+		void RegisterObserver(object agent, string filter_name,
+							variant filter_value)
+
+			Registers an observer agent to monitor broadcasts. This
+			agent will be notified whenever a broadcast is received
+			that matches that filter.
+
+			Valid keys for filter_name:
+
+			"ServiceUUID" = UUID possible for Service Data
+			"CompanyIdentifierCode" = Company Identifier possible
+						for Manufacturer Specific Data.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterObserver(object agent)
+
+			Unregisters an observer. Broadcasts will not be
+			notified to this agent anymore.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
+		void RegisterBroadcaster(string field_name, dict values)
+
+			Set Advertising data for broadcast. Different
+			applications can register different Adv. data types,
+			and they are all concatenated to form the Adv. data.
+			Broadcasting is enabled as soon as the first
+			RegisterBroadcaster() call is made.
+
+			The parameter values depends on field_name parameter.
+			So, for field_name there are these valid values:
+
+			"ServiceData" = those keys are valid:
+				"ServiceUUID" = an uint16 of Service UUID
+				"Data" = a byte array of Service Data
+			"ManufacturerSpecificData" = those keys are valid:
+				"CompanyIdentifierCode" = an uint16 of Company
+							  Identifier
+				"Data" = a byte array of Manufacturer Specific
+					 Data
+
+			Use UnregisterBroadcaster() to release Adv. data for
+			the application. Advertising data is also released when
+			application exits, and once the last Broadcaster exits,
+			advertising is disabled.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void UpdateBroadcastData(string field_name, dict values)
+
+			Replace Advertising data for broadcast. This method can
+			only be called after RegisterBroadcaster().
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void UnregisterBroadcaster()
+
+			This method will release any previously set Advertising
+			data.
+
+			Note that a broadcast procedure is shared between all
+			sessions, thus calling UnregisterBroadcaster() will
+			only release a single session.
+
+			Possible errors: org.bluez.Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
@@ -277,6 +348,14 @@ Properties	string Address [readonly]
 
 			Indicates that a device discovery procedure is active.
 
+		boolean Observing [readonly]
+
+			Indicates that an observation procedure is active.
+
+		boolean Broadcasting [readonly]
+
+			Indicates that a broadcast procedure is active.
+
 		array{object} Devices [readonly]
 
 			List of device object paths.
@@ -285,3 +364,17 @@ Properties	string Address [readonly]
 
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
+Methods		void BroadcastReceived(string address, dict values)
+
+			This callback gets called when a broadcast data has
+			arrived that matches filter used in RegisterObserver.
+
+			The parameter values has all fields of Adv. matched.
-- 
1.7.11

