Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 24/33] doc: Add Broadcaster D-Bus API documentation
Date: Mon, 27 Aug 2012 13:03:16 -0400
Message-Id: <1346087005-24693-25-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a "high level" API for Broadcaster GAP role.
---
 doc/adapter-api.txt |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 9e2e652..139a1a2 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -224,6 +224,51 @@ Methods		dict GetProperties()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
 
+		void SetServiceData(uint16 uuid, variant data)
+
+			Set Service Data for broadcast. Different applications
+			can register different Adv. data types, and they are
+			all concatenated to form the Adv. data.	Broadcasting is
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
+		void SetManufacturerData(uint16 cid, variant data)
+
+			Set Manufacturer Specific Data for broadcast. Different
+			applications can register different Adv. data types,
+			and they are all concatenated to form the Adv. data.
+			Broadcasting is	enabled as soon as the first
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
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
-- 
1.7.9.5

