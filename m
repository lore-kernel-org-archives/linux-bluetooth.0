Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
        Nagaraj D R <nagaraj.dr@samsung.com>
Subject: [PATCH] Fix improper usage of g_free
Date: Tue, 22 May 2018 08:55:10 +0530
Message-id: <1526959510-26918-1-git-send-email-nagaraj.dr@samsung.com>
References: <CGME20180522032519epcas2p3cf940be103b17857bcb293a8bc37e5f8@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_free should be used for only those memory allocations
done through glib APIs

This patch is in continuation with
commit 01333078f591969f885bb94187a91d35e8fd5388
commit 8cfef5aa0c92c0ba096034fc1cd003a4f2c36bcf
---
 client/advertising.c | 2 +-
 src/adapter.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 39f9946..40fb3d5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -756,7 +756,7 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
 	if (ad.local_name && !strcmp(name, ad.local_name))
 		return;
 
-	g_free(ad.local_name);
+	free(ad.local_name);
 	ad.local_name = strdup(name);
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
diff --git a/src/adapter.c b/src/adapter.c
index 390216a..9493587 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2423,7 +2423,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	return true;
 
 invalid_args:
-	g_slist_free_full((*filter)->uuids, g_free);
+	g_slist_free_full((*filter)->uuids, free);
 	g_free(*filter);
 	*filter = NULL;
 	return false;
-- 
1.9.1

