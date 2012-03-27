Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 BlueZ 4/8] attrib: Register only new characteristics found
Date: Tue, 27 Mar 2012 16:43:45 -0400
Message-Id: <1332881029-1732-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This avoids duplicating registration for previously found
characteristics.
---
 attrib/client.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 651eade..ce78ed6 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -902,6 +902,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 		previous_end = &chr->end;
 
 		gatt->chars = g_slist_append(gatt->chars, chr);
+		register_characteristic(chr, gatt->path);
 	}
 
 	if (previous_end)
@@ -910,8 +911,6 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	gatt_get_address(gatt, &sba, &dba);
 	store_characteristics(&sba, &dba, prim->range.start, gatt->chars);
 
-	g_slist_foreach(gatt->chars, register_characteristic, gatt->path);
-
 	g_slist_foreach(gatt->chars, update_all_chars, gatt);
 
 	reply = create_discover_char_reply(gatt->query->msg, gatt->chars);
-- 
1.7.5.4

