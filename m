Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811210505r67990524gd56ece63eb78d3a5@mail.gmail.com>
Date: Fri, 21 Nov 2008 13:05:06 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Unable to get on D-Bus
In-Reply-To: <37367b3a0811210328i6820fbd6ufbb8a52f33b7dc70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <37367b3a0811210328i6820fbd6ufbb8a52f33b7dc70@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Good news, I found the problem, see below!

On Fri, Nov 21, 2008 at 11:28 AM, Alan Carvalho de Assis
<acassis@gmail.com> wrote:
> Hi all,
>
> First I started DBUS:
>
> # dbus-daemon --system --print-address
> unix:path=/var/run/dbus/system_bus_socket,guid=bd671c01bf0366c80869f10000014a47
>
> Then tried to start bluetoothd:
>
> # bluetoothd -nd
> bluetoothd[1795]: Bluetooth daemon
> bluetoothd[1795]: Enabling debug information
> bluetoothd[1795]: parsing main.conf
> bluetoothd[1795]: offmode=NoScan
> bluetoothd[1795]: discovto=0
> bluetoothd[1795]: pageto=8192
> bluetoothd[1795]: name=%h-%d
> bluetoothd[1795]: class=0x000100
> bluetoothd[1795]: inqmode=0
> bluetoothd[1795]: Unable to get on D-Bus

My bluez installation is placing bluetooth.conf at
/etc/dbus-1/system.d/ but dbus is looking for files at
/usr/etc/dbus-1/system.d!!!

I am posting it here because other people can get same problem.

Best Regards,

Alan
