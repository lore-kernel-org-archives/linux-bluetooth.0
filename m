Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 2/7] client: Use g_malloc0 in get_filter_strs
Date: Wed, 13 Jun 2012 22:49:18 +0200
Message-Id: <1339620563-25161-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use g_malloc0 instead of g_try_malloc0 to allocate list. All users
expects to get valid pointer from it anyway. Also size of allocated
memory is small.
---
 client/pbap.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 5ec7634..4428c14 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -632,10 +632,7 @@ static gchar **get_filter_strs(uint64_t filter, gint *size)
 	gint i;
 	gint filter_list_size = sizeof(filter_list) / sizeof(filter_list[0]) - 1;
 
-	list = g_try_malloc0(sizeof(gchar **) * (FILTER_BIT_MAX + 2));
-
-	if (!list)
-		return NULL;
+	list = g_malloc0(sizeof(gchar **) * (FILTER_BIT_MAX + 2));
 
 	item = list;
 
-- 
1.7.10.4


