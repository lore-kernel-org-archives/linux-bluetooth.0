Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix memory leak of unused EIR name
Date: Mon, 20 Dec 2010 09:38:15 -0400
Message-Id: <1292852295-11104-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a code path in btd_event_device_found() where the EIR name is
not used. This requires freeing eir_data.name to avoid a leak.

Additionally, an incorrect use of free() is replaced with g_free().
---
 src/event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index 3603643..0c11da7 100644
--- a/src/event.c
+++ b/src/event.c
@@ -527,6 +527,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	/* if found: don't send the name again */
 	dev = adapter_search_found_devices(adapter, &match);
 	if (dev) {
+		g_free(eir_data.name);
 		adapter_update_found_devices(adapter, peer, rssi, class,
 						NULL, NULL, dev->legacy,
 						eir_data.services,
@@ -570,7 +571,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 			name = eir_data.name;
 		} else {
 			if (name)
-				free(eir_data.name);
+				g_free(eir_data.name);
 			else
 				name = eir_data.name;
 		}
-- 
1.7.0.4

