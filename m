Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040407214322.GA14396@magma.epfl.ch>
References: <20040407172325.GC9593@magma.epfl.ch>
	 <20040407214322.GA14396@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081417632.2970.0.camel@pegasus>
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
Date: Thu, 08 Apr 2004 11:47:12 +0200

Hi Gregoire,

> I compiled 2.6.5-mm2 again, with all blutooth in, and now I can see my
> bluetooth device ;-) I can also scan my Palm device.
> I try http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
> and after dund --listen --persist --msdun call dun
> I got the following error when I try to connect:
> dund[3647]: RFCOMM TTY creation failed. Operation not supported(95)

this error is because you didn't set CONFIG_BT_RFCOMM_TTY in your kernel
config.

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
