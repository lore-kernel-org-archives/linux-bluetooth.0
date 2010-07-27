Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C4EC2B5.2030204@hschmitt.de>
References: <4C4EC2B5.2030204@hschmitt.de>
Date: Tue, 27 Jul 2010 16:03:39 +0300
Message-ID: <AANLkTi=WSgMe86k-h=_HdzsPTZ=rK5ab5O9mYf8C6jnc@mail.gmail.com>
Subject: Re: obexd 0.29 and N900 PC Suite
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 27, 2010 at 2:27 PM, Harald Schmitt <linux@hschmitt.de> wrote:
> Hi,
>
> there are several users who test obexd 0.29 on the Nokia N900 running Maemo
> in order to have PBAP support. There are success reports with PBAP, but at
> the same time they cannot usb sync via Nokia PC Suite anymore. Is there any
> chance to get PC Suite working again in a future obexd version or does this
> depend on a non free Nokia code?
> Can you give any hints where to look at?
> In a forum a user posted success (with 0.19) and failure (with 0.29) logs:
> http://talk.maemo.org/showthread.php?p=763550#post763550

First thanks a lot for this feedback, I wasn't aware that there were
somebody trying to use newer version of obexd in N900, I will take a
look how I can make usb compatible with N900, actually it should be
just as bluetooth and work no matter which platform you are using but
we are not there yet :(

In the meantime you can try reverting the patch bellow and see if it helps:

http://git.kernel.org/?p=bluetooth/obexd.git;a=commitdiff;h=6f56a4355585eb29535782f977ba545cc41dd382

-- 
Luiz Augusto von Dentz
Computer Engineer
