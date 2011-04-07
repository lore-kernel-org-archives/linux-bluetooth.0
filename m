Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 6/9] Fix LE device creation from storage
Date: Thu,  7 Apr 2011 14:30:11 -0300
Message-Id: <1302197414-833-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ignore the device if it already created. This patch adds a consistency
check to avoid registering the same service over basic rate and LE.
---
 src/adapter.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8380a58..9a0f688 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2171,18 +2171,16 @@ static void create_stored_device_from_primary(char *key, char *value,
 	struct btd_device *device;
 	GSList *services, *uuids, *l;
 
-	l = g_slist_find_custom(adapter->devices,
-				key, (GCompareFunc) device_address_cmp);
-	if (l)
-		device = l->data;
-	else {
-		device = device_create(connection, adapter, key, DEVICE_TYPE_LE);
-		if (!device)
-			return;
+	if (g_slist_find_custom(adapter->devices,
+			key, (GCompareFunc) device_address_cmp))
+		return;
 
-		device_set_temporary(device, FALSE);
-		adapter->devices = g_slist_append(adapter->devices, device);
-	}
+	device = device_create(connection, adapter, key, DEVICE_TYPE_LE);
+	if (!device)
+		return;
+
+	device_set_temporary(device, FALSE);
+	adapter->devices = g_slist_append(adapter->devices, device);
 
 	services = string_to_primary_list(value);
 	if (services == NULL)
-- 
1.7.4.1

