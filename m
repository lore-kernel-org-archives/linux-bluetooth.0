Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <147AA35329540D468455E185B7E55050D4FBE66D@valen.ka.netpioneer.de>
References: <147AA35329540D468455E185B7E55050D4FBE66D@valen.ka.netpioneer.de>
Date: Mon, 30 Nov 2015 10:44:20 +0200
Message-ID: <CABBYNZJXKVAvPjqBoObDtNGjqWMd2zCQv1R6_OJ34LTiR0qQYA@mail.gmail.com>
Subject: Re: org.bluez.Adapter1 Powered API causes UnknownMethod: Method "Set"
 with signature "ssb"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Matthias Schmidt <Matthias.Schmidt@netpioneer.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
