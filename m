Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Debian testing required: bcm203x firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100260673.8785.20.camel@saag>
References: <1100260673.8785.20.camel@saag>
Content-Type: text/plain
Message-Id: <1100261630.12168.71.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Nov 2004 13:13:50 +0100

Hi Edd,

> This is a request to Debian (unstable) users of BlueZ:
> 
> I've uploaded a set of packages to
> http://bluez.sourceforge.net/download/debian/ that now contains two new
> packages:
> 
>   bluez-bcm203x - firmware loader for Broadcom BCM203x based dongles
>   bluez-bcm203x-firmware - firmware files
> 
> I'm looking for users with 2.4 series kernels to install these packages
> and test that initialisation of their BCM203x based dongles work fine
> please.
> 
> (Kernel 2.6 users only need the -firmware package.)
> 
> If we hurry we'll be able to get this support into sarge and I can
> upload the firmware to non-free.

the firmware files are in the wrong place. You are using the old
directory. They must be under /lib/firmware/.

Actually I would prefer to have bluez-bcm203x and bluez-firmware,
because I try to get the AVM and 3Com firmware also into this package.
This also avoids that people install bluez-bcm203x for their 2.6 kernel
even if they don't need it. The naming leads to that.

And btw what does it take to get a virtual packages called bluez that
installs all the needed BlueZ packages?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
