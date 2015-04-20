Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABKPALoBuLSHyzWrULQADxq83McSoSeEh58FLhPwL_j5OLHwOQ@mail.gmail.com>
References: <CABKPALoBuLSHyzWrULQADxq83McSoSeEh58FLhPwL_j5OLHwOQ@mail.gmail.com>
Date: Mon, 20 Apr 2015 15:29:02 -0700
Message-ID: <CAHrH25TKwCouXPHHNmTWLAXyQoaymUPMOFqjT+gtZZ0ShkK2VA@mail.gmail.com>
Subject: Re: Running bluez on Raspberry Pi
From: Arman Uguray <armansito@chromium.org>
To: Neil Martin <neil@vnp.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

> On Sun, Apr 19, 2015 at 3:34 PM, Neil Martin <neil@vnp.com> wrote:
> I'm new to bluez and fairly green with Bluetooth in general.  I have
> built 5.30 on a Raspberry PI 2 running raspbian wheezy.  Here's the
> configure command that I used (arrived at by experimentation and
> Googling for various build problems I encountered):
>
> LDFLAGS=-lrt ./configure --disable-systemd --enable-experimental
> --enable-maintainer-mode
>
>
> The hci tools seem to work as expected.  Also btgatt-client works - I
> am able to connect to a BLE heart rate monitor and I see the HR
> related services.
>
>
> However, btgatt-server does not seem to do anything, but no errors
> reported either.  I'm running it like this:
>
> sudo ./btgatt-server -r
>
> and get this as the only output:
>
> Started listening on ATT channel. Waiting for connections
>
>
> I'm assuming that I should be seeing this advertising when I run
> hcitool lescan?  I don't see anything.  Also btmon shows no activity
> when I run btgatt-server.

Nope, btgatt-server doesn't configure anything related to advertising;
it simply sets up and attaches a GATT server to a listening L2CAP
socket on the ATT channel. So you need to set up advertising
separately, e.g. by running 'btmgmt advertising on' or 'btmgmt
add-adv'.

Note that you usually don't want to run btgatt-server while bluetoothd
is running since they will interfere with eachother.

>
>
> Additionally, if I try to run bluetoothd, I get the following output
> which doesn't look good!
>
>
> sudo ./bluetoothd -nE
>
> bluetoothd[19968]: Bluetooth daemon 5.30
> bluetoothd[19968]: Starting SDP server
> bluetoothd[19968]: Bluetooth management interface 1.7 initialized
> bluetoothd[19968]: Failed to obtain handles for "Service Changed" characteristic
> bluetoothd[19968]: Not enough free handles to register service
> bluetoothd[19968]: Error adding Link Loss service
> bluetoothd[19968]: Not enough free handles to register service
> bluetoothd[19968]: Not enough free handles to register service
> bluetoothd[19968]: Not enough free handles to register service
> bluetoothd[19968]: Current Time Service could not be registered
> bluetoothd[19968]: gatt-time-server: Input/output error (5)
> bluetoothd[19968]: Not enough free handles to register service
> bluetoothd[19968]: Not enough free handles to register service
>

We really need to clean these up. Basically bluetoothd fails to
register all the experimental local services since we changed the
internal plumbing to the new shared stack. Fwiw these are all plugins
that we are deprecating and the actual local GATT server will work
regardless.

Also, if you want the daemon running, I suggest using the GATT D-Bus
API for hosting your own services.

>
> I've done plenty of googling and not finding anything useful, so I'm
> hoping that someone here will have some insight.
>
> Thanks, Neil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks!
Arman
