Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix DBG() calls with bogus messages
Date: Wed, 23 Feb 2011 15:11:03 -0300
Message-Id: <1298484663-19369-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1298467707-11121-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1298467707-11121-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unnecessary trailing newlines (already added by DBG()) and
rewrite debug messages to become more useful.
---
 audio/telephony-ofono.c |    2 +-
 plugins/service.c       |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 0a7f0bd..ef4ede7 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1116,7 +1116,7 @@ static void get_modems_reply(DBusPendingCall *call, void *user_data)
 	DBusMessage *reply;
 	DBusMessageIter iter, entry;
 
-	DBG("list_modem_reply is called\n");
+	DBG("");
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
diff --git a/plugins/service.c b/plugins/service.c
index f44aa92..d73cdea 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -172,13 +172,14 @@ static void element_end(GMarkupParseContext *context,
 			int ret = sdp_attr_add(ctx_data->record, ctx_data->attr_id,
 							ctx_data->stack_head->data);
 			if (ret == -1)
-				DBG("Trouble adding attribute\n");
+				DBG("Could not add attribute 0x%04x",
+							ctx_data->attr_id);
 
 			ctx_data->stack_head->data = NULL;
 			sdp_xml_data_free(ctx_data->stack_head);
 			ctx_data->stack_head = NULL;
 		} else {
-			DBG("No data for attribute 0x%04x\n", ctx_data->attr_id);
+			DBG("No data for attribute 0x%04x", ctx_data->attr_id);
 		}
 		return;
 	}
-- 
1.7.0.4

