Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v6 11/12] Replace EIR_DATA_LENGTH with HCI_MAX_EIR_LENGTH
Date: Wed, 18 May 2011 18:34:09 -0300
Message-Id: <1305754449-28088-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305747606-19787-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305747606-19787-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Both defines have the same value (240) and meaning.
---
 src/adapter.c |    2 +-
 src/eir.c     |    9 +++++----
 src/eir.h     |    2 --
 src/event.c   |    2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dc051cd..0210c30 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3005,7 +3005,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	int err;
 
 	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, data, EIR_DATA_LENGTH);
+	err = eir_parse(&eir_data, data, HCI_MAX_EIR_LENGTH);
 	if (err < 0) {
 		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
 		return;
diff --git a/src/eir.c b/src/eir.c
index 2fbd919..7dfc444 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -27,6 +27,7 @@
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
 
 #include "glib-helper.h"
@@ -184,7 +185,7 @@ static void eir_generate_uuid128(GSList *list, uint8_t *ptr, uint16_t *eir_len)
 			continue;
 
 		/* Stop if not enough space to put next UUID128 */
-		if ((len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
+		if ((len + 2 + SIZEOF_UUID128) > HCI_MAX_EIR_LENGTH) {
 			truncated = TRUE;
 			break;
 		}
@@ -229,7 +230,7 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 	GSList *l;
 	uint8_t *ptr = data;
 	uint16_t eir_len = 0;
-	uint16_t uuid16[EIR_DATA_LENGTH / 2];
+	uint16_t uuid16[HCI_MAX_EIR_LENGTH / 2];
 	int i, uuid_count = 0;
 	gboolean truncated = FALSE;
 	size_t name_len;
@@ -289,7 +290,7 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 			continue;
 
 		/* Stop if not enough space to put next UUID16 */
-		if ((eir_len + 2 + sizeof(uint16_t)) > EIR_DATA_LENGTH) {
+		if ((eir_len + 2 + sizeof(uint16_t)) > HCI_MAX_EIR_LENGTH) {
 			truncated = TRUE;
 			break;
 		}
@@ -322,6 +323,6 @@ void eir_create(const char *name, int8_t tx_power, uint16_t did_vendor,
 	}
 
 	/* Group all UUID128 types */
-	if (eir_len <= EIR_DATA_LENGTH - 2)
+	if (eir_len <= HCI_MAX_EIR_LENGTH - 2)
 		eir_generate_uuid128(uuids, ptr, &eir_len);
 }
diff --git a/src/eir.h b/src/eir.h
index aacd16a..ea38570 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -22,8 +22,6 @@
  *
  */
 
-#define EIR_DATA_LENGTH  240
-
 struct uuid_info {
 	uuid_t uuid;
 	uint8_t svc_hint;
diff --git a/src/event.c b/src/event.c
index 3ee8802..e28afa3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -321,7 +321,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		write_remote_eir(local, peer, data);
 
 	adapter_update_found_devices(adapter, peer, class, rssi,
-						data, EIR_DATA_LENGTH);
+						data, HCI_MAX_EIR_LENGTH);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.5.rc3

