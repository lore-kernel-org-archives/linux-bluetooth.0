Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@student.cs.york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404201028.08718.ah160@student.cs.york.ac.uk>
References: <200404182321.55431.dvornheder@t-online.de>
	 <200404191952.11018.simone.gotti@email.it>
	 <200404192121.31112.ah160@student.cs.york.ac.uk>
	 <200404201028.08718.ah160@student.cs.york.ac.uk>
Content-Type: text/plain
Message-Id: <1082462190.23959.17.camel@pegasus>
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
Date: Tue, 20 Apr 2004 13:56:30 +0200

Hi Alex,

> Well, booted up today and it worked! To be honest though, I consider 
> this to be a bad thing; it means it'll probably do the works 
> sometimes/doesn't work sometimes thing that bluez-bluefw did too.
> 
> Conclusion? Don't go near USB dongles with Broadcomm chipsets. I wish I 
> had a CSR.

actually with the bcm203x driver and Linux 2.6 I had the Broadcom
dongles working very stable (besides some link manager troubles also
other people have seen). This was the reason why I wrote the kernel
inside firmware loading driver. However I think that your hotplug
scripts are a little bit buggy at some points, because on my Debian Sid
box this is working very nice ;)

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
