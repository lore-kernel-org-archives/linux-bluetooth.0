Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6edf6b480903100618k15f77f25p6c2ef1ab42b7b269@mail.gmail.com>
References: <6edf6b480903100602x6b84b8f3o8e2f3266e6b69c47@mail.gmail.com>
	 <6edf6b480903100618k15f77f25p6c2ef1ab42b7b269@mail.gmail.com>
Date: Thu, 12 Mar 2009 17:18:09 +0800
Message-ID: <6edf6b480903120218i6066199bx2f0dd6cad564f59f@mail.gmail.com>
Subject: Re: dund: how to config for handset platform
From: yesir yao <yesiryao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/3/10 yesir yao <yesiryao@gmail.com>:
> 2009/3/10 yesir yao <yesiryao@gmail.com>:
>> hi, all:
>>
> I am using bluez4 on my pxa310 handset platform.
> and I need to present dial-up network profile for my handset.
>
> after I run "dund --listen --dialup --msdun --nodetach"
> then, on my windows pc, using "IVT BlueSoleil",
> I can find the dial-up service present by my handset.
>
> but i cann't connect to the dial-up service by using BlueSoleil from my pc.
>
> so, my problem is : how to config dund daemon for handset/mobile phone ?
> thanks in advance !

why nobody reply my mails ? :-)

hi, all developer:
   Does bluez4.x implement the "Dial-up Networking Profile (Gateway)" ?
   in my pxa310 handset platform, ttyS0 is bluetooth chip, ttyS1 is a
gsm moderm.
now, I want to implement DUN (gateway) on my handset platform.
It is to say : pc(ppp) --> handset --> gsm (gprs) --> net
I have look through the bluez4.x/compat/dund.c,
and found it cann't meet my requirement.

is it right or not ? and how to fix it ?

thanks again !

Best regards
yesir Yao.
