Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix possible crash when endpoint exit
Date: Fri, 21 Sep 2012 16:12:23 +0300
Message-Id: <1348233143-27796-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

a2dp_sep_unlock may free the endpoint if it is not registered anymore
which leads to destroying all related transport causing the following:

Invalid read of size 1
   at 0x4A09F09: memcpy@GLIBC_2.2.5 (mc_replace_strmem.c:836)
   by 0x4F7C02D: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F7AAE5: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F7B10B: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F68DA0: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F66788: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F66B41: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F6D64E: dbus_message_new_signal (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x180FC2: emit_property_changed (dbus-common.c:130)
   by 0x13FD15: transport_set_state (transport.c:206)
   by 0x140519: suspend_a2dp (transport.c:460)
   by 0x122436: service_filter (watch.c:476)
 Address 0x6546110 is 48 bytes inside a block of size 49 free'd
   at 0x4A079AE: free (vg_replace_malloc.c:427)
   by 0x4C8037E: g_free (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x1409F9: media_transport_free (transport.c:1160)
   by 0x12282F: remove_interface (object.c:553)
   by 0x123699: g_dbus_unregister_interface (object.c:1231)
   by 0x141547: media_transport_destroy (transport.c:228)
   by 0x4C95ACC: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C95AEA: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x13E53D: media_endpoint_remove (media.c:162)
   by 0x133F62: a2dp_unregister_sep (a2dp.c:1247)
   by 0x1369D7: a2dp_sep_unlock (a2dp.c:1814)
   by 0x1404D3: suspend_a2dp (transport.c:455)
---
 audio/transport.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 281895e..23e7ddd 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -451,18 +451,14 @@ static guint suspend_a2dp(struct media_transport *transport,
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 
-	if (!owner) {
-		a2dp_sep_unlock(sep, a2dp->session);
-
-		if (a2dp_sep_is_playing(sep))
-			transport_set_state(transport, TRANSPORT_STATE_PENDING);
-		else
-			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	if (owner != NULL)
+		return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete,
+									owner);
 
-		return 0;
-	}
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	a2dp_sep_unlock(sep, a2dp->session);
 
-	return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete, owner);
+	return 0;
 }
 
 static void cancel_a2dp(struct media_transport *transport, guint id)
-- 
1.7.11.4

