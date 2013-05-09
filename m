Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
 <CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Wed, 8 May 2013 21:40:29 -0700
Message-ID: <CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, May 8, 2013 at 7:25 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Alex,
>
> On Wed, May 8, 2013 at 2:47 AM, Alex Deymo <deymo@chromium.org> wrote:
>> bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND
>> request succeeded
>> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
>> state changed: STREAMING -> OPEN
>> bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
>> changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
>> SINK_STATE_CONNECTED
>> bluetoothd[21017]:
>> profiles/audio/transport.c:transport_update_playing()
>> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3
>> State=TRANSPORT_STATE_PENDING Playing=0
>> bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
>> State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
>> TRANSPORT_STATE_PENDING -> TRANSPORT_STATE_IDLE
>> bluetoothd[21017]: profiles/audio/a2dp.c:suspend_cfm() Source
>> 0x7f2acd437a00: Suspend_Cfm
>
> The endpoint probably didn't acquire the fd so we suspend the stream.
> Anyway the device is misbehaving if it is sending suspend and start
> commands like that (perhaps you are pressing play/pause buttons?) but
> if you don't wan't the stream to auto suspend you just need to Acquire
> when the transport is in pending state.

I did call org.bluez.MediaTransport1.Acquire before all this and the
State went to active at that point and music was playing well. Then
with the SUSPEND_CMD I see the State property going from active to
idle and later from idle to pending (and later to suspend)  If I
understand well from what you say... Should I call Acquire again on
the same /fd3 when I see the State going to pending?? Should I also
Release it before? (for example when I see the State going to idle?) I
don't see a clear answer from the doc/.

Thanks for the help!
Alex.
