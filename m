Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] test: Fix using Number instead of Track in mpris-player
Date: Mon, 29 Oct 2012 16:41:48 +0200
Message-Id: <1351521709-4063-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
References: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/mpris-player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/mpris-player.c b/test/mpris-player.c
index a2c4cc6..13f5c85 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -338,7 +338,7 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 
 		dbus_message_iter_get_basic(&var, &value);
 
-		dict_append_entry(metadata, "Number", DBUS_TYPE_UINT32,
+		dict_append_entry(metadata, "Track", DBUS_TYPE_UINT32,
 								&value);
 	}
 
-- 
1.7.11.7

