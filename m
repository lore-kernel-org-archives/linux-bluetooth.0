Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unneeded list when removing a device driver
Date: Thu,  5 May 2011 17:33:55 -0300
Message-Id: <1304627636-22358-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index b0a6542..694a3df 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1168,7 +1168,7 @@ add_uuids:
 static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	GSList *list, *next;
+	GSList *list;
 	char srcaddr[18], dstaddr[18];
 	bdaddr_t src;
 	sdp_list_t *records;
@@ -1181,12 +1181,10 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 
 	DBG("Removing drivers for %s", dstaddr);
 
-	for (list = device->drivers; list; list = next) {
+	for (list = device->drivers; list; list = list->next) {
 		struct btd_device_driver *driver = list->data;
 		const char **uuid;
 
-		next = list->next;
-
 		for (uuid = driver->uuids; *uuid; uuid++) {
 			if (!g_slist_find_custom(uuids, *uuid,
 						(GCompareFunc) strcasecmp))
-- 
1.7.5.rc3

