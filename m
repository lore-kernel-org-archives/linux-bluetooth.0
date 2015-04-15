Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] doc/device-api: Add ServiceData and ManufacturerData
Date: Wed, 15 Apr 2015 14:44:18 +0300
Message-Id: <1429098268-9695-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ServiceData and ManufacturerData from advertisement data.
---
 doc/device-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index eec0024..72c597e 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -195,3 +195,14 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
+
+		dict ManufacturerData [readonly, optional]
+
+			Manufacturer specific advertisement data. Keys are
+			16 bits Manufacturer ID followed by its byte array
+			value.
+
+		dict ServiceData [readonly, optional]
+
+			Service advertisement data. Keys are the UUIDs in
+			string format followed by its byte array value.
-- 
2.1.0

