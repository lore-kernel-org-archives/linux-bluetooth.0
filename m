Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/3] Code clean up: cache->folder removed
Date: Thu, 11 Nov 2010 09:36:12 +0200
Message-Id: <1289460972-2971-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cache->folder is not used anywhere and therefore removed.
---
 plugins/pbap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index af60741..660b17d 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -125,7 +125,6 @@ struct aparam_header {
 struct cache {
 	gboolean valid;
 	uint32_t index;
-	char *folder;
 	GSList *entries;
 };
 
@@ -219,7 +218,6 @@ static const char *cache_find(struct cache *cache, uint32_t handle)
 
 static void cache_clear(struct cache *cache)
 {
-	g_free(cache->folder);
 	g_slist_foreach(cache->entries, (GFunc) cache_entry_free, NULL);
 	g_slist_free(cache->entries);
 	cache->entries = NULL;
-- 
1.7.0.4

