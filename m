Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v2] Fix obexd crash for empty listing invalid cache
Date: Wed, 27 Oct 2010 20:56:41 +0300
Message-Id: <1288202201-861-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes obexd crash in 3-way calling scenario when listing response is
empty. Valid cache and empty pbap buffer mean that cache was already attempted
to be created within a single session, but no data was available. Hence, it
is not notified and no such file error returned. New cache is not created
within current obex session or unless path is changed. Such removes necessity
of querying and filtering contacts for each incoming call in the other case,
which is extensive for large phone books. On the other hand, if user updates
contacts, cache will not be renewed till obex session is closed or path is
changed. Therefore TODO: note is added that clear of cache should be defined
besides of end of session or change of path.
---
 plugins/pbap.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 11cb678..2a90d4d 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -751,6 +751,20 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 	/* PullvCardListing always get the contacts from the cache */
 
 	if (pbap->cache.valid) {
+		/*
+		 * Valid cache and empty buffer mean that cache was already
+		 * created within a single session, but no data is available.
+		 * New cache will not be created in current obex session or
+		 * unless path is changed. If user updates contacts, cache
+		 * will not be renewed, and, therefore:
+		 * TODO: Define clear cache besides end of session or change
+		 * of path.
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

