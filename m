Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/4] gatt: Add org.bluez.Error.InvalidOffset for long read procedure
Date: Tue, 20 Mar 2018 15:05:17 +0100
Message-Id: <20180320140519.6285-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180320140519.6285-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180320140519.6285-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of invalid offset error for gatt database in
case if offset in read blob would be invalid.

"The Read Blob Request is repeated until the Read Blob Response’s Part
Attribute Value parameter is zero or an Error Response is sent by the server
with the Error Code set to Invalid Offset." Bluetooth Core 5.0, 4.12.2

"If the prepare Value Offset is greater than the current length of the attribute
value then all pending prepare write values shall be discarded for this client,
the queue shall be cleared and then an Error Response shall be sent with the
«Invalid Offset»." Bluetooth Core 5.0, 3.4.6.3
---
 doc/gatt-api.txt    | 1 +
 src/gatt-database.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 9579381a5..f58de23c3 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -74,6 +74,7 @@ Methods		array{byte} ReadValue(dict options)
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
+					 org.bluez.Error.InvalidOffset
 					 org.bluez.Error.NotSupported
 
 		void WriteValue(array{byte} value, dict options)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1903e08fd..ce0e03f0f 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1692,6 +1692,9 @@ static uint8_t dbus_error_to_att_ecode(const char *error_name)
 	if (strcmp(error_name, "org.bluez.Error.InvalidValueLength") == 0)
 		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 
+	if (strcmp(error_name, "org.bluez.Error.InvalidOffset") == 0)
+		return BT_ATT_ERROR_INVALID_OFFSET;
+
 	if (strcmp(error_name, "org.bluez.Error.InProgress") == 0)
 		return BT_ERROR_ALREADY_IN_PROGRESS;
 
-- 
2.13.6

