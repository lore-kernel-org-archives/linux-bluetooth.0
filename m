Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/2] Update the Adapter1 API to match the change to
 ConnectDevice
Date: Tue, 21 Aug 2018 15:37:57 +0000
Message-ID: <BN7PR07MB4305A707230A12C278D4765F9D310@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 2afd61bc3..fe3c86a5a 100644
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
@@ -183,6 +183,12 @@ Methods		void StartDiscovery()
 					"public" - Public address
 					"random" - Random address
=20
+			array{string} UUIDs
+
+				If present, only connect service UUIDs that
+				are both provided by the device and in this
+				list. This parameter is optional.
+
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
 					 org.bluez.Error.NotSupported
--=20
2.17.1
