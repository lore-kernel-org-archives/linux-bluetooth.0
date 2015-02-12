Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54DC816C.2060806@my.bristol.ac.uk>
References: <54DC816C.2060806@my.bristol.ac.uk>
Date: Thu, 12 Feb 2015 15:12:32 +0200
Message-ID: <CABBYNZLjb4yf3iEC2HGBfaZsZ294wgTLfci9jq48Gc7VRT-Ygw@mail.gmail.com>
Subject: Re: NetworkServer1 exits when program exits
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christopher Bainbridge <cb0128@my.bristol.ac.uk>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christopher,

On Thu, Feb 12, 2015 at 12:33 PM, Christopher Bainbridge
<cb0128@my.bristol.ac.uk> wrote:
> Hi,
>
> I've been trying to get NetworkServer1 service working without using Python,
> as I'm working on a platform with limited resources. When I use dbus-send...
>
> dbus-send --system --type=method_call --dest=org.bluez --print-reply
> /org/bluez/hci0 org.bluez.NetworkServer1.Register string:nap string:tether
>
> I see the server registering, but then immediately unregistering. According
> to the API documentation (doc/network-api.txt), this is what is supposed to
> happen.
>
> Experimenting with Python on my PC, removing the 'unregister' line from the
> test-nap script makes no difference at all (I get no error that the NAP
> server is already registered, which I get if I run test-nap twice at the
> same time). But this then removes the need for the NetworkServer1.Unregister
> method call, and doesn't allow me to use dbus-send to enable the NAP server.

This has nothing to do with being already registered, see the real
reason bellow.

> May I suggest that the NetworkServer1.Register method call doesn't
> unregister when it exits? Or is there another way of registering a NAP
> server that doesn't involve dbus-send or Python?

When you register bluetoothd will start tracking your application
lifetime, actually the D-Bus connection, so in case your application
exits the does the cleanup automatically, which is the reason
dbus-send does not work since it exits immediately after done with the
commands. Removing this tracking would probably leave us with
unmanaged bridges which would require a totally different API to be
able to list and unregister them. If you want a real solution for NAP
you can check connman or similar solution for IP, it will stay
register a bridge for you and do the tethering with other technologies
such as WIFI, 3G and Ethernet.


-- 
Luiz Augusto von Dentz
