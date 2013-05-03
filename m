Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1367532265-26766-1-git-send-email-deymo@chromium.org>
References: <1367532265-26766-1-git-send-email-deymo@chromium.org>
Date: Fri, 3 May 2013 12:38:54 +0300
Message-ID: <CABBYNZJ5=gLRTdD=Ggi3VN62tM4E77BTw3G6FszcLqXjtV-Jqg@mail.gmail.com>
Subject: Re: [PATCH] audio: Don't create an avctp session on avrcp disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"keybuk@chromium.org" <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, May 3, 2013 at 1:04 AM, Alex Deymo <deymo@chromium.org> wrote:
> If a paired and connected audio device is disconnected, the
> avrcp_disconnect() could create a new avctp session that will keep
> a reference to the corresponding btd_device, preventing it to be
> removed as explained below. This fix prevents avrcp_disconnect()
> to create a new and disconnected avctp session when it doesn't
> exists.
>
> Calling org.bluez.Device1.Disconnect on an audio device like the
> "Monster ClarityHD" will cause first a a2dp_sink_disconnect() call,
> and then a sink_disconnect() call.
> This will change the state of the existing avdtp session to
> AVCTP_STATE_DISCONNECTED triggering a series of callback calls.
> Among those, the avdtp_set_state() function will call the registered
> avdtp_callbacks, including avdtp_state_callback() which in turns
> updates the disconnected state using sink_set_state(). This function
> will call the registered sink_callbacks, including device_sink_cb().
>
> By this point, the device_sink_cb() will attempt a avrcp_disconnect()
> over a session that was already disconnected before by the device's
> diconnect_cb(). This new avrcp_disconnect() causes the avctp_get() to
> create a new avctp session that holds a reference to the disconnecting
> btd_device.
>
> Steps to reproduce using bluetoothctl:
> 1. Pair and Connect a Monter ClarityHD audio device.
> 2. Play some music on it.
> 3. Disconnect the device.
> 4. Remove the device.
> The "remove" command succeeds, but bluetoothd does not sends a removal
> signal ([DEL] message) for that device.
> ---
>  profiles/audio/avctp.c   | 13 ++++++++-----
>  profiles/audio/avctp.h   |  2 +-
>  profiles/audio/avrcp.c   |  2 +-
>  profiles/audio/control.c |  2 +-
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> Some extra debug output after calling disconnect (step 3):
>
> bluetoothd[3590]: profiles/audio/manager.c:a2dp_sink_disconnect() path /org/bluez/hci0/dev_10_B7_F6_01_31_ED
> bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() shutdown=0
> bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() will call avdtp_close
> bluetoothd[3590]: profiles/audio/device.c:disconnect_cb() will call avrcp_disconnect
> bluetoothd[3590]: profiles/audio/avrcp.c:avrcp_disconnect() will call avctp_get
> bluetoothd[3590]: profiles/audio/avctp.c:avctp_get() will call avctp_get_internal
> bluetoothd[3590]: profiles/audio/avrcp.c:state_changed() old_state=AVCTP_STATE_CONNECTED new_state=AVCTP_STATE_DISCONNECTED
> bluetoothd[3590]: profiles/audio/avrcp.c:session_tg_destroy() 0x7f6487282840
> bluetoothd[3590]: src/device.c:device_profile_connected() audio-avrcp-control Input/output error (5)
> bluetoothd[3590]: profiles/audio/control.c:state_changed() old_state=AVCTP_STATE_CONNECTED  new_state=AVCTP_STATE_DISCONNECTED
> bluetoothd[3590]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
> bluetoothd[3590]: profiles/audio/avctp.c:avctp_disconnected() will call btd_device_unref
> bluetoothd[3590]: src/device.c:btd_device_unref() device=10:B7:F6:01:31:ED ref=3
> bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() shutdown=1
> bluetoothd[3590]: profiles/audio/sink.c:sink_disconnect() will call avdtp_close
> bluetoothd[3590]: avdtp_close: rejecting since close is already initiated
> bluetoothd[3590]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_parse_resp() CLOSE request succeeded
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> CLOSING
> bluetoothd[3590]: profiles/audio/a2dp.c:close_cfm() Source 0x7f6487279600: Close_Cfm
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CLOSING -> IDLE
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_unref() 0x7f648727d480: ref=1
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_unref() 0x7f648727d480: ref=0
> bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() Disconnected from 10:B7:F6:01:31:ED
> bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() will call avdtp_set_state(0x7f648727d480, AVDTP_SESSION_STATE_DISCONNECTED)
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_set_state() Calling callback cb=0x7f6486003810, dev=0x7f648727fa60, session=0x7f648727d480
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_set_state() Calling callback cb=0x7f64860049d0, dev=0x7f648727fa60, session=0x7f648727d480
> bluetoothd[3590]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTED -> SINK_STATE_DISCONNECTED
> bluetoothd[3590]: profiles/audio/device.c:device_sink_cb() will call avrcp_disconnect
> bluetoothd[3590]: profiles/audio/avrcp.c:avrcp_disconnect() will call avctp_get
> bluetoothd[3590]: profiles/audio/avctp.c:avctp_get() will call avctp_get_internal
> bluetoothd[3590]: profiles/audio/avctp.c:avctp_get_internal() will call btd_device_ref , session=0x7f648727f700
> bluetoothd[3590]: src/device.c:btd_device_ref() device=10:B7:F6:01:31:ED ref=4
> bluetoothd[3590]: profiles/audio/avdtp.c:connection_lost() will call btd_device_unref
> bluetoothd[3590]: src/device.c:btd_device_unref() device=10:B7:F6:01:31:ED ref=3
> bluetoothd[3590]: profiles/audio/avdtp.c:avdtp_free() 0x7f648727d480
> bluetoothd[3590]: src/adapter.c:dev_disconnected() Device 10:B7:F6:01:31:ED disconnected, reason 2
> bluetoothd[3590]: src/adapter.c:adapter_remove_connection()
> bluetoothd[3590]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 10:B7:F6:01:31:ED type 0 status 0xe
> bluetoothd[3590]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> bluetoothd[3590]: src/device.c:device_bonding_failed() status 14
> bluetoothd[3590]: src/adapter.c:resume_discovery()

Thanks for the very descriptive analysis, but I would fix the problem
in a different way:

 diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 11e1455..5423645 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -172,7 +172,7 @@ static void disconnect_cb(struct btd_device
*btd_dev, gboolean removal,

        device_remove_control_timer(dev);

-       if (dev->control)
+       if (dev->control && priv->avctp_state != AVCTP_STATE_DISCONNECTED)
                avrcp_disconnect(dev);

        if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
@@ -243,7 +243,8 @@ static void device_sink_cb(struct audio_device *dev,
        case SINK_STATE_DISCONNECTED:
                if (dev->control) {
                        device_remove_control_timer(dev);
-                       avrcp_disconnect(dev);
+                       if (priv->avctp_state != AVCTP_STATE_DISCONNECTED)
+                               avrcp_disconnect(dev);
                }

                device_set_state(dev, AUDIO_STATE_DISCONNECTED);
