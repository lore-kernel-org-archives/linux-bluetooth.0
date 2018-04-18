Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/7] doc/device-api: Add AdvertisingData property
Date: Wed, 18 Apr 2018 14:04:57 +0300
Message-Id: <20180418110502.13099-2-luiz.dentz@gmail.com>
In-Reply-To: <20180418110502.13099-1-luiz.dentz@gmail.com>
References: <20180418110502.13099-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds AdvertisingData which exposes data being advertised which is
may be useful for profiles not handled by bluetoothd.
---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1b448eef1..f2f8464bc 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -251,3 +251,8 @@ Properties	string Address [readonly]
 		array{byte} AdvertisingFlags [readonly, experimental]
 
 			The Advertising Data Flags of the remote device.
+
+		dict AdvertisingData [readonly, experimental]
+
+			The Advertising Data of the remote device. Keys are
+			are 8 bits AD Type followed by data as byte array.
-- 
2.14.3

