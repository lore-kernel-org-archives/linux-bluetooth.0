Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
	<CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
	<CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
	<CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
Date: Wed, 5 Oct 2011 18:38:33 +0300
Message-ID: <CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Wed, Oct 5, 2011 at 6:20 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> On Wed, Oct 5, 2011 at 5:17 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>>> By removing this it wont flush on EOS, so Im not sure why you removed
>>> it since OBEX_EV_REQ is only generated for the request not for the
>>> streams itself. Actually if OpenOBEX had an event for that represent
>>> the FINAL bit that would solve the problem with unknown size, but for
>>> gobex this is exposed directly in the callback so I wouldn't change
>>> that now.
>>>
>>>
>>> You got this wrong, the purpose of this code is to flush on end of
>>> stream not in the beginning/put request, so if we have consecutive
>>> puts the last packet should cause a flush so the driver can sync any
>>> buffered data before close which needs to be immediately.
>>
>> Again, OBEX_EV_REQ will be the very _last_ thing called. This code
>> flushes after all write()-s. After the final packet.
>
> To be specific: the order of events from openobex are OBEX_EV_REQHINT,
> OBEX_EV_REQCHECK, multiple OBEX_EV_STREAMAVAIL (as we are starting
> streaming in REQHINT), and then OBEX_EV_REQ.

I don't think this is true, if it was then why would we call
service->put on the end of stream and I also never see this happening
in practice e.g. calling ftp_put in the end of stream.

-- 
Luiz Augusto von Dentz
