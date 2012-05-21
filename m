Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 2/2] core: Fix creating device from "primary" file
Date: Mon, 21 May 2012 17:48:36 -0300
Message-Id: <1337633316-4992-3-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch removes the hard-coded address type for the BLE device
created from the storage.
---
 src/adapter.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dafe595..1ca21e6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1940,13 +1940,17 @@ static void create_stored_device_from_primary(char *key, char *value,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
 	GSList *services, *uuids, *l;
+	char address[18];
+	uint8_t bdaddr_type;
+
+	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
+		bdaddr_type = BDADDR_LE_PUBLIC;
 
 	if (g_slist_find_custom(adapter->devices,
-			key, (GCompareFunc) device_address_cmp))
+			address, (GCompareFunc) device_address_cmp))
 		return;
 
-	/* FIXME: Get the correct LE addr type (public/random) */
-	device = device_create(connection, adapter, key, BDADDR_LE_PUBLIC);
+	device = device_create(connection, adapter, address, bdaddr_type);
 	if (!device)
 		return;
 
-- 
1.7.7.6

