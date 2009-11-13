Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100911130536p27acb9b1ob4b566e43afef321@mail.gmail.com>
References: <0463F45F3606F4428ED35AC8C709F92E089CA6A628@pdsmsx502.ccr.corp.intel.com>
	 <0463F45F3606F4428ED35AC8C709F92E089CD174BB@pdsmsx502.ccr.corp.intel.com>
	 <2d5a2c100911130536p27acb9b1ob4b566e43afef321@mail.gmail.com>
Date: Fri, 13 Nov 2009 11:54:03 -0200
Message-ID: <6b53b1990911130554r6ea0a764m9c4670afd850f89@mail.gmail.com>
Subject: Re: [PATCH] oFonoHFP profile to enable audio routing in BlueZ
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Nov 13, 2009 at 11:36 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> 2009/11/12 Zhang, Zhenhua <zhenhua.zhang@intel.com>:
>> Hi,
>>
>> Ops, forgot to add ofono-hfp.c into BlueZ patch. So I add them and
>> resend 0001 patch.
>>
>> linux-bluetooth-owner@vger.kernel.org wrote:
>>> Hi,
>>>
>>> These three patches are created to enable audio routing for Handsfree
>>> Profile. It was created during the voicecall driver implementation in
>>> oFono so it does not use the new hfp-api yet. You can take it
>>> as reference only since it will not be commited into trunk.
>>>
>>> Basically, a new profile oFonoHFP was added to create RFCOMM
>>> connection and turn IO into TTY device for oFono. It sends TTY
>>> device string to oFono through D-Bus. Meanwhile, it listens
>>> oFono property changes to emit CallStarted and CallEnded
>>> signals. PulseAudio could listen these signals and redirect
>>> audio source/sink to use bluetooth one.
>>>
>>> If you are interested at it, you may apply 0001..0003 into
>>> BlueZ, oFono and PA respectively. Last commit SHA-1 is in patch note.
>>>
>>> And you need to enable oFonoHFP by modify audio.conf: а а а а Disable=Gateway
>>> а а а Enable=oFonoHFP, Headset
>>>
>>> In ofono modem.conf, specify device address like:
>>> а а а [hfp]
>>> а а а Driver=hfp
>>> а а а Address=00:22:A9:8C:AF:34
>>>
>>> And power on modem by:
>>> а а а dbus-send --system --print-reply --dest=org.ofono /hfp0
>>> org.ofono.Modem.SetProperty string:Powered variant:boolean:true
>>>
>>> The PulseAudio will load module-bluetooth-discover
>>> automatically. If not, please load it manually. This module
>>> listens BlueZ signal and load module-bluetooth-device
>>> automatically. Unfortunately, you need to load module-loopback
>>> manually to redirect bluez source/sink to alsa, e.g.:
>>> а а а load-module module-loopback source="bluez_source.XX..XX"
>>> sink="alsa_output.0.analog-stereo"
>>> а а а load-module module-loopback source="alsa_input.0.analog-stereo"
>>> sink="bluez_sink.XX..XX"
>>>
>>> Feel free to let me know if any problems. Thanks.
>
> What happened with the original idea from Denis, I don't think
> oFonoHFP is a good name to start with and it should be a generic
> interface where any telephony agent could register.

Zhenhua did these patches before the new API spec. I'll help Zhenhua
to move this code to the new API.
It's here just for test.

>
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computaчуo
>



-- 
Gustavo F. Padovan
http://padovan.org
