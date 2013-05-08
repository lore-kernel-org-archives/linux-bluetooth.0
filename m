Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
Date: Wed, 8 May 2013 17:25:59 +0300
Message-ID: <CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, May 8, 2013 at 2:47 AM, Alex Deymo <deymo@chromium.org> wrote:
> bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received SUSPEND_CMD
> bluetoothd[21017]: profiles/audio/a2dp.c:suspend_ind() Source
> 0x7f2acd437a00: Suspend_Ind
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
> state changed: STREAMING -> OPEN
> bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
> SINK_STATE_CONNECTED
> bluetoothd[21017]:
> profiles/audio/transport.c:transport_update_playing()
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 State=TRANSPORT_STATE_ACTIVE
> Playing=0
> bluetoothd[21017]:
> profiles/audio/transport.c:media_transport_remove_owner() Transport
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 Owner :1.1198
> bluetoothd[21017]: profiles/audio/transport.c:media_owner_free() Owner :1.1198
> bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
> TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
> bluetoothd[21017]: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP
> 0x7f2acd437a00 unlocked

There device request the stream to be suspended, which is what it
happens and the transport is then set to idle state which should
indicate to the endpoint what happened.

>
> bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
> bluetoothd[21017]: profiles/audio/a2dp.c:start_ind() Source
> 0x7f2acd437a00: Start_Ind
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_ref() 0x7f2acd43ce70: ref=3
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
> state changed: OPEN -> STREAMING
> bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_CONNECTED ->
> SINK_STATE_PLAYING
> bluetoothd[21017]:
> profiles/audio/transport.c:transport_update_playing()
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3 State=TRANSPORT_STATE_IDLE
> Playing=1
> bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
> TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_unref() 0x7f2acd43ce70: ref=2

Here it asks the stream to resume, transport state goes to pending
which normally triggers the endpoint to Acquire the fd.

>
> bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND
> request succeeded
> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
> state changed: STREAMING -> OPEN
> bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
> SINK_STATE_CONNECTED
> bluetoothd[21017]:
> profiles/audio/transport.c:transport_update_playing()
> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3
> State=TRANSPORT_STATE_PENDING Playing=0
> bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
> TRANSPORT_STATE_PENDING -> TRANSPORT_STATE_IDLE
> bluetoothd[21017]: profiles/audio/a2dp.c:suspend_cfm() Source
> 0x7f2acd437a00: Suspend_Cfm

The endpoint probably didn't acquire the fd so we suspend the stream.
Anyway the device is misbehaving if it is sending suspend and start
commands like that (perhaps you are pressing play/pause buttons?) but
if you don't wan't the stream to auto suspend you just need to Acquire
when the transport is in pending state.


--
Luiz Augusto von Dentz
