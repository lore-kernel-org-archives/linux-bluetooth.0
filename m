Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jul 2010 20:16:49 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: obexd 0.29 and N900 PC Suite
Message-ID: <20100729181649.GA9339@joshua.mesa.nl>
References: <4C4EC2B5.2030204@xxxxxxxxxxx> <AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@xxxxxxxxxxxxxx>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 29, 2010 at 05:36:48PM +0200, Harald Schmitt wrote:
> Hi,
> 
> Am 27.07.2010 15:03, schrieb Luiz Augusto von Dentz:
> 
>     Hi,
> 
>     On Tue, Jul 27, 2010 at 2:27 PM, Harald Schmitt<linux@xxxxxxxxxxx>  wrote:
> 
>         Hi,
> 
>         there are several users who test obexd 0.29 on the Nokia N900 running Maemo
>         in order to have PBAP support. There are success reports with PBAP, but at
>         the same time they cannot usb sync via Nokia PC Suite anymore. Is there any
>         chance to get PC Suite working again in a future obexd version or does this
>         depend on a non free Nokia code?
>         Can you give any hints where to look at?
>         In a forum a user posted success (with 0.19) and failure (with 0.29) logs:
>         http://talk.maemo.org/showthread.php?p=763550#post763550
> 
>     First thanks a lot for this feedback, I wasn't aware that there were
>     somebody trying to use newer version of obexd in N900, I will take a
>     look how I can make usb compatible with N900, actually it should be
>     just as bluetooth and work no matter which platform you are using but
>     we are not there yet :(
> 
>     In the meantime you can try reverting the patch bellow and see if it helps:
> 
>     http://git.kernel.org/?p=bluetooth/obexd.git;a=commitdiff;h=6f56a4355585eb29535782f977ba545cc41dd382
> 
> Thanks for the hint. I built a package from 0.29, the patches from meego.gitorious.org and the reverted patch. Some from the community tested it and PC Suite via USB did work. Of course obexd had to be started with the added option "--capability !/usr/bin/gen-obex-capability.sh".
> 
> --
> Harald Schmitt

It seems the patch revert a conversion from unix signaling to dbus signaling.
The pcsuite-enable.sh script uses a unix signal to tell obexd a pcsuite
connection is requested.
Apperantly in meego this will be done using dbus..

Can't we convert pcsuite-enable.sh to also use dbus instead of reverting
the patch?  Can you help us out her Luiz?

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
