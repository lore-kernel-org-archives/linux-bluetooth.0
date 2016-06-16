Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Svehagen <tobias.svehagen@gmail.com>
Subject: [PATCH BlueZ] src/gatt-client: Fix iteration through options
Date: Thu, 16 Jun 2016 15:29:11 +0200
Message-Id: <20160616132913.13138-1-tobias.svehagen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix infinite loop when trying to read/write a characteristic or
a descriptor and the ReadValue/WriteValue call has at least one
option.
---
 src/gatt-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 0cbacca..6fc0d19 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -401,6 +401,8 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, offset);
 		}
+
+		dbus_message_iter_next(&dict);
 	}
 
 	return 0;
-- 
2.8.3

