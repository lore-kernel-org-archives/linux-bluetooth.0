Return-Path: <Maksim.Yevmenkin@cw.com>
Sender: myevmenk@rvs.uni-bielefeld.de
Message-ID: <3DF4E2ED.9735213B@exodus.net>
Date: Mon, 09 Dec 2002 10:37:33 -0800
From: Maksim Yevmenkin <myevmenk@exodus.net>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Maksim Yevmenkin <Maksim.Yevmenkin@cw.com>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Patch for bluez-hcidump-1.5
References: <5.1.0.14.2.20021209094932.08533800@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Max Krasnyansky wrote:
> 
> At 8:7 M 2/7/2002 -0800, Maksim Yevmenkin wrote:
> 
> >i will try to make the first step and create hci.h and l2cap.h
> >that will contain only HCI and L2CAP types and defines - no system
> >specific code. the next step is to define API for Bluetooth sockets
> >(HCI and L2CAP), i.e. ioctl names, setsockopt defines etc. i also
> >propose to define common libBluetooth, libHCI (and probably libL2CAP)
> >API that will hide possible implementation differences. after we
> >do that all application just will use defined API and source code
> >will be 100% portable.
> libL2CAP ?? We don't have libTCP/IP, do we ?
> To much abstraction is _bad_.

:) i said *probably* :) there are still some differences in
L2CAP API. i have a different semantic for raw L2CAP sockets
for example. in order to send L2CAP PING and GET_INFO i use
ioctl() to avoid L2CAP command ID's collisions. the L2CAP
library could hide stuff like this. but then again - may be
its way too much abstraction :)

> >as for RFCOMM, SDP etc. then you guys will lead the parade :)
> >i'm currently using BlueZ code with the minimal changes. i'm just
> >hoping that SDP, RFCOMM etc. implementation won't become too
> >Linux specific :)
> SDP should be portable.

amen :)

> But RFCOMM TTY stuff will probably be different. How are you going to
> implement it btw ?

i have not decided yet :( i have bigger problems now :( my
current plan is to make it completely in user space. FreeBSD
has the null-modem driver which will play the role of virtual
serial port. a service will start on the null-modem master's
side. a client will start on the null-modem's slave side. in
both cases rfcomm daemon will control other side of the
null-modem, monitor L2CAP socket and maintain rfcomm sessions. 
i'm also thinking about RFCOMM sockets module.

max
