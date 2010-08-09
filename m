Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinUKu+GrAnJvZoZmhcb9=6ZOxhTBZhRv5i5NKBs@mail.gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
	<AANLkTinUKu+GrAnJvZoZmhcb9=6ZOxhTBZhRv5i5NKBs@mail.gmail.com>
Date: Mon, 9 Aug 2010 14:37:11 -0500
Message-ID: <AANLkTikFQiEEVKA=9UnxzeunAPEviWQnjYcH=q6rfhjA@mail.gmail.com>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Pavan Savoy <pavan_savoy@sify.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Madhavi Manchala <madhavi.linux@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As long as we are updating, can the liba2dp be abstracted out of not
only the sbc encoding part but also the sending over UART part (as in
transport ...)

chips are getting smarter and the sbc codecs are moving to either a
co-processor/dsp or even inside the BT chip itself, so we might have
to send the PCM raw data somewhere else for the dsp to encode to sbc
and send it over the air ...

currently the data (sbc/pcm) and the control (connection
establishment) is too tightly sort of coded in together.. isn't it ?

for something like the above to happen our liba2dp had to be almost
re-written ...

On 8/9/10, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Aug 6, 2010 at 6:44 PM, Madhavi Manchala
> <madhavi.linux@gmail.com> wrote:
>> Dear All,
>>
>> I am trying to implement a custom voice codec on the android bluetooth
>> platform by linking it, into the A2DP module. I have heard different
>> versions from different people regarding the licenses (like LGPL and
>> Apache License). So, before starting my work, I would like to know if
>> I would be forced to reveal my source code, once I implement my codec
>> on BlueZ stack. Please let me know, so that I can choose my platform,
>> before starting my work.
>
> If you are just implementing a new codec then you might have to link
> to GPL code which basically makes your code GPL too, but we have plans
> to support this over dbus which wouldn't require you to link to any
> GPL, instead you register an endpoint which will be used to configure
> streams.
>
> This code can be found here:
>
> http://gitorious.org/~vudentz/bluez/vudentzs-clone/commits/endpoint
>
> This depend on dbus 1.3.1 and latter which will probably only reach
> upstream once we have a dbus 1.4 release.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
