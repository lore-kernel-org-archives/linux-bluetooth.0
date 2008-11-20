Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811201545q519404c1y3189a15907e5b2fe@mail.gmail.com>
Date: Thu, 20 Nov 2008 23:45:11 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: "Johan Hedberg" <johan.hedberg@nokia.com>
Subject: Re: Simple-agent in C
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081120153258.GA31342@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <37367b3a0811200516y71890f0es7b1aafaac5ef873b@mail.gmail.com>
	 <20081120133426.GA24814@localhost>
	 <37367b3a0811200722r33c50f6fme81c28dc0be0ef39@mail.gmail.com>
	 <20081120153258.GA31342@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry my mistake, I replied onf to Johan...

On Thu, Nov 20, 2008 at 3:32 PM, Johan Hedberg <johan.hedberg@nokia.com> wrote:
>
> Yes, as I said you'll need to fill in the proper agent callbacks (right
> now there's something called "Request" which does not exist in the API)
> as well as make it get the adapter path using e.g. DefaultAdapter().

All right. Thank you again!

When I run this agent it is reporting here is not org.bluez DBUS
service, then I verified bluetoothd is is starting correctly:

# bluetoothd -nd
bluetoothd[1888]: Bluetooth daemon
bluetoothd[1888]: Enabling debug information
bluetoothd[1888]: parsing main.conf
bluetoothd[1888]: offmode=NoScan
bluetoothd[1888]: discovto=0
bluetoothd[1888]: pageto=8192
bluetoothd[1888]: name=%h-%d
bluetoothd[1888]: class=0x000100
bluetoothd[1888]: inqmode=0
bluetoothd[1888]: Unable to get on D-Bus

This is the very same error reported here:
https://lists.ubuntu.com/archives/ubuntu-bluetooth/2008-November/002629.html

I am starting dbus this way:
# dbus-daemon --system

I tried to strace bluetoothd but it doesn't helped much, none suspect
problem. Is this some specific problem of this version (4.18)?

Some idea about how to solve this problem?
I think "Unable to get on D-Bus" means bluetoothd are not listening to
same d-bus socket started by dbus-daemon. Isn't it?

> Johan

Best Regards,

Alan
