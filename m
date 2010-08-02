Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@Nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@Nokia.com>
Subject: [PATCH] Add NULL checking for name param
Date: Mon,  2 Aug 2010 17:24:06 +0300
Message-Id: <1280759046-11571-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added NULL checking for "name" param in pbap_open_* functions. If on
this level this variable will be NULL, then setting -EBADR error code
and ending function. This fixes many obexd crashes.
---
 plugins/pbap.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index af4b452..8742a87 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -555,7 +555,7 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 
 	DBG("name %s type %s pbap %p", name, type, pbap);
 
-	if (type == NULL)
+	if (type == NULL || name == NULL)
 		return -EBADR;
 
 	rsize = obex_aparam_read(os, obj, &buffer);
@@ -689,6 +689,11 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
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
@@ -720,6 +725,10 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
+	if (name == NULL) {
+		ret = -EBADR;
+		goto fail;
+	}
 	/* PullvCardListing always get the contacts from the cache */
 
 	if (pbap->cache.valid) {
@@ -758,7 +767,7 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
-	if (sscanf(name, "%u.vcf", &handle) != 1) {
+	if (name == NULL || sscanf(name, "%u.vcf", &handle) != 1) {
 		ret = -EBADR;
 		goto fail;
 	}
-- 
1.7.0.4

