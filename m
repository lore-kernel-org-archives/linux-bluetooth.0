Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 1/5] Rename the Discover method to DiscoverCharacteristics
Date: Mon, 14 Mar 2011 18:19:40 -0300
Message-Id: <1300137584-24437-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 17157cd..f0b0b14 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -983,7 +983,7 @@ static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
 }
 
 static GDBusMethodTable prim_methods[] = {
-	{ "Discover",		"",	"",		discover_char	},
+	{ "DiscoverCharacteristics",	"",	"",	discover_char	},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
 						register_watcher	},
 	{ "UnregisterCharacteristicsWatcher",	"o", "",
-- 
1.7.4.1

