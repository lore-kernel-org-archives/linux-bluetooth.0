Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] doc/device-api: Add AdvertisingData property
Date: Thu, 19 Apr 2018 16:46:25 +0300
Message-Id: <20180419134630.15624-2-luiz.dentz@gmail.com>
In-Reply-To: <20180419134630.15624-1-luiz.dentz@gmail.com>
References: <20180419134630.15624-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds AdvertisingData which exposes data being advertised which is
may be useful for profiles not handled by bluetoothd.
---
 doc/device-api.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1b448eef1..65d8fee37 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -251,3 +251,19 @@ Properties	string Address [readonly]
 		array{byte} AdvertisingFlags [readonly, experimental]
 
 			The Advertising Data Flags of the remote device.
+
+		dict AdvertisingData [readonly, experimental]
+
+			The Advertising Data of the remote device. Keys are
+			are 8 bits AD Type followed by data as byte array.
+
+			Note: Only types considered safe to be handled by
+			application are exposed.
+
+			Possible values:
+				<type> <byte array>
+				...
+
+			Example:
+				<Transport Discovery> <Organization Flags...>
+				0x26                   0x01         0x01...
-- 
2.14.3

