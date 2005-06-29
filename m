Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Odd inquiry scan result
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42C2DA3D.3020808@csr.com>
References: <20050629163820.10206.qmail@web30711.mail.mud.yahoo.com>
	 <42C2DA3D.3020808@csr.com>
Content-Type: text/plain
Message-Id: <1120067737.15397.132.camel@pegasus>
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
Date: Wed, 29 Jun 2005 19:55:37 +0200

Hi Steven,

> >> HCI Event: 0x0e plen 8
> >   01 1D 0C 12 00 00 00 00
> 
> Event 0e:    Command Complete
> 01:          num_hci_command_packets = 1
> 1D 0C:       Opcode 0x0c1d = Read Inquiry Scan Activity
> 12:          Status = Invalid HCI command parameters !
> 00 00 00 00: Parameters = not valid as there was an error !

thanks for the decoding work, but using "hcidump -X -V" would have also
done the work ;)

> See the 10 commandments of C by Henry Spencer at:
> 
>   http://www.lysator.liu.se/c/ten-commandments.html

These are really good ones. I like them.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
