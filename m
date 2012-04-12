Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC PATCH BlueZ] doc: Document Broadcaster/Observer API
Date: Wed, 11 Apr 2012 21:04:28 -0400
Message-Id: <1334192668-21433-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 20cef03..67f9f62 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -181,6 +181,48 @@ Methods		dict GetProperties()
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+		void RegisterBroadcaster(dict values)
+
+			Set Advertising data for broadcast. Different
+			applications can register different Adv. data types,
+			and they are all concatenated to form the Adv. data.
+			Broadcasting is enabled as soon as the first
+			RegisterBroadcaster() call is made.
+
+			Use UnregisterBroadcaster() to release Adv. data for
+			the application. Advertising data is also released when
+			application exits, and once the last Broadcaster exits,
+			advertising is disabled.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
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
+		void RegisterObserver(object agent, array{byte} data_types)
+
+			Registers an observer agent to monitor broadcasts. This
+			agent will be notified whenever a broadcast is received
+			that contains any of selected Advertising data types.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+
+		void UnregisterObserver(object agent)
+
+			Unregisters an observer. Broadcasts will not be
+			notified to this agent anymore.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
@@ -284,3 +326,17 @@ Properties	string Address [readonly]
 
 			List of 128-bit UUIDs that represents the available
 			local services.
+
+
+Observer hierarchy
+==================
+
+Service		unique name
+Interface	org.bluez.Observer
+Object path	freely definable
+
+Methods		void BroadcastReceived(string address, byte data_type,
+								variant value)
+
+			This callback gets called when a broadcast data has
+			arrived with selected Advertising Data type.
-- 
1.7.5.4

