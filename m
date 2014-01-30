Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] audio/player: Fix using invalid end index
Date: Thu, 30 Jan 2014 15:03:25 -0800
Message-Id: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the End index is not set in ListItems the code automatically pick
the number of items as end index but the start index start with 0 so
the correct is to use number of items - 1.
---
 profiles/audio/player.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e6d24eb..2bd2d6e 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -808,7 +808,8 @@ static int parse_filters(struct media_player *player, DBusMessageIter *iter,
 	int ctype;
 
 	*start = 0;
-	*end = folder->number_of_items ? folder->number_of_items : UINT32_MAX;
+	*end = folder->number_of_items ? folder->number_of_items - 1 :
+								UINT32_MAX;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	if (ctype != DBUS_TYPE_ARRAY)
-- 
1.8.4.2

