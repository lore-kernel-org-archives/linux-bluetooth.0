Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20021209094932.08533800@mail1.qualcomm.com>
Date: Mon, 09 Dec 2002 09:58:03 -0800
To: "Maksim Yevmenkin" <Maksim.Yevmenkin@cw.com>, "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Patch for bluez-hcidump-1.5
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45258A4365C6B24A9832BFE224837D552B1270@sjdcex01.int.exodus
	.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 8:7 M 2/7/2002 -0800, Maksim Yevmenkin wrote:

>i will try to make the first step and create hci.h and l2cap.h
>that will contain only HCI and L2CAP types and defines - no system
>specific code. the next step is to define API for Bluetooth sockets
>(HCI and L2CAP), i.e. ioctl names, setsockopt defines etc. i also
>propose to define common libBluetooth, libHCI (and probably libL2CAP)
>API that will hide possible implementation differences. after we
>do that all application just will use defined API and source code
>will be 100% portable.
libL2CAP ?? We don't have libTCP/IP, do we ?
To much abstraction is _bad_.

>as for RFCOMM, SDP etc. then you guys will lead the parade :)
>i'm currently using BlueZ code with the minimal changes. i'm just
>hoping that SDP, RFCOMM etc. implementation won't become too
>Linux specific :)
SDP should be portable. 
But RFCOMM TTY stuff will probably be different. How are you going to
implement it btw ?

Max
