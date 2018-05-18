Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
        Nagaraj D R <nagaraj.dr@samsung.com>
Subject: [PATCH] Fix improper usage of g_free
Date: Fri, 18 May 2018 09:14:08 +0530
Message-id: <1526615048-23393-1-git-send-email-nagaraj.dr@samsung.com>
References: <CGME20180518034418epcas2p3b31813a79452e5934a438347b8edc82a@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_free should be used for only those memory allocations
done through glib APIs
---
 client/advertising.c | 2 +-
 src/adapter.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 045133a..5592be6 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -757,7 +757,7 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
 		return;
 
 	g_free(ad.local_name);
-	ad.local_name = strdup(name);
+	ad.local_name = g_strdup(name);
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
 
diff --git a/src/adapter.c b/src/adapter.c
index c1c792a..07a4e42 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2258,7 +2258,7 @@ static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *filter)
 		bt_uuid_to_uuid128(&uuid, &u128);
 		bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
 
-		filter->uuids = g_slist_prepend(filter->uuids, strdup(uuidstr));
+		filter->uuids = g_slist_prepend(filter->uuids, g_strdup(uuidstr));
 
 		dbus_message_iter_next(&arriter);
 	}
-- 
1.9.1

