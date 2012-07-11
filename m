Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] doc: Mention GATT when creating devices
Date: Wed, 11 Jul 2012 15:03:43 -0300
Message-Id: <1342029823-2854-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CreatePairedDevice and CreateDevice trigger GATT discover all primary
services procedure if the device is Bluetooth Low Energy.
---
 doc/adapter-api.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 9d7f284..fb8c2e8 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -92,7 +92,7 @@ Methods		dict GetProperties()
 
 			Creates a new object path for a remote device. This
 			method will connect to the remote device and retrieve
-			all SDP records.
+			all SDP records (or GATT primary services).
 
 			If the object for the remote device already exists
 			this method will fail.
@@ -105,7 +105,8 @@ Methods		dict GetProperties()
 
 			Creates a new object path for a remote device. This
 			method will connect to the remote device and retrieve
-			all SDP records and then initiate the pairing.
+			all SDP records (or GATT primary services) and then
+			initiate the pairing.
 
 			If previously CreateDevice was used successfully,
 			this method will only initiate the pairing.
-- 
1.7.8.6

