Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing problem
From: bc90021 <bc90021@bc90021.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42D797AF.40405@cefriel.it>
References: <42D797AF.40405@cefriel.it>
Content-Type: text/plain
Message-Id: <1121433701.29806.14.camel@viskulan.tigerhost.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 15 Jul 2005 09:21:41 -0400

Luca,

You may want to try setting the security to "auto" in
the /etc/bluetooth/hcid.conf.  I had a similar problem, and forcing the
machine to use the phone's pin solved my problem.

On Fri, 2005-07-15 at 13:02 +0200, Luca Pizzamiglio wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi to hall.
> 
> I'm using a Slackware Linux box with Linux 2.6.12 and Bluez patch.
> I'm using the latest 2.18 Bluez libs and utils.
> I want to develop a hands-free phone profile with BlueZ stack.
> 
> I create a RFCOMM interface with the command
> 
> > rfcomm bind 0 00:00:00:00:00:00 1
> 
> with the right baddr.
> After that, I try to send an AT command:
> 
> > echo ATA > /dev/rfcomm0
> 
> Then, the phone claim a pin to establish a connection.
> My pin_helper application is:
> 
> #!/bin/bash
> echo "PIN:0000"
> 
> so, I enter a 0000 PIN, but the phone tell me the PIN is wrong.
> 
> Maybe I've a misconfigured pin-helper application?
> 
> Thx in advance!
> 
> Cheers,
> Pizza
> 
> - -------------------------------------------
> Luca Pizzamiglio
> CEFRIEL - Embedded Systems Design Unit
> Via Fucini, 2 - 20133 MILANO (ITALY)
> Phone:		+39 02 23954 343
> e-mail:		pizzamiglio@cefriel.it
> ICQ:		5046978
> - -------------------------------------------
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.7 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFC15evAoUy56ORfbERAqcRAJ91u38moNHzINY8E4OZtVPo7YULfwCfXMUY
> 7bpb8yusRHGhMg+7px4Rt7g=
> =CZc4
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
