Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
Date: Mon, 9 Aug 2010 12:31:46 +0300
Message-ID: <AANLkTinUKu+GrAnJvZoZmhcb9=6ZOxhTBZhRv5i5NKBs@mail.gmail.com>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 6, 2010 at 6:44 PM, Madhavi Manchala
<madhavi.linux@gmail.com> wrote:
> Dear All,
>
> I am trying to implement a custom voice codec on the android bluetooth
> platform by linking it, into the A2DP module. I have heard different
> versions from different people regarding the licenses (like LGPL and
> Apache License). So, before starting my work, I would like to know if
> I would be forced to reveal my source code, once I implement my codec
> on BlueZ stack. Please let me know, so that I can choose my platform,
> before starting my work.

If you are just implementing a new codec then you might have to link
to GPL code which basically makes your code GPL too, but we have plans
to support this over dbus which wouldn't require you to link to any
GPL, instead you register an endpoint which will be used to configure
streams.

This code can be found here:

http://gitorious.org/~vudentz/bluez/vudentzs-clone/commits/endpoint

This depend on dbus 1.3.1 and latter which will probably only reach
upstream once we have a dbus 1.4 release.

-- 
Luiz Augusto von Dentz
Computer Engineer
