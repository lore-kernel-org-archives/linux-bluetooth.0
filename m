Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] Update the Adapter1 API to match the change to
 ConnectDevice
Date: Thu, 16 Aug 2018 20:29:43 +0000
Message-ID: <BN7PR07MB4305C4EE248EACC3F5F262889D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 2afd61bc3..918153f68 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -158,11 +158,11 @@ Methods		void StartDiscovery()
 			similar to Connect method from Device1 interface with
 			exception that this method returns success when physical
 			connection is established. After this method returns,
-			services discovery will continue and any supported
-			profile will be connected. There is no need for calling
-			Connect on Device1 after this call. If connection was
-			successful this method returns object path to created
-			device object.
+			services discovery will continue.
+
+			There is no need for calling Connect on Device1 after
+			this call. If connection was successful this method
+			returns object path to created device object.
=20
 			Parameters that may be set in the filter dictionary
 			include the following:
@@ -189,6 +189,11 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
=20
+		boolean ConnectAllProfiles
+
+			If set to true, any supported profile will be
+			connected. This parameter is optional.
+
 Properties	string Address [readonly]
=20
 			The Bluetooth device address.
--=20
2.17.1
