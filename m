Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 7/8] shared/gatt: Don't incorrectly terminate discovery
Date: Wed, 18 Feb 2015 00:18:38 -0800
Message-Id: <1424247519-21684-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_gatt_client terminates discovery if no primary services are found
within the given range. This behavior is incorrect, as the given
handle range may contain secondary services and those should be
discovered regardless.
---
 src/shared/gatt-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5a3939b..90866df 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -914,7 +914,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 					"Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
-		goto done;
+		goto secondary;
 	}
 
 	if (!result || !bt_gatt_iter_init(&iter, result)) {
@@ -947,6 +947,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		queue_push_tail(op->pending_svcs, attr);
 	}
 
+secondary:
 	/* Discover secondary services */
 	if (bt_gatt_discover_secondary_services(client->att, NULL,
 							op->start, op->end,
-- 
2.2.0.rc0.207.ga3a616c

