Return-Path: <cyrus@holtmann.org>
Message-Id: <201007190815.o6J8F4ib013820@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Jul 2010 09:44:39 +0200
Subject: [PATCH] add variable target size support in obex_mime_type_driver_find()
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

targets for mime type drivers are not always fixed to TARGET_SIZE.
(ifix started by Pierre Ossman)

Signed-off-by: Marcel Mol <marcel@mesa.nl>
---
 plugins/filesystem.c    |    3 +++
 plugins/nokia-backup.c  |    1 +
 plugins/pbap.c          |    3 +++
 plugins/syncevolution.c |    1 +
 src/mimetype.c          |   14 ++++++++------
 src/mimetype.h          |    2 ++
 src/obex.c              |   10 ++++++++--
 7 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 9fe4f00..f0e5bbe 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -550,6 +550,7 @@ static struct obex_mime_type_driver file = {
 
 static struct obex_mime_type_driver capability = {
 	.target = FTP_TARGET,
+	.target_size = TARGET_SIZE,
 	.mimetype = "x-obex/capability",
 	.open = capability_open,
 	.close = capability_close,
@@ -558,6 +559,7 @@ static struct obex_mime_type_driver capability = {
 
 static struct obex_mime_type_driver folder = {
 	.target = FTP_TARGET,
+	.target_size = TARGET_SIZE,
 	.mimetype = "x-obex/folder-listing",
 	.open = folder_open,
 	.close = string_free,
@@ -566,6 +568,7 @@ static struct obex_mime_type_driver folder = {
 
 static struct obex_mime_type_driver pcsuite = {
 	.target = FTP_TARGET,
+	.target_size = TARGET_SIZE,
 	.who = PCSUITE_WHO,
 	.who_size = PCSUITE_WHO_SIZE,
 	.mimetype = "x-obex/folder-listing",
diff --git a/plugins/nokia-backup.c b/plugins/nokia-backup.c
index dffc5cd..1fe3fc5 100644
--- a/plugins/nokia-backup.c
+++ b/plugins/nokia-backup.c
@@ -276,6 +276,7 @@ static ssize_t backup_write(void *object, const void *buf, size_t count)
 
 static struct obex_mime_type_driver backup = {
 	.target = FTP_TARGET,
+	.target_size = TARGET_SIZE
 	.mimetype = "application/vnd.nokia-backup",
 	.open = backup_open,
 	.close = backup_close,
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 3c8e33e..af4b452 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -861,6 +861,7 @@ static int vobject_close(void *object)
 
 static struct obex_mime_type_driver mime_pull = {
 	.target = PBAP_TARGET,
+	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/phonebook",
 	.open = vobject_pull_open,
 	.close = vobject_close,
@@ -869,6 +870,7 @@ static struct obex_mime_type_driver mime_pull = {
 
 static struct obex_mime_type_driver mime_list = {
 	.target = PBAP_TARGET,
+	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/vcard-listing",
 	.open = vobject_list_open,
 	.close = vobject_close,
@@ -877,6 +879,7 @@ static struct obex_mime_type_driver mime_list = {
 
 static struct obex_mime_type_driver mime_vcard = {
 	.target = PBAP_TARGET,
+	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/vcard",
 	.open = vobject_vcard_open,
 	.close = vobject_close,
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index 55709df..970ce29 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -443,6 +443,7 @@ static ssize_t synce_write(void *object, const void *buf, size_t count)
 
 static struct obex_mime_type_driver synce_driver = {
 	.target = SYNCML_TARGET,
+	.target_size = SYNCML_TARGET_SIZE,
 	.open = synce_open,
 	.close = synce_close,
 	.read = synce_read,
diff --git a/src/mimetype.c b/src/mimetype.c
index 7b96ec2..7df1308 100644
--- a/src/mimetype.c
+++ b/src/mimetype.c
@@ -118,6 +118,7 @@ static int set_io_watch(void *object, obex_object_io_func func,
 }
 
 static struct obex_mime_type_driver *find_driver(const uint8_t *target,
+				unsigned int target_size,
 				const char *mimetype, const uint8_t *who,
 				unsigned int who_size)
 {
@@ -126,7 +127,7 @@ static struct obex_mime_type_driver *find_driver(const uint8_t *target,
 	for (l = drivers; l; l = l->next) {
 		struct obex_mime_type_driver *driver = l->data;
 
-		if (memcmp0(target, driver->target, TARGET_SIZE))
+		if (memcmp0(target, driver->target, target_size))
 			continue;
 
 		if (memcmp0(who, driver->who, who_size))
@@ -140,27 +141,28 @@ static struct obex_mime_type_driver *find_driver(const uint8_t *target,
 }
 
 struct obex_mime_type_driver *obex_mime_type_driver_find(const uint8_t *target,
+				unsigned int target_size,
 				const char *mimetype, const uint8_t *who,
 				unsigned int who_size)
 {
 	struct obex_mime_type_driver *driver;
 
-	driver = find_driver(target, mimetype, who, who_size);
+	driver = find_driver(target, target_size, mimetype, who, who_size);
 	if (driver == NULL) {
 		if (who != NULL) {
 			/* Fallback to non-who specific */
-			driver = find_driver(target, mimetype, NULL, 0);
+			driver = find_driver(target, target_size, mimetype, NULL, 0);
 			if (driver != NULL)
 				return driver;
 		}
 
 		if (mimetype != NULL)
 			/* Fallback to target default */
-			driver = find_driver(target, NULL, NULL, 0);
+			driver = find_driver(target, target_size, NULL, NULL, 0);
 
 		if (driver == NULL)
 			/* Fallback to general default */
-			driver = find_driver(NULL, NULL, NULL, 0);
+			driver = find_driver(NULL, 0, NULL, NULL, 0);
 	}
 
 	return driver;
@@ -173,7 +175,7 @@ int obex_mime_type_driver_register(struct obex_mime_type_driver *driver)
 		return -EINVAL;
 	}
 
-	if (find_driver(driver->target, driver->mimetype,
+	if (find_driver(driver->target, driver->target_size, driver->mimetype,
 					driver->who, driver->who_size)) {
 		error("Permission denied: %s could not be registered",
 				driver->mimetype);
diff --git a/src/mimetype.h b/src/mimetype.h
index 4cb3156..200b950 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -26,6 +26,7 @@ typedef gboolean (*obex_object_io_func) (void *object, int flags, int err,
 
 struct obex_mime_type_driver {
 	const uint8_t *target;
+	unsigned int target_size;
 	const char *mimetype;
 	const uint8_t *who;
 	unsigned int who_size;
@@ -42,6 +43,7 @@ struct obex_mime_type_driver {
 int obex_mime_type_driver_register(struct obex_mime_type_driver *driver);
 void obex_mime_type_driver_unregister(struct obex_mime_type_driver *driver);
 struct obex_mime_type_driver *obex_mime_type_driver_find(const uint8_t *target,
+				unsigned int target_size,
 				const char *mimetype, const uint8_t *who,
 				unsigned int who_size);
 
diff --git a/src/obex.c b/src/obex.c
index db04bfd..21788ba 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -763,7 +763,9 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 			os->type = g_strndup((const char *) hd.bs, hlen);
 			DBG("OBEX_HDR_TYPE: %s", os->type);
 			os->driver = obex_mime_type_driver_find(
-						os->service->target, os->type,
+						os->service->target,
+						os->service->target_size,
+						os->type,
 						os->service->who,
 						os->service->who_size);
 			break;
@@ -772,6 +774,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 
 	if (os->type == NULL)
 		os->driver = obex_mime_type_driver_find(os->service->target,
+							os->service->target_size,
 							NULL,
 							os->service->who,
 							os->service->who_size);
@@ -977,7 +980,9 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
 			os->type = g_strndup((const char *) hd.bs, hlen);
 			DBG("OBEX_HDR_TYPE: %s", os->type);
 			os->driver = obex_mime_type_driver_find(
-						os->service->target, os->type,
+						os->service->target,
+						os->service->target_size,
+						os->type,
 						os->service->who,
 						os->service->who_size);
 			break;
@@ -1001,6 +1006,7 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
 
 	if (os->type == NULL)
 		os->driver = obex_mime_type_driver_find(os->service->target,
+							os->service->target_size,
 							NULL,
 							os->service->who,
 							os->service->who_size);
-- 
1.7.1.1

