Return-Path: <cyrus@holtmann.org>
Message-ID: <4C51A010.3050500@hschmitt.de>
Date: Thu, 29 Jul 2010 17:36:48 +0200
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: obexd 0.29 and N900 PC Suite
References: <4C4EC2B5.2030204@hschmitt.de> <AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@mail.gmail.com>
In-Reply-To: <AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Am 27.07.2010 15:03, schrieb Luiz Augusto von Dentz:
> Hi,
>
> On Tue, Jul 27, 2010 at 2:27 PM, Harald Schmitt<linux@hschmitt.de>  wrote:
>> Hi,
>>
>> there are several users who test obexd 0.29 on the Nokia N900 running Maemo
>> in order to have PBAP support. There are success reports with PBAP, but at
>> the same time they cannot usb sync via Nokia PC Suite anymore. Is there any
>> chance to get PC Suite working again in a future obexd version or does this
>> depend on a non free Nokia code?
>> Can you give any hints where to look at?
>> In a forum a user posted success (with 0.19) and failure (with 0.29) logs:
>> http://talk.maemo.org/showthread.php?p=763550#post763550
>
> First thanks a lot for this feedback, I wasn't aware that there were
> somebody trying to use newer version of obexd in N900, I will take a
> look how I can make usb compatible with N900, actually it should be
> just as bluetooth and work no matter which platform you are using but
> we are not there yet :(
>
> In the meantime you can try reverting the patch bellow and see if it helps:
>
> http://git.kernel.org/?p=bluetooth/obexd.git;a=commitdiff;h=6f56a4355585eb29535782f977ba545cc41dd382
>

Thanks for the hint. I built a package from 0.29, the patches from 
meego.gitorious.org and the reverted patch. Some from the community 
tested it and PC Suite via USB did work. Of course obexd had to be 
started with the added option "--capability 
!/usr/bin/gen-obex-capability.sh".

--
Harald Schmitt
