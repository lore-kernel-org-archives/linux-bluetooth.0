Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add NULL checking for name and path params
Date: Tue,  3 Aug 2010 11:23:04 +0300
Message-Id: <1280823784-14551-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added NULL checking for "name" and "path" parameters in pbap_open_*
functions. If this variables will be NULL, then setting -EBADR error
code and ending function. This fixes many obexd crashes.
---
 plugins/pbap.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index af4b452..af4a1bc 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -594,6 +594,9 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	} else
 		return -EBADR;
 
+	if (path == NULL)
+		return -EBADR;
+
 	pbap->params = params;
 	ret = obex_get_stream_start(os, path);
 
@@ -689,6 +692,11 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
+	if (name == NULL) {
+		ret = -EBADR;
+		goto fail;
+	}
+
 	if (pbap->params->maxlistcount == 0)
 		cb = phonebook_size_result;
 	else
@@ -720,6 +728,11 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
+	if (name == NULL) {
+		ret = -EBADR;
+		goto fail;
+	}
+
 	/* PullvCardListing always get the contacts from the cache */
 
 	if (pbap->cache.valid) {
@@ -758,7 +771,7 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
-	if (sscanf(name, "%u.vcf", &handle) != 1) {
+	if (name == NULL || sscanf(name, "%u.vcf", &handle) != 1) {
 		ret = -EBADR;
 		goto fail;
 	}
-- 
1.7.0.4

