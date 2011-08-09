Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE6600131C84B8E@dnce02.ent.ti.com>
References: <1310554946-765-1-git-send-email-iliak@ti.com>
	<20110713183142.GA23921@joana>
	<AC090B9732AB2B4DB7FF476E907FE66001318A5DDC@dnce02.ent.ti.com>
	<AC090B9732AB2B4DB7FF476E907FE6600131C84B8E@dnce02.ent.ti.com>
Date: Tue, 9 Aug 2011 15:27:05 +0300
Message-ID: <CABBYNZ+a0OjBd_+VKDMK01smt+J-WeKLBXhYvA=-6T26sUPp9g@mail.gmail.com>
Subject: Re: Question regarding SET_CONFIGURATION avdtp command handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/8/7 Ilia, Kolominsky <iliak@ti.com>:
> Hello!
> Can anybody help me to understand the process of handling avdtp
> SET_CONFIGURATION command in scenario when a2dp headset initializes
> connection to linux machine? I see that the headset sends
> SET_CONFIGURATION avdtp command (with appropriate SBC params),
> but i cant find out how this ultimately translates to actual
> configuration of a player (totem in my case).
>
> What layers are involved in general?
>
> I see that handling of the command follows the following path (approx.):
> avdtp.c::sbc_setconf_ind()
>        a2dp.c::auto_config()

If it went to sbc_setconf_ind it probably means the system is not
using Media API, so it auto configure but at this point nobody is
using it.

>                avdtp.c::avdtp_sep_set_state()
>                        a2dp.c::stream_state_changed()
>                        sink.c::stream_state_changed()

This will eventually wakeup interested process that need to connect
over unix socket (see audio/unix.c) to acquire the fd.

> At no stage I am able to spot the actual configuration of the sbc...
> (there should be probably some sort of d-bus messages, but, again,
> I don’t see that neither SelectConfiguration nor SetConfiguration
> from the media-api are used).

As I said according to your traces it is picking a bluetoothd internal
sep, so in that case it won't call SetConfiguration instead it will
auto configure using the local sep. Note that it could be you enabled
the Media API but forgot to disable the unix socket (Disable=Socket),
in that case you can have a mix of bluetoothd internal sep and
external seps (registered via Media API).

> In addition, there is BT_SET_CONFIGURATION command that is handled
> in unix.c (after SET_CONFIGURATION is handled); how does it fits
> in the configuration picture?

This is the old API, in this case the client is using our internal ipc
BT_SET_CONFIGURATION command to set its configuration, this could
match the current configuration (if it doesn't it does CLOSE and
SET_CONFIGURATION again).

> Any info (or reference where it can be found) will be much
> appreciated.

You can use test/simple-endpoint to emulate an MediaEndpoint (make
sure PulseAudio don't interfere), for the old API (not recommended)
you can take a look at test/ipctest.c

-- 
Luiz Augusto von Dentz
