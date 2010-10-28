Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v3] Fix obexd crash for empty listing invalid cache
Date: Thu, 28 Oct 2010 11:43:28 +0300
Message-Id: <1288255408-3967-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1288255408-3967-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1288255408-3967-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes obexd crash in 3-way calling scenario when filtered listing
response is empty. Valid cache and empty pbap buffer mean that cache was
already attempted to be created within a single session, but no data was
available. Hence, it is not notified and no such file error returned.

Such avoids clearing and creating a new cache operations for each incoming
call, which is one of possible solution to fix this bug. It can be
extensive for large phone books. New cache is not created within current
obex session or unless path is changed.
---
 plugins/pbap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 11cb678..3ea7d6b 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -751,6 +751,15 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 	/* PullvCardListing always get the contacts from the cache */
 
 	if (pbap->cache.valid) {
+		/*
+		 * Valid cache and empty buffer mean that cache was already
+		 * created within a single session, but no data is available.
+		 */
+		if (!pbap->buffer) {
+			ret = -ENOENT;
+			goto fail;
+		}
+
 		cache_ready_notify(pbap);
 		goto done;
 	}
-- 
1.7.0.4

