Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problem using kernel 2.4.18
From: Marcel Holtmann <marcel@holtmann.org>
To: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <168c01518d.1518d168c0@estudiants.urv.es>
References: <168c01518d.1518d168c0@estudiants.urv.es>
Content-Type: text/plain
Message-Id: <1078705218.15279.13.camel@pegasus>
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
Date: Mon, 08 Mar 2004 01:20:18 +0100

Hi Albert,

> I know that bluez-kernel-2.3 is no longer supported, and my kernel is out of date (red hat valhalla 2.4.18) , but I can't change my kernel, because I'm working on a robot and my manager doesn't want to change anything from it, so is there any way I can make BlueZ working on that machine? I get this error on doing make install:
> make: *** [install] Error 1

the bluez-kernel-2.3 is out of date and contains many unfixed bugs. My
-mh patches are not meant for a RedHat kernel, so you are on your own if
you don't wanna update your kernel to a newer vanilla one.

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
