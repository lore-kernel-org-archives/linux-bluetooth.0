Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?S=E9bastien?= Delneste <seb@goodidea.be>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040310103925.GA15342@pong.be>
Reply-To: =?iso-8859-1?Q?S=E9bastien?= Delneste <seb@goodidea.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] problem with Dlink DBT-120
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 11:39:25 +0100

Hello
I'm having a problem with a USB Dongle (DBT120 Rev : A1)

it used to work on my kernel 2.4.23 but it doesn't work anymore...

There is my problem :
hub.c: new USB device 00:03.2-2, assigned address 5
usb.c: USB device 5 (vend/prod 0xa5c/0x2033) is not claimed by any
active driver

But I have no idea how to make him understand which driver to use with
this device.

hotplug is running....


I guess I should manually use bluefw usb xxxx/yyyy but I don't know
where to find these values.

I have read something about lsusb but I don't have that command om my
Debian system.

I have looked up in /proc/bus/usb/ but I couldn't find anything helpful.

Can anyone help ?

Is there any active IRC channel related to bluetooth ?

Sébastien



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
