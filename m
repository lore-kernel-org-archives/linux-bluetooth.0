Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 03/14] media: Rename set_property to set_player_property
Date: Wed, 27 Jun 2012 15:27:37 +0200
Message-ID: <1340803668-31686-3-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to avoid conflicts with DBus interface convention
used in BlueZ.
---
 audio/media.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 4e23273..cc8ac37 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1454,7 +1454,7 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	return TRUE;
 }
 
-static gboolean set_property(struct media_player *mp, const char *key,
+static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
 	DBusMessageIter var;
@@ -1515,7 +1515,7 @@ static gboolean property_changed(DBusConnection *connection, DBusMessage *msg,
 
 	dbus_message_iter_next(&iter);
 
-	set_property(mp, property, &iter);
+	set_player_property(mp, property, &iter);
 
 	return TRUE;
 }
@@ -1747,7 +1747,7 @@ static gboolean parse_player_properties(struct media_player *mp,
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
-		if (set_property(mp, key, &entry) == FALSE)
+		if (set_player_property(mp, key, &entry) == FALSE)
 			return FALSE;
 
 		dbus_message_iter_next(&dict);
-- 
on behalf of ST-Ericsson

