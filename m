Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez-hciemu-1.0 on Debian--GLib
	not	found
From: Marcel Holtmann <marcel@holtmann.org>
To: Tehyih D Wan <tdwan@MIT.EDU>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1082563268.40869ac41cfc3@webmail.mit.edu>
References: <1081889721.407c53b90c5d4@webmail.mit.edu>
	 <1082161011.4489.30.camel@pegasus>
	 <1082563268.40869ac41cfc3@webmail.mit.edu>
Content-Type: text/plain
Message-Id: <1082565326.23959.48.camel@pegasus>
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
Date: Wed, 21 Apr 2004 18:35:26 +0200

Hi Debbie,

> I looked in hciemu.c and the only reference I found to Glib was the #include
> <glib.h> line.  Should I change this to say glib-2.0?  Or is there another
> source file I should look at?

check for yourself, because I don't have time to look into that source.

> I did get the emulator installed (at least, I no longer get configuration
> errors) by installing the glib1.2-dev library.  However, I'm not able to
> emulate any devices.  Typing "hciemu localhost:11" gives no errors, but when I
> try "hciconfig hci11 up" I get a message that there is no such device.  I run
> /etc/init.d/bluetooth start before everything but that does not seem to make a
> difference.  Suggestions on what log files or messages I can look for to see
> what is wrong?

maybe you should better use localhost:100011 or any higher port number
and the new device will be hci0.

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
