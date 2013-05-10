Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
	<CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
	<CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com>
Date: Fri, 10 May 2013 11:09:21 +0300
Message-ID: <CABBYNZJNxEnKk-E5TcSwwNwkeBDhbsBgyMUJ_MuL02-MeV_i1Q@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 9, 2013 at 7:40 AM, Alex Deymo <deymo@chromium.org> wrote:
> Hi Luiz,
>
> On Wed, May 8, 2013 at 7:25 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Alex,
>>
>> On Wed, May 8, 2013 at 2:47 AM, Alex Deymo <deymo@chromium.org> wrote:
>>> bluetoothd[21017]: profiles/audio/avdtp.c:session_cb()
>>> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_parse_resp() SUSPEND
>>> request succeeded
>>> bluetoothd[21017]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
>>> state changed: STREAMING -> OPEN
>>> bluetoothd[21017]: profiles/audio/sink.c:sink_set_state() State
>>> changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED: SINK_STATE_PLAYING ->
>>> SINK_STATE_CONNECTED
>>> bluetoothd[21017]:
>>> profiles/audio/transport.c:transport_update_playing()
>>> /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3
>>> State=TRANSPORT_STATE_PENDING Playing=0
>>> bluetoothd[21017]: profiles/audio/transport.c:transport_set_state()
>>> State changed /org/bluez/hci0/dev_10_B7_F6_01_31_ED/fd3:
>>> TRANSPORT_STATE_PENDING -> TRANSPORT_STATE_IDLE
>>> bluetoothd[21017]: profiles/audio/a2dp.c:suspend_cfm() Source
>>> 0x7f2acd437a00: Suspend_Cfm
>>
>> The endpoint probably didn't acquire the fd so we suspend the stream.
>> Anyway the device is misbehaving if it is sending suspend and start
>> commands like that (perhaps you are pressing play/pause buttons?) but
>> if you don't wan't the stream to auto suspend you just need to Acquire
>> when the transport is in pending state.
>
> I did call org.bluez.MediaTransport1.Acquire before all this and the
> State went to active at that point and music was playing well. Then
> with the SUSPEND_CMD I see the State property going from active to
> idle and later from idle to pending (and later to suspend)  If I
> understand well from what you say... Should I call Acquire again on
> the same /fd3 when I see the State going to pending?? Should I also
> Release it before? (for example when I see the State going to idle?) I
> don't see a clear answer from the doc/.

Yes, you should release the fd once the state change to idle, in the
future we might actually use frevoke (http://lwn.net/Articles/192632/)
to revoke the permissions but for now we have to assume the endpoint
will behave and close whenever the transport became idle. You are also
right, we should probably update the documentation to state the fd is
considered revoked in this case and the endpoint has to acquired
again. Btw PulseAudio does that already so Im curious why you are not
using PA, or is this for another Audio daemon?


--
Luiz Augusto von Dentz
