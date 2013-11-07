Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android: Fix sending remote device name property
Date: Thu,  7 Nov 2013 10:31:50 +0100
Message-Id: <1383816710-31059-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383816710-31059-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383816710-31059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android use the full string returned even if terminated with '\0'.

---
 android/adapter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index da5984a..495e725 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -672,9 +672,9 @@ static int fill_device_props(struct hal_property *prop, bdaddr_t *addr,
 	/* fill name */
 	if (name) {
 		prop->type = HAL_PROP_DEVICE_NAME;
-		prop->len = HAL_MAX_NAME_LENGTH;
-		strncpy((char *) prop->val, name, HAL_MAX_NAME_LENGTH - 1);
-		prop = ((void *) prop) + sizeof(*prop) + HAL_MAX_NAME_LENGTH;
+		prop->len = strlen(name);
+		memcpy(prop->val, name, prop->len);
+		prop = ((void *) prop) + sizeof(*prop) + prop->len;
 		num_props++;
 	}
 
@@ -723,7 +723,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	props_size += sizeof(struct hal_property) + sizeof(rssi);
 
 	if (eir.name)
-		props_size += sizeof(struct hal_property) + HAL_MAX_NAME_LENGTH;
+		props_size += sizeof(struct hal_property) + strlen(eir.name);
 
 	if (is_new_dev) {
 		struct hal_ev_device_found *ev = NULL;
-- 
1.8.4.1

