Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with 2.5.6 and D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Svedberg <johan@svedberg.pp.se>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040406101704.GA42503.johan@svedberg.pp.se>
References: <20040406101704.GA42503.johan@svedberg.pp.se>
Content-Type: text/plain
Message-Id: <1081240989.17215.14.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 06 Apr 2004 10:43:09 +0200

Hi Johan,

> Since 2.6.5 I'm having problems with my D-Link DBT-120. It is recognized
> fine when I use the TTY-driver under the USB meny. But when I have
> selected that I can't select the Bluetooth subsystem which my
> userspace-tools needs. So there seem to be a dependency problem here.

there is no dependency problem, because you can't use both drivers at
the same time.

> I've tried using the USB drivers found in theBluetooth subsystem
> instead, but those don't seem to recognize the device.

What is the content of /proc/bus/usb/devices? Check lsusb and see if
your D-Link dongle is CSR or Broadcom based.

Regards

Marcel





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
