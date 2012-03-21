Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 6/8] attrib: Fix missing D-Bus message unref on DiscoverCharacteristics
Date: Wed, 21 Mar 2012 13:00:53 -0400
Message-Id: <1332349255-15764-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch fixes a missing message unref when DiscoverCharacteristics on
Generic Attribute finishes.
---
 attrib/client.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index bbb7de3..ac1b354 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -929,6 +929,9 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	reply = create_discover_char_reply(gatt->query->msg, gatt->chars);
 
 fail:
+	dbus_message_unref(gatt->query->msg);
+	gatt->query->msg = NULL;
+
 	g_dbus_send_message(gatt->conn, reply);
 	query_list_remove(gatt, current);
 	g_free(current);
-- 
1.7.5.4

