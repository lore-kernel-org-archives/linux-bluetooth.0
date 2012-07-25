Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] dbusoob: Update API
Date: Wed, 25 Jul 2012 16:25:08 +0200
Message-ID: <1343226308-443-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1343226308-443-1-git-send-email-szymon.janc@tieto.com>
References: <1343226308-443-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/oob-api.txt |   57 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index d838712..8b7b633 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -7,26 +7,71 @@ Service		org.bluez
 Interface	org.bluez.OutOfBand
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
+Methods		dict ReadLocalData()
 
 			This method reads local OOB data from adapter. Return
-			value is pair of arrays 16 bytes each.
+			value is a dictionary with following keys:
 
-			Note: This method will generate and return new local
-			OOB data.
+			array{byte} Hash:
+
+					16 bytes hash blob.
+
+			array{byte} Randomizer:
+
+					16 bytes randomizer blob.
+
+			Other data that can be transmitted via OOB mechanism
+			can be obtained from org.bluez.Adapter interface.
+
+			Note: This method will generate and return new hash
+			and randomizer every time it is called. Data
+			received in previous calls is invalidated and cannot be
+			used for pairing.
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 
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
 
 		void RemoveRemoteData(string address)
 
-- 
1.7.9.5

