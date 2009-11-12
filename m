Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089CA6A628@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E089CA6A628@pdsmsx502.ccr.corp.intel.com>
Date: Thu, 12 Nov 2009 14:48:31 -0200
Message-ID: <6b53b1990911120848v33eaa21bm51238bc46de2bfa7@mail.gmail.com>
Subject: Re: [PATCH] oFonoHFP profile to enable audio routing in BlueZ
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhenhua,

2009/11/12 Zhang, Zhenhua <zhenhua.zhang@intel.com>:
> Hi,
>
> These three patches are created to enable audio routing for Handsfree Profile.
> It was created during the voicecall driver implementation in oFono so it does
> not use the new hfp-api yet. You can take it as reference only since it will
> not be commited into trunk.

You forgot to include ofono-hfp.h into the BlueZ patch.

>
> Basically, a new profile oFonoHFP was added to create RFCOMM connection
> and turn IO into TTY device for oFono. It sends TTY device string to oFono
> through D-Bus. Meanwhile, it listens oFono property changes to emit CallStarted
> and CallEnded signals. PulseAudio could listen these signals and redirect audio
> source/sink to use bluetooth one.
>
> If you are interested at it, you may apply 0001..0003 into BlueZ, oFono and PA
> respectively. Last commit SHA-1 is in patch note.
>
> And you need to enable oFonoHFP by modify audio.conf:
>        Disable=Gateway
>        Enable=oFonoHFP, Headset
>
> In ofono modem.conf, specify device address like:
>        [hfp]
>        Driver=hfp
>        Address=00:22:A9:8C:AF:34
>
> And power on modem by:
>        dbus-send --system --print-reply --dest=org.ofono /hfp0
> org.ofono.Modem.SetProperty string:Powered variant:boolean:true
>
> The PulseAudio will load module-bluetooth-discover automatically. If not,
> please load it manually. This module listens BlueZ signal and load
> module-bluetooth-device automatically. Unfortunately, you need to load
> module-loopback manually to redirect bluez source/sink to alsa, e.g.:
>        load-module module-loopback source="bluez_source.XX..XX"
> sink="alsa_output.0.analog-stereo"
>        load-module module-loopback source="alsa_input.0.analog-stereo"
> sink="bluez_sink.XX..XX"
>
> Feel free to let me know if any problems. Thanks.
>
> Regards,
> Zhenhua
>
>



-- 
Gustavo F. Padovan
http://padovan.org
