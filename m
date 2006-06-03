Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
References: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
Date: Sat, 03 Jun 2006 13:33:14 +0200
Message-Id: <1149334394.19311.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez udev rules for Slackware 10.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Aaron,

> First off I have to say I am somewhat of a Linux newbie so I apologize
> if this question may seem obvious.
> 
> I am trying to get bluetooth working on my Slackware 10.2 and udev
> does not seem to be creating any devices for my usb dongle. When I
> searched google, all I found in regards to the topic was a recent
> patch which added some new files to the source for udev rules. 
> 
> So I downloaded bluez from the cvs (05/31/2006) and also dbus-0.61
> since the ./configure was complaining about missing the headers. After
> installing bluez-libs I built bluez-utils as so:
> 
> ./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var
> --enable-all 
> make
> make install DESTDIR=<temporary build directory>
> 
> From there I went to my build directory and changed the init script to
> the Slackware standard (<BuildDIr>/etc/rc.d/rc.bluetooth) and modified
> the file a bit to reflect these changes. I then proceeded to build
> into a slack-package and installed it to my system. 
> 
> Now I can run 'sh /etc/rc.d/rc.bluetooth start' just fine and get the
> following output:
> Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.
> 
> But still no device from udev. 

the Bluetooth subsystem doesn't need any device nodes (except for the
RFCOMM TTY emulation). It will simply work and "hciconfig -a" should
show your Bluetooth device.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
