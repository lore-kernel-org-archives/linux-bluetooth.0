Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/4] Remove outdated comments
Date: Mon, 27 Dec 2010 09:21:07 -0400
Message-Id: <1293456068-11615-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/event.c b/src/event.c
index f445dd1..15fac94 100644
--- a/src/event.c
+++ b/src/event.c
@@ -444,7 +444,6 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		return;
 	}
 
-	/* Extract UUIDs from advertising data if any */
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = parse_eir_data(&eir_data, info->data, info->length);
 	if (err < 0)
@@ -518,7 +517,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		adapter_set_state(adapter, state);
 	}
 
-	/* Extract UUIDs from extended inquiry response if any */
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = parse_eir_data(&eir_data, data, EIR_DATA_LENGTH);
 	if (err < 0)
-- 
1.7.0.4

