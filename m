Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339886587.20079.2.camel@sirocco.config>
References: <1339886587.20079.2.camel@sirocco.config>
Date: Mon, 18 Jun 2012 11:30:08 +0300
Message-ID: <CABBYNZ+AkCc_1+dvi6HEKVA_5hhvVUB0wydbGgDdiKS5Yr+3Ag@mail.gmail.com>
Subject: Re: Broken bluez master
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Jun 17, 2012 at 1:43 AM, Bastien Nocera <hadess@hadess.net> wrote:
> Don't think I'm using a too weird development environment, trying to fix
> PS3 BD Remote bugs.
>
> Fedora 17 with kernel 3.4.0 and bluez master. Turns out it's unusable
> because of this commit:
> commit d22d083d6dd681f8d25eb806d4ec91853475ee06
> Author: Gustavo Padovan <gustavo@padovan.org>
> Date:   Thu Apr 5 16:22:55 2012 -0300
>
>    mgmt: update mgmt control channel id
>
>    kernel side has updated its control channel id from 1 to 3.
>
> Do we really need a devel kernel to work on user-space? Reverting this
> patch makes it work, I just wish I didn't spend my development time
> trying to find what was wrong with my system...

What exactly is broken, afaik it worked for me except with a headset
MW600 I got security block.

I guess we should have made clear in the ChangeLog since afaik we
broke compatibility with early version of mgmt thats why the channel
was changed.

-- 
Luiz Augusto von Dentz
