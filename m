Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180914164258.GA8745@amd>
References: <20180914164258.GA8745@amd>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 15 Sep 2018 15:29:43 +0300
Message-ID: <CABBYNZ+k+250iZUJNVOBHgZfpK8Qho9i3YNeYbvvR7pDp2Ab1Q@mail.gmail.com>
Subject: Re: bluez from git: does not compile, bluetoothd crashes
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Fri, Sep 14, 2018 at 7:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I have version e4cf43fc62b4e4dbabc72d4e44e095d7a9087992.
>
> It did not compile, so I did this:
>
> gcc --version
> gcc (Debian 4.9.2-10+deb8u1) 4.9.2

What is the compilation error?

> diff --git a/monitor/display.h b/monitor/display.h
> index 12d13f8..ca85dcc 100644
> --- a/monitor/display.h
> +++ b/monitor/display.h
> @@ -70,6 +70,7 @@ struct bitfield_data {
>         const char *str;
>  };
>
> +#ifdef WANT_BITFIELD
>  inline uint64_t print_bitfield(int indent, uint64_t val,
>                                 const struct bitfield_data *table)
>  {
> @@ -85,6 +86,7 @@ inline uint64_t print_bitfield(int indent, uint64_t val,
>
>         return mask;
>  }
> +#endif
>
>  int num_columns(void);
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index aca0761..21fc1dc 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -26,6 +26,7 @@
>  #include <config.h>
>  #endif
>
> +#define WANT_BITFIELD
>  #include <stdio.h>
>  #include <errno.h>
>  #include <ctype.h>
>
> Possibly not nicest fix but it got me version that compiled.
>
> I was trying to play with btle, but bluetoothd crashed. That can't be
> good.
>
> pavel@amd:~/denx/bt/bluez$ sudo src/bluetoothd
> *** Error in `src/bluetoothd': free(): invalid size: 0x08162908 ***
>
> Syslog says:
>
> pavel@amd:~/denx/bt/bluez$ sudo tail /var/log/syslog
> Sep 14 18:38:59 amd dbus[2801]: [system] Activating via systemd:
> service name='org.bluez' unit='dbus-org.bluez.service'
> Sep 14 18:38:59 amd systemd[1]: Starting Bluetooth service...
> Sep 14 18:38:59 amd bluetoothd[8731]: Bluetooth daemon 5.23
> Sep 14 18:38:59 amd dbus[2801]: [system] Successfully activated
> service 'org.bluez'
> Sep 14 18:38:59 amd systemd[1]: Started Bluetooth service.
> Sep 14 18:38:59 amd bluetoothd[8731]: Starting SDP server
> Sep 14 18:39:00 amd bluetoothd[8731]: Bluetooth management interface
> 1.14 initialized
> Sep 14 18:39:00 amd bluetoothd[8731]: Sap driver initialization
> failed.
> Sep 14 18:39:00 amd bluetoothd[8731]: sap-server: Operation not
> permitted (1)
> Sep 14 18:39:01 amd dbus[2801]: [system] Failed to activate service
> 'org.freedesktop.hostname1': timed out

Try running with valgrind perhaps we are not handling the timeout properly.

> Any ideas?
>
> Thanks,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Luiz Augusto von Dentz
