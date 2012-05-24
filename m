Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 12/16] core: Fix creating device from "blocked" file
Date: Thu, 24 May 2012 15:46:09 -0300
Message-Id: <1337885173-9129-13-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c1caffd..a7e9e77 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1888,12 +1888,17 @@ static void create_stored_device_from_blocked(char *key, char *value,
 {
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
+	char address[18];
+	uint8_t bdaddr_type;
+
+	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
+		return;
 
 	if (g_slist_find_custom(adapter->devices,
-				key, (GCompareFunc) device_address_cmp))
+				address, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, BDADDR_BREDR);
+	device = device_create(connection, adapter, address, bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
-- 
1.7.7.6

