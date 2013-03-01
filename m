Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 03/10] device: Fix removing profiles
Date: Fri,  1 Mar 2013 20:22:26 -0300
Message-Id: <1362180153-11133-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The check against removed profile were always made using an empty
list, device->uuids was just cleared. And we should store the device
information after the profiles are removed.
---
 src/device.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index b7f30d8..435a9b8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2474,25 +2474,19 @@ add_uuids:
 
 static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 {
-	char srcaddr[18], dstaddr[18];
+	char dstaddr[18];
 	GSList *l, *next;
 
-	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	DBG("Removing profiles for %s", dstaddr);
 
-	g_slist_free(device->uuids);
-	device->uuids = NULL;
-	store_device_info(device);
-
 	for (l = device->profiles; l != NULL; l = next) {
 		struct btd_profile *profile = l->data;
 		GSList *probe_uuids;
 
 		next = l->next;
-		probe_uuids = device_match_profile(device, profile,
-								device->uuids);
+		probe_uuids = device_match_profile(device, profile, uuids);
 		if (probe_uuids != NULL) {
 			g_slist_free(probe_uuids);
 			continue;
@@ -2500,6 +2494,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 
 		profile->device_remove(profile, device);
 		device->profiles = g_slist_remove(device->profiles, profile);
+		g_slist_free(probe_uuids);
 	}
 }
 
@@ -3069,6 +3064,8 @@ static void register_all_services(struct btd_device *device, GSList *services)
 	device_svc_resolved(device, disc->msg, 0);
 	disc->msg = NULL; /* The reply was sent just above */
 
+	store_device_info(device);
+
 	store_services(device);
 }
 
-- 
1.8.1.3

