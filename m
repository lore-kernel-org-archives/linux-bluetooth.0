Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] media: Ignore signess for D-Bus int types
Date: Fri, 19 Apr 2013 15:31:12 +0300
Message-Id: <1366374673-24937-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
References: <1366374673-24937-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some players such as Spotify implements some properties that are
defined in MPRIS as int64 as uint64 which makes it fail to register.
---
 profiles/audio/media.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4295180..48c7a52 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1319,8 +1319,10 @@ static gboolean parse_int64_metadata(struct media_player *mp, const char *key,
 {
 	uint64_t value;
 	char valstr[20];
+	int type;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
+	type = dbus_message_iter_get_arg_type(iter);
+	if (type != DBUS_TYPE_INT64 && type != DBUS_TYPE_UINT64)
 		return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
@@ -1342,8 +1344,10 @@ static gboolean parse_int32_metadata(struct media_player *mp, const char *key,
 {
 	uint32_t value;
 	char valstr[20];
+	int type;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT32)
+	type = dbus_message_iter_get_arg_type(iter);
+	if (type != DBUS_TYPE_INT32 && type != DBUS_TYPE_UINT32)
 		return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
-- 
1.8.1.4

