Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Matthias Schmidt <Matthias.Schmidt@netpioneer.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: org.bluez.Adapter1 Powered API causes UnknownMethod: Method
 "Set" with signature "ssb"
Date: Mon, 30 Nov 2015 11:14:49 +0000
Message-ID: <147AA35329540D468455E185B7E55050D4FBF546@valen.ka.netpioneer.de>
References: <147AA35329540D468455E185B7E55050D4FBE66D@valen.ka.netpioneer.de>,<CABBYNZJXKVAvPjqBoObDtNGjqWMd2zCQv1R6_OJ34LTiR0qQYA@mail.gmail.com>
In-Reply-To: <CABBYNZJXKVAvPjqBoObDtNGjqWMd2zCQv1R6_OJ34LTiR0qQYA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I've managed to narrow things down a little bit: 

The Exception occurs with bluez 5.35 *and* 5.36 if i deliberately turn an interface off which is already powerd down. This power-down works some 3 - 5 times without any problems and then causes this exception after blocking some 10 seconds.

Here are my configure and startup parameters:

./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --disable-systemd --enable-experimental

./bluetoothd -E -n -d

As a workaround I read the power state before writing anything, but I really think this should behave deterministic ;-)

cheers,

Matthias

Senior Systemarchitekt
Netpioneer GmbH, Ludwig-Erhard-Allee 20, 76131 Karlsruhe
Geschäftsführer: Axel Jahn
HRB: 107521 Handelsregister Mannheim

Tel: 0721 / 9 20 60 822
Fax: 0721 / 9 20 60 30
E-Mail: matthias.schmidt@netpioneer.de
www: http://www.netpioneer.de

________________________________________
Von: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Gesendet: Montag, 30. November 2015 09:44
An: Matthias Schmidt
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: org.bluez.Adapter1 Powered API causes UnknownMethod: Method "Set" with signature "ssb"

Hi Matthias,

On Thu, Nov 26, 2015 at 2:13 PM, Matthias Schmidt
<Matthias.Schmidt@netpioneer.de> wrote:
> Hi *,
>
> while using the Powered API from the "org.bluez.Adapter1" interface in bluez 5.36 to turn BLE on and off
> i'm getting this exeception every now and then - could not figure out any pattern:
>
>     adapterInterface.Set(ADAPTER_IFACE, "Powered", state)
>   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
>     **keywords)
>   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
>     message, timeout)
> DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method "Set" with signature "ssb" on interface "org.freedesktop.DBus.Properties" doesn't exist

Is this something that used to work and stop working with 5.36? Btw
the signature of org.freedesktop.DBus.Properties is "ssv" so perhaps
that is the problem.

> I'm running Linux 4.1.2 on armv7l
>
> Is there any chance to nail this down?
>
> cheers,
>
> Matthias
>
> Senior Systemarchitekt
> Netpioneer GmbH, Ludwig-Erhard-Allee 20, 76131 Karlsruhe
> Geschäftsführer: Axel Jahn
> HRB: 107521 Handelsregister Mannheim
>
> Tel: 0721 / 9 20 60 822
> Fax: 0721 / 9 20 60 30
> E-Mail: matthias.schmidt@netpioneer.de
> www: http://www.netpioneer.de
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz
