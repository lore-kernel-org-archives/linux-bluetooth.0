Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] audio/avdtp: Use bitfield id generation
Date: Wed, 18 Feb 2015 12:53:10 +0200
Message-Id: <1424256791-23531-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use bitfield utils for assigning SEP id. This fixes duplicated id
generation shown in unit/avdtp tests.
---
 profiles/audio/avdtp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ba5f0e5..825fb79 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -41,6 +41,7 @@
 #include <glib.h>
 
 #include "src/log.h"
+#include "src/shared/util.h"
 
 #include "btio/btio.h"
 #include "lib/uuid.h"
@@ -54,6 +55,7 @@
 #define AVDTP_PSM 25
 
 #define MAX_SEID 0x3E
+static unsigned int seids;
 
 #ifndef MAX
 # define MAX(x, y) ((x) > (y) ? (x) : (y))
@@ -3703,6 +3705,10 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 {
 	struct avdtp_server *server;
 	struct avdtp_local_sep *sep;
+	uint8_t seid = util_get_uid(&seids, MAX_SEID);
+
+	if (!seid)
+		return NULL;
 
 	server = find_server(servers, adapter);
 	if (!server) {
@@ -3711,13 +3717,10 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 			return NULL;
 	}
 
-	if (g_slist_length(server->seps) > MAX_SEID)
-		return NULL;
-
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = g_slist_length(server->seps) + 1;
+	sep->info.seid = seid;
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
@@ -3762,6 +3765,7 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
 
+	util_clear_uid(&seids, sep->info.seid);
 	g_free(sep);
 
 	if (server->seps)
-- 
2.1.0

