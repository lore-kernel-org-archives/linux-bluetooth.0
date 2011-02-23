Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Drop trailing newline from DBG() calls
Date: Wed, 23 Feb 2011 10:28:27 -0300
Message-Id: <1298467707-11121-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-ofono.c |    2 +-
 plugins/service.c       |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 0a7f0bd..b9fb0f1 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1116,7 +1116,7 @@ static void get_modems_reply(DBusPendingCall *call, void *user_data)
 	DBusMessage *reply;
 	DBusMessageIter iter, entry;
 
-	DBG("list_modem_reply is called\n");
+	DBG("list_modem_reply is called");
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
diff --git a/plugins/service.c b/plugins/service.c
index f44aa92..4e4db81 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -172,13 +172,13 @@ static void element_end(GMarkupParseContext *context,
 			int ret = sdp_attr_add(ctx_data->record, ctx_data->attr_id,
 							ctx_data->stack_head->data);
 			if (ret == -1)
-				DBG("Trouble adding attribute\n");
+				DBG("Trouble adding attribute");
 
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

