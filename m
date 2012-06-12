Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] mgmtops: Rename pending_uuid to cod_busy
Date: Tue, 12 Jun 2012 12:00:08 +0200
Message-ID: <1339495209-17701-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This boolean will be used for any ongoing mgmt command that might cause
a CoD update (e.g. set_dev_class) so rename it appropriately.
---
 plugins/mgmtops.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index a196b1f..8229da1 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -70,7 +70,7 @@ static struct controller_info {
 	GSList *connections;
 	uint8_t discov_type;
 
-	gboolean pending_uuid;
+	gboolean cod_busy;
 	GSList *pending_uuids;
 
 	gboolean pending_class;
@@ -347,7 +347,7 @@ static int mgmt_update_powered(struct btd_adapter *adapter,
 		btd_adapter_stop(adapter);
 		g_slist_free_full(info->pending_uuids, g_free);
 		info->pending_uuids = NULL;
-		info->pending_uuid = FALSE;
+		info->cod_busy = FALSE;
 		info->pending_class = FALSE;
 		return 0;
 	}
@@ -836,7 +836,7 @@ static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
 
 	DBG("index %d", index);
 
-	if (info->pending_uuid) {
+	if (info->cod_busy) {
 		struct pending_uuid *pending = g_new0(struct pending_uuid, 1);
 
 		memcpy(&pending->uuid, uuid, sizeof(*uuid));
@@ -862,7 +862,7 @@ static int mgmt_add_uuid(int index, uuid_t *uuid, uint8_t svc_hint)
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
 
-	info->pending_uuid = TRUE;
+	info->cod_busy = TRUE;
 
 	return 0;
 }
@@ -935,11 +935,10 @@ static int mgmt_set_powered(int index, gboolean powered)
 {
 	struct controller_info *info = &controllers[index];
 
-	DBG("index %d powered %d pending_uuid %u", index, powered,
-							info->pending_uuid);
+	DBG("index %d powered %d cod_busy %u", index, powered, info->cod_busy);
 
 	if (powered) {
-		if (info->pending_uuid) {
+		if (info->cod_busy) {
 			info->pending_powered = TRUE;
 			return 0;
 		}
@@ -980,7 +979,7 @@ static int mgmt_set_dev_class(int index, uint8_t major, uint8_t minor)
 
 	DBG("index %d major %u minor %u", index, major, minor);
 
-	if (info->pending_uuid) {
+	if (info->cod_busy) {
 		info->major = major;
 		info->minor = minor;
 		info->pending_class = TRUE;
@@ -1287,7 +1286,7 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 
 	info = &controllers[index];
 
-	info->pending_uuid = FALSE;
+	info->cod_busy = FALSE;
 
 	if (g_slist_length(info->pending_uuids) == 0) {
 		if (info->pending_class) {
-- 
on behalf of ST-Ericsson

