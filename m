Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] media: Ignore signess for D-Bus int types
Date: Fri, 10 May 2013 14:02:06 +0300
Message-Id: <1368183727-24461-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some players such as Spotify implements some properties that are
defined in MPRIS as int64 as uint64 which makes it fail to register.
---
 profiles/audio/media.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 33847e5..ce674d0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1322,8 +1322,12 @@ static gboolean parse_int64_metadata(struct media_player *mp, const char *key,
 {
 	uint64_t value;
 	char valstr[20];
+	int type;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
+	type = dbus_message_iter_get_arg_type(iter);
+	if (type == DBUS_TYPE_UINT64)
+		warn("expected DBUS_TYPE_INT64 got DBUS_TYPE_UINT64");
+	else if (type != DBUS_TYPE_INT64)
 		return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
@@ -1345,8 +1349,12 @@ static gboolean parse_int32_metadata(struct media_player *mp, const char *key,
 {
 	uint32_t value;
 	char valstr[20];
+	int type;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT32)
+	type = dbus_message_iter_get_arg_type(iter);
+	if (type == DBUS_TYPE_UINT32)
+		warn("expected DBUS_TYPE_INT32 got DBUS_TYPE_UINT32");
+	else if (type != DBUS_TYPE_INT32)
 		return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
-- 
1.8.1.4

