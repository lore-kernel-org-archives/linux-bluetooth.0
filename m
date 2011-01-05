Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] telephony-ofono: fix not updating indicators when a call is removed
Date: Wed,  5 Jan 2011 17:59:47 +0200
Message-Id: <1294243187-1849-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In some extreme cases such as modem removal ofono may not have a chance
to set the call to disconnected state so indicators would not be update
properly.
---
 audio/telephony-ofono.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 6492081..ae8f56a 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -457,6 +457,16 @@ static void call_free(struct voice_call *vc)
 {
 	DBG("%s", vc->obj_path);
 
+	if (vc->status == CALL_STATUS_ACTIVE)
+		telephony_update_indicator(ofono_indicators, "call",
+							EV_CALL_INACTIVE);
+	else
+		telephony_update_indicator(ofono_indicators, "callsetup",
+							EV_CALLSETUP_INACTIVE);
+
+	if (vc->status == CALL_STATUS_INCOMING)
+		telephony_calling_stopped_ind();
+
 	g_dbus_remove_watch(connection, vc->watch);
 	g_free(vc->obj_path);
 	g_free(vc->number);
@@ -489,14 +499,6 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &state);
 		DBG("State %s", state);
 		if (g_str_equal(state, "disconnected")) {
-			if (vc->status == CALL_STATUS_ACTIVE)
-				telephony_update_indicator(ofono_indicators,
-						"call", EV_CALL_INACTIVE);
-			else
-				telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_INACTIVE);
-			if (vc->status == CALL_STATUS_INCOMING)
-				telephony_calling_stopped_ind();
 			calls = g_slist_remove(calls, vc);
 			call_free(vc);
 		} else if (g_str_equal(state, "active")) {
-- 
1.7.1

