Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/4] Use stored device name (if any) instead of EIR data
Date: Mon, 27 Dec 2010 09:21:06 -0400
Message-Id: <1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The stored device name comes from either name resolution or from a
"complete" EIR name. If available, use it and ignore any further name
present on EIR data.
---
 src/event.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/src/event.c b/src/event.c
index 6598e37..f445dd1 100644
--- a/src/event.c
+++ b/src/event.c
@@ -549,22 +549,14 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else
 		legacy = TRUE;
 
-	if (eir_data.name) {
+	if (name == NULL && eir_data.name != NULL) {
 		if (eir_data.name_complete) {
 			write_device_name(local, peer, eir_data.name);
 			name_status = NAME_NOT_REQUIRED;
-
-			if (name)
-				g_free(name);
-
-			name = eir_data.name;
-		} else {
-			if (name)
-				free(eir_data.name);
-			else
-				name = eir_data.name;
 		}
-	}
+		name = eir_data.name;
+	} else if (eir_data.name != NULL)
+		g_free(eir_data.name);
 
 	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
 					legacy, eir_data.services, name_status);
-- 
1.7.0.4

