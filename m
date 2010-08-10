Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin77QjQ5KGyLmMNZeAdaC+Bs9Ny97pWEBLO39FY@mail.gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
	<AANLkTinUKu+GrAnJvZoZmhcb9=6ZOxhTBZhRv5i5NKBs@mail.gmail.com>
	<AANLkTikFQiEEVKA=9UnxzeunAPEviWQnjYcH=q6rfhjA@mail.gmail.com>
	<AANLkTin77QjQ5KGyLmMNZeAdaC+Bs9Ny97pWEBLO39FY@mail.gmail.com>
Date: Tue, 10 Aug 2010 10:14:24 -0500
Message-ID: <AANLkTim_brBEY0LXZE4-3nYD3oxc-+UDcotqKDEcd2e0@mail.gmail.com>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Pavan Savoy <pavan_savoy@sify.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Madhavi Manchala <madhavi.linux@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 10, 2010 at 2:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Mon, Aug 9, 2010 at 10:37 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
>> As long as we are updating, can the liba2dp be abstracted out of not
>> only the sbc encoding part but also the sending over UART part (as in
>> transport ...)
>>
>> chips are getting smarter and the sbc codecs are moving to either a
>> co-processor/dsp or even inside the BT chip itself, so we might have
>> to send the PCM raw data somewhere else for the dsp to encode to sbc
>> and send it over the air ...
>>
>> currently the data (sbc/pcm) and the control (connection
>> establishment) is too tightly sort of coded in together.. isn't it ?
>>
>> for something like the above to happen our liba2dp had to be almost
>> re-written ...
>
> Im afraid liba2dp is some android specific thing, not upstream, and as
> I said before upstream is probably going to use dbus to pass the fd
> around, so this is probably not relevant here.

May be but isn't the same in pcm_bluetooth plugin too ?
If I had to support such a feature where I am only bothered about the
connection/control path and don't have to bother about data, how best
can I make use of this pcm_bluetooth ?

Specifically, I need something only to set-up the stream and the
bluetoothd being in START_STREAM sort of state, and the data is being
pumped into say another alsa-sink which is connected to dsp's pcm
input or h/w sbc encoder's pcm input.

PS:
sorry for the noise... i am just thinking aloud here,
And yes we do have a sort of working way on bluez to support such
things, but it involves hacked up code where we sort of comment out
the pieces of code...

> Luiz Augusto von Dentz
> Computer Engineer
>
