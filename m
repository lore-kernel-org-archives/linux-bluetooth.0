Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3] dbusoob: Update API
Date: Mon, 30 Jul 2012 17:32:44 +0200
Message-ID: <1343662364-9595-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1343662364-9595-1-git-send-email-szymon.janc@tieto.com>
References: <1343662364-9595-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update DBus API so that it better matches inquiry result. It can now
also be used only for OOB discovery (hash and randomizer are optional).

Converting to dictionaries make it also easily extendible e.g. to add
support for BLE when proper whitepaper becomes available.
---
 doc/oob-api.txt |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index d838712..4cee91c 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -2,31 +2,84 @@ BlueZ D-Bus Out Of Band Pairing API description
 ===============================================
 
 Copyright (C) 2011  Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+Copyright (C) 2012  Tieto Poland
+
+Currently only Secure Simple Pairing is supported. This might change when white
+paper describing OOB pairing for Bluetooth Low Energy will become available.
+
+Out Of Band hierarchy
+=====================
 
 Service		org.bluez
 Interface	org.bluez.OutOfBand
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
+Methods		dict ReadLocalData()
 
 			This method reads local OOB data from adapter. Return
-			value is pair of arrays 16 bytes each.
+			value is a dictionary. Following keys are possible:
+
+			array{byte} Hash:
+
+					16 bytes hash blob.
+
+			array{byte} Randomizer:
 
-			Note: This method will generate and return new local
-			OOB data.
+					16 bytes randomizer blob.
+
+			Other data that can be transmitted via OOB mechanism
+			can be obtained from org.bluez.Adapter interface.
+
+			Note: This method will generate and return new data
+			every time it is called. Data received in previous
+			calls is invalidated and cannot be used for pairing.
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
+					 org.bluez.Error.NotSupported
 
-		void AddRemoteData(string address, array{byte} hash,
-							array{byte} randomizer)
+		void AddRemoteData(string address, dict data)
 
 			This method adds new Out Of Band data for
 			specified address. If data for specified address
 			already exists it will be overwritten with new one.
 
+			All data is optional.
+
+			On success DeviceFound signal will be emitted.
+
+			possible keys:
+
+				array{byte} Hash:
+
+					16 bytes hash blob, it is used as is
+					so the size and byte order must match.
+
+				array{byte} Randomizer:
+
+					16 bytes randomizer blob, it is used as
+					is so the size and byte order must
+					match. If Randomizer is provided Hash
+					also needs to be provided.
+
+				uint32 Class:
+
+					The Bluetooth class of device of the
+					remote device.
+
+				string Name:
+
+					Remote device name.
+
+				array{string} UUIDs
+
+					List of 128-bit UUIDs that represents
+					the available local services.
+
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyPaired
+					 org.bluez.Error.NotSupported
 
 		void RemoveRemoteData(string address)
 
@@ -36,3 +89,4 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
-- 
1.7.9.5

