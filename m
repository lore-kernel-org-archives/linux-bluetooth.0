Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Feb 2014 16:36:06 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Alejandro Exojo <aexojo@modpow.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How do you install bluez for development?
Message-ID: <20140203183606.GA12511@molly>
References: <CACMtdhhCecEWiK33A6uNSQr-=iRJSehfbJCqb0Maxpq-8WjkPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACMtdhhCecEWiK33A6uNSQr-=iRJSehfbJCqb0Maxpq-8WjkPA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alejandro,

On 17:21 Mon 03 Feb, Alejandro Exojo wrote:
> Hi.
>
> I want to build a recent bluez, since I need the DualShock support.
> I'm used to play with PATH, LD_LIBRARY_PATH and other stuff, so I tend
> to install what I've built in /opt/foo or even in a subdirectory in my
> /home, but I'm missing something, maybe obvious, to start bluetoothd.
>
> I've built fine with   ./configure --prefix=/ --enable-sixaxis &&
> DESTDIR=/opt/bluez5 make install.
>
> Then I've configured everything I saw that bluez installs:
>
> * /opt/bluez5/etc/dbus-1/system.d/bluetooth.conf  (sourced from the
> stuff in /etc)
> * /lib/udev  (I've symlinked the two files, just in case)
> * /etc/systemd/system/bluetooth.service  (points to the service file
> provided by bluez, with the proper path for bluetoothd).
>
> With that the service starts, but stops immediately. This is what I've
> get in the log when plugging the adapter (or forcing a manual
> startup):
>
> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth service...
> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Bluetooth daemon 5.14
> Feb 03 17:14:38 PC-MW03 systemd[1]: Started Bluetooth service.
> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth.
> Feb 03 17:14:38 PC-MW03 systemd[1]: Reached target Bluetooth.
> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Failed to access management interface

Two probable causes, your kernel is older than 3.4, or the user that is running
bluetoothd doesn't have the CAP_NET_ADMIN capability.

> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Adapter handling
> initialization failed
> Feb 03 17:14:38 PC-MW03 systemd[1]: bluetooth.service: main process
> exited, code=exited, status=1/FAILURE
>
>
> Any hints? Or should I just give up and install everything in /usr,
> possibly clashing files from other installations like packages?
>
> Thank you.
>
> --
> Alejandro Exojo Piqueras
>
> ModpoW, S.L.
> Technova LaSalle | Sant Joan de la Salle 42 | 08022 Barcelona | www.modpow.es
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
