Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikFQiEEVKA=9UnxzeunAPEviWQnjYcH=q6rfhjA@mail.gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
	<AANLkTinUKu+GrAnJvZoZmhcb9=6ZOxhTBZhRv5i5NKBs@mail.gmail.com>
	<AANLkTikFQiEEVKA=9UnxzeunAPEviWQnjYcH=q6rfhjA@mail.gmail.com>
Date: Tue, 10 Aug 2010 10:49:47 +0300
Message-ID: <AANLkTin77QjQ5KGyLmMNZeAdaC+Bs9Ny97pWEBLO39FY@mail.gmail.com>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: Madhavi Manchala <madhavi.linux@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 9, 2010 at 10:37 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> As long as we are updating, can the liba2dp be abstracted out of not
> only the sbc encoding part but also the sending over UART part (as in
> transport ...)
>
> chips are getting smarter and the sbc codecs are moving to either a
> co-processor/dsp or even inside the BT chip itself, so we might have
> to send the PCM raw data somewhere else for the dsp to encode to sbc
> and send it over the air ...
>
> currently the data (sbc/pcm) and the control (connection
> establishment) is too tightly sort of coded in together.. isn't it ?
>
> for something like the above to happen our liba2dp had to be almost
> re-written ...

Im afraid liba2dp is some android specific thing, not upstream, and as
I said before upstream is probably going to use dbus to pass the fd
around, so this is probably not relevant here.

-- 
Luiz Augusto von Dentz
Computer Engineer
