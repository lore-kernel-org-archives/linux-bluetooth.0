Return-Path: <cyrus@holtmann.org>
From: Rakesh M K <rakesh.mk@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rakesh M K <rakesh.mk@samsung.com>
Subject: [PATCH] Audio/Media: Fix incorrect value dereference
Date: Mon, 13 Jul 2015 18:20:00 +0530
Message-id: <1436791800-1939-1-git-send-email-rakesh.mk@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

parameter value passed to the config_cb is a pointer to the
gbooloean. dereferencing the value rather than address leads
to mismatch in handling the return value.

avdtp.c:avdtp_parse_cmd() Received SET_CONFIGURATION_CMD
a2dp.c:endpoint_setconf_ind() Source 0xb7d49ef8: Set_Configuration_Ind
a2dp.c:setup_ref() 0xb7d53b98: ref=2
media.c:media_adapter_get_player()
media.c:media_set_sink_callback()
media.c:media_endpoint_async_call() Calling SetConfiguration: name = :1.37 path = /MediaEndpoint/A2DPSource

*#0  0xb6cea184 in __libc_free (mem=0xbead3ae4) at malloc.c:3736
*#1  0xb6e33468 in g_free () from /usr/lib/libglib-2.0.so.0
*#2  0xb6f25db0 in auto_config (data=0xb7d53b98) at profiles/audio/a2dp.c:430
*#3  0xb6f2ad76 in config_cb (endpoint=<value optimized out>,
*    ret=<value optimized out>, size=<value optimized out>,
*    user_data=<value optimized out>) at profiles/audio/media.c:707
*#4  0xb6f2cc4a in endpoint_reply (call=<value optimized out>,
*    user_data=0xb7d516b0) at profiles/audio/media.c:357
*#5  0xb6ddce96 in _dbus_pending_call_complete (pending=0xb7d53bc8)
*    at dbus-pending-call.c:216
*#6  0xb6dcfe82 in complete_pending_call_and_unlock (connection=0xb7d44b40,
*    pending=0xb7d53bc8, message=<value optimized out>)
*    at dbus-connection.c:2331
---
 profiles/audio/media.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index f12569e..ed441d0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -532,8 +532,9 @@ static void config_cb(struct media_endpoint *endpoint, void *ret, int size,
 							void *user_data)
 {
 	struct a2dp_config_data *data = user_data;
+	gboolean *ret_value = ret;
 
-	data->cb(data->setup, ret ? TRUE : FALSE);
+	data->cb(data->setup, *ret_value ? TRUE : FALSE);
 }
 
 static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
-- 
1.7.9.5

