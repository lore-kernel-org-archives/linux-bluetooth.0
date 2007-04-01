Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <187c15580703311838s5a4903abxfb0b6a0dbb4f8561@mail.gmail.com>
Date: Sun, 1 Apr 2007 02:38:15 +0100
From: "=?ISO-8859-1?Q?Lu=EDs_Sousa?=" <llsousa@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <187c15580703281446p1732a40eifdce3dc4c1261789@mail.gmail.com>
MIME-Version: 1.0
References: <187c15580703281446p1732a40eifdce3dc4c1261789@mail.gmail.com>
Subject: Re: [Bluez-users] Paired with Nokia phone but not connected
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Already found the problem.
The connection on .gammurc was wrong. Should be bluephonet.

On 3/28/07, Lu=EDs Sousa <llsousa@gmail.com> wrote:
> Hi all,
>
> I'm using Debian testing with:
> ||/ Name           Version        Description
> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ii  bluez-firmware 1.2-1          Firmware for Bluetooth devices
> ii  bluez-utils    3.7-1          Bluetooth tools and daemons
> ii  dbus           1.0.2-1        simple interprocess messaging system
> ii  gammu          1.08.00-1      Mobile phone management utility
> ii  libbluetooth2  3.7-1          Library to use the BlueZ Linux Bluetoot=
h sta
> ii  libc6          2.3.6.ds1-13   GNU C Library: Shared libraries
> ii  libdbus-1-3    1.0.2-1        simple interprocess messaging system
> ii  libusb-0.1-4   0.1.12-5       userspace USB programming library
> ii  lsb-base       3.1-23.1       Linux Standard Base 3.1 init script fun=
ction
> ii  makedev        2.3.1-83       creates device files in /dev
> ii  module-init-to 3.3-pre4-2     tools for managing Linux kernel modules
> ii  modutils       2.4.27.0-6     Linux module utilities
> ii  udev           0.105-4        /dev/ and hotplug management daemon
> ii  bluez-gnome    0.6-1          Bluetooth utilities for GNOME
>
> My hardware is a USB Dongle Bluetooth D-Link DBT-122 and a Nokia 6230.
>
> I can't set passkey with error:
> Can't register passkey agent
> Passkey agent already exists
> process 5391: Applications must not close shared connections - see
> dbus_connection_close() docs. This is a bug in the application.
>
> My .gammurc is:
> port =3D <Mobile MAC Address>
> model =3D 6230
> connection =3D bluerffbus
>
> When running gammu --identify bluez-gnome pops up a window to enter a
> password to pair mobile and PC. The pairing works but can't connect
> after. It just says disconneted!
>
> Can someone help me with this?
>
> Thanks in advance,
> Lu=EDs Sousa
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
