Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Svehagen <tobias.svehagen@gmail.com>
Subject: [PATCH BlueZ 1/2] tools/gatt-service: Fix iteration through options
Date: Thu, 16 Jun 2016 15:29:12 +0200
Message-Id: <20160616132913.13138-2-tobias.svehagen@gmail.com>
In-Reply-To: <20160616132913.13138-1-tobias.svehagen@gmail.com>
References: <20160616132913.13138-1-tobias.svehagen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes an infinite loop when trying to read a descriptor and the
ReadValue call has at least one option.
---
 tools/gatt-service.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 0c78c4d..1cf8b3c 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -407,6 +407,8 @@ static int parse_options(DBusMessageIter *iter, const char **device)
 			dbus_message_iter_get_basic(&value, device);
 			printf("Device: %s\n", *device);
 		}
+
+		dbus_message_iter_next(&dict);
 	}
 
 	return 0;
-- 
2.8.3

