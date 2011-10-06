Return-Path: <cyrus@holtmann.org>
Message-ID: <20111006121057.126252wjxrc55ukg@mail.hendrik-sattler.de>
Date: Thu, 06 Oct 2011 12:10:57 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver
 flush()
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
 <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
 <CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
 <CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
 <CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
 <CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
 <20111006094430.20945f35guft5q4g@mail.hendrik-sattler.de>
 <CABBYNZLBi_3sAohSShnHTfayd=g0VqZ2CYJC=5qfHBQiHcQsSg@mail.gmail.com>
In-Reply-To: <CABBYNZLBi_3sAohSShnHTfayd=g0VqZ2CYJC=5qfHBQiHcQsSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> On Thu, Oct 6, 2011 at 10:44 AM, Hendrik Sattler
> <post@hendrik-sattler.de> wrote:
>> The order is correct. Actually, with openobex-1.5 it may happen that you see
>> one OBEX_EV_STREAMAVAIL before OBEX_EV_REQCHECK if a BODY header is included
>> in the first packet, and no OBEX_EV_REQCHECK if the PUT has only one packet.
>>
>> However, for current git (if a new version is ever going to be released),
>> this order is strictly correct if the request is not aborted before being
>> complete.
>
> Yep, so obexd is broken for quite some time, since we do check also on
> OBEX_EV_REQ, but the documentation is not very clear about it since it
> says:
>
> /* An incoming request has arrived */
>
> Also it doesn't help that OpenOBEX has tree events with similar
> interpretation and probably because REQCHECK is not always generate we
> had to have a proper check also on REQ too.

Ask Marcel why there is no new release of OpenOBEX! This could have  
been fixed for months.

> Well I guess this is another reason to move on and start porting the server
> side to gobex which is much more mainloop friendly and less confusing is this
> aspect.

s/mainloop/glib/

HS


