Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: ortuno@google.com, Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ] doc/device-api: Add GattServices
Date: Mon,  4 May 2015 16:57:30 -0700
Message-Id: <1430783850-21140-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the GattServices property that contains the object
paths of exported GattService1 objects. The purpose of this property is
to signal when all GATT services on a remote device have been
discovered.
---
 doc/device-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 20d6c65..a8076a2 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -211,3 +211,11 @@ Properties	string Address [readonly]
 
 			Service advertisement data. Keys are the UUIDs in
 			string format followed by its byte array value.
+
+		array{object} GattServices [readonly, optional]
+
+			List of GATT service object paths. Each referenced
+			object exports the org.bluez.GattService1 interface and
+			represents a remote GATT service. This property will be
+			updated once all remote GATT services of this device
+			have been discovered and exported over D-Bus.
-- 
2.2.0.rc0.207.ga3a616c

