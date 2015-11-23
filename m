Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: s.syam@samsung.com
Subject: [PATCH v0] avdtp: Fix A2DP disconnection with ADVANCED_AUDIO_UUID only
 carkit
Date: Mon, 23 Nov 2015 22:31:52 +0530
Message-id: <1448298112-20501-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Few Carkits Like "VW MI" & "Seat BT AC" will register the ADVANCED
AUDIO UUID rather than A2DP SINK UUID. Once the signalling channel
is initiated by the remote sink device and streaming channel is not
yet initiated by sink, the source will check the remote device
SINK UUID to establish the streaming channel and will close the
signalling channel if SINK UUID is not present.

In addition to A2DP SINK UUID, this patch checks for the ADVANCED
AUDIO UUID as well.

Logs:
bluetoothd:
10:02:31 profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming connect from E0:75:0A:36:09:FD
10:02:31 profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling channel to E0:75:0A:36:09:FD
10:02:31 profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=672
10:02:31 profiles/audio/avdtp.c:set_disconnect_timer() name : "Seat BT AC" /* Extra print */
...
...
10:02:32 profiles/audio/avdtp.c:disconnect_timeout()
10:02:32 profiles/audio/avdtp.c:connection_lost() Disconnected from E0:75:0A:36:09:FD
10:02:32 profiles/audio/a2dp.c:channel_remove() chan 0xb7005348
10:02:32 profiles/audio/avdtp.c:connection_lost() 0xb7005d48: ref=0
10:02:32 profiles/audio/avdtp.c:avdtp_free() 0xb7005d48

DB file:
[General]
Name=Seat BT AC
Class=0x340408
SupportedTechnologies=BR/EDR;
Trusted=false
Blocked=false
Services=0000110c-0000-1000-8000-00805f9b34fb; //AVRCP_TARGET_UUID
0000110d-0000-1000-8000-00805f9b34fb; //ADVANCED_AUDIO_UUID
0000110e-0000-1000-8000-00805f9b34fb; //AVRCP_REMOTE_UUID
0000111e-0000-1000-8000-00805f9b34fb; //HFP_HS_UUID
0000112f-0000-1000-8000-00805f9b34fb; //PBAP_UUID
---
 profiles/audio/avdtp.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 52ee767..ac1939b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1138,6 +1138,12 @@ static gboolean disconnect_timeout(gpointer user_data)
 		return FALSE;
 	}
 
+	service = btd_device_get_service(session->device, ADVANCED_AUDIO_UUID);
+	if (service && stream_setup) {
+		sink_setup_stream(service, session);
+		return FALSE;
+	}
+
 	service = btd_device_get_service(session->device, A2DP_SOURCE_UUID);
 	if (service && stream_setup) {
 		source_setup_stream(service, session);
-- 
1.7.9.5

