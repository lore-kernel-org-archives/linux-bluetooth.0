Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Re: Does anybody experience A2DP sound  abnormaly?
Date: Fri, 27 Mar 2009 13:59:39 +0200
Cc: "'BlueZ development'" <linux-bluetooth@vger.kernel.org>
References: <007f01c9ae81$0d090940$271b1bc0$%park@samsung.com>
In-Reply-To: <007f01c9ae81$0d090940$271b1bc0$%park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903271359.39845.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 27 March 2009 04:09:24 ext Chan-Yeol Park wrote:
> Dear all
>
> In case of special song, special case, I am trouble in hearing A2DP ALSA
> with BlueZ 4.x.

Is this problem reproducible only with a single audio file? More details will
help, preferably so that anybody could reproduce the problem by reading
you description (an ideal case, which is unfortunately not always possible).

> At that time ,
> I hear abnormal BlueZ (4.33 4.28 4.27..) A2DP sound while 3.36 sound is
> normal.

What kind of abnormality do you hear? Is the audio in general recognizable but
has some defects like occasional clicks for example? Or is it a complete
noise?

> Could you give me a piece of advice?

In order to verify if it is a problem in sbc encoder, you can try a standalone
'sbcenc' and 'sbcdec' program or gstreamer sbc elements.

'sbcenc'/'sbcdec' expect data in .AU format. Conversion from/to this format
can be done with 'sox' or any other similar utility.

If this problem can be reproduced with sbc codec (encoding and decoding your
file results in getting the same abnormal sound in the output), then the bug
needs to be found and fixed there.

One thing that makes this test a bit more complex is that 'sbcdec' is known to
have some audio quality problems.

I can't help much if the problem is not in sbc codec, but in some other part
of bluez code. Maybe somebody else has some additional comments.

> I attached log.(Success case)
> bluetoothd[29947]: START request succeeded
> bluetoothd[29947]: Source 0xb7fc6a00: Start_Cfm
> bluetoothd[29947]: setup_ref(0xb7fc8a80): ref=2
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
> bluetoothd[29947]: setup_unref(0xb7fc8a80): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc8a80): ref=0
> bluetoothd[29947]: setup_free(0xb7fc8a80)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: stream state changed: OPEN -> STREAMING
>
>
> (Fail Case)
> bluetoothd[29947]: Accepted new client connection on unix socket (fd=15)
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: Append codec 0 - length 10 - total 14
> bluetoothd[29947]: Append codec 1 - length 10 - total 24
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
> bluetoothd[29947]: config a2dp - device = 00:1A:80:47:F4:10 access_mode = 2
> bluetoothd[29947]: codec sbc - frequency = 1 channel_mode = 1 allocation =
> 1 subbands = 1 blocks = 1 bitpool = 51
> bluetoothd[29947]: a2dp_source_config: selected SEP 0xb7fc6a00
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
> bluetoothd[29947]: setup_ref(0xb7fc06a0): ref=1
> bluetoothd[29947]: setup_ref(0xb7fc06a0): ref=2
> bluetoothd[29947]: SEP 0xb7fc6a00 locked
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
> bluetoothd[29947]: setup_unref(0xb7fc06a0): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc06a0): ref=0
> bluetoothd[29947]: setup_free(0xb7fc06a0)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: session_cb
> bluetoothd[29947]: SUSPEND request succeeded
> bluetoothd[29947]: stream state changed: STREAMING -> OPEN
> bluetoothd[29947]: Source 0xb7fc6a00: Suspend_Cfm
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: session_cb
> bluetoothd[29947]: START request succeeded
> bluetoothd[29947]: Source 0xb7fc6a00: Start_Cfm
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
> bluetoothd[29947]: setup_free(0xb7fc8cd0)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: stream state changed: OPEN -> STREAMING
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
> bluetoothd[29947]: setup_free(0xb7fc8cd0)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
> bluetoothd[29947]: setup_free(0xb7fc8cd0)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM
> bluetoothd[29947]: avdtp_ref(0xb7fc7dd0): ref=4
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_ref(0xb7fc8cd0): ref=2
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_START_STREAM
> bluetoothd[29947]: Audio API: BT_RESPONSE -> BT_NEW_STREAM
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=1
> bluetoothd[29947]: setup_unref(0xb7fc8cd0): ref=0
> bluetoothd[29947]: setup_free(0xb7fc8cd0)
> bluetoothd[29947]: avdtp_unref(0xb7fc7dd0): ref=3
> bluetoothd[29947]: Audio API: BT_REQUEST <- BT_START_STREAM

-- 
Best regards,
Siarhei Siamashka
