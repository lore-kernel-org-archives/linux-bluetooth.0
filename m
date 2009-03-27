Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Mar 2009 11:09:24 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Does anybody experience A2DP sound  abnormaly?
To: 'BlueZ development' <linux-bluetooth@vger.kernel.org>
Message-id: <007f01c9ae81$0d090940$271b1bc0$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all

In case of special song, special case, I am trouble in hearing A2DP ALSA
with BlueZ 4.x.
At that time , 
I hear abnormal BlueZ (4.33 4.28 4.27..) A2DP sound while 3.36 sound is
normal.

Could you give me a piece of advice? 

I attached log.(Success case)
bluetoothd[29947]: START request succeeded
bluetoothd[29947]: Source 0xb7fc6a00: Start_Cfm
bluetoothd[29947]: setup_ref(0xb7fc8a80): ref=2
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[29947]: setup_unref(0xb7fc8a80): ref=1
bluetoothd[29947]: setup_unref(0xb7fc8a80): ref=0
bluetoothd[29947]: setup_free(0xb7fc8a80)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: stream state changed: OPEN -> STREAMING


(Fail Case)
bluetoothd[29947]: Accepted new client connection on unix socket (fd=15)
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=3
bluetoothd[29947]: Append codec 0 - length 10 - total 14
bluetoothd[29947]: Append codec 1 - length 10 - total 24
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[29947]: config a2dp - device = 00:1A:80:47:F4:10 access_mode = 2
bluetoothd[29947]: codec sbc - frequency = 1 channel_mode = 1 allocation = 1
subbands = 1 blocks = 1 bitpool = 51
bluetoothd[29947]: a2dp_source_config: selected SEP 0xb7fc6a00
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
bluetoothd[29947]: setup_ref(0xb7fc06a0): ref=1
bluetoothd[29947]: setup_ref(0xb7fc06a0): ref=2
bluetoothd[29947]: SEP 0xb7fc6a00 locked
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[29947]: setup_unref(0xb7fc06a0): ref=1
bluetoothd[29947]: setup_unref(0xb7fc06a0): ref=0
bluetoothd[29947]: setup_free(0xb7fc06a0)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
bluetoothd[29947]: session_cb
bluetoothd[29947]: SUSPEND request succeeded
bluetoothd[29947]: stream state changed: STREAMING -> OPEN
bluetoothd[29947]: Source 0xb7fc6a00: Suspend_Cfm
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
bluetoothd[29947]: session_cb
bluetoothd[29947]: START request succeeded
bluetoothd[29947]: Source 0xb7fc6a00: Start_Cfm
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
bluetoothd[29947]: setup_free(0xb7fc8cd0)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: stream state changed: OPEN -> STREAMING
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
bluetoothd[29947]: setup_free(0xb7fc8cd0)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
bluetoothd[29947]: setup_free(0xb7fc8cd0)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
bluetoothd[29947]: setup_free(0xb7fc8cd0)
bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
.
.
.


