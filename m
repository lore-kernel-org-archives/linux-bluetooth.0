Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI data packets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041206085827162a8f@mail.gmail.com>
References: <2de46576041206085827162a8f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102358712.9644.41.camel@pegasus>
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
Date: Mon, 06 Dec 2004 19:45:12 +0100

Hi Manjunath,

> Does, opening a socket and then connect() at the
> L2CAP......automatically establish an HCI connection first and then an
> L2CAP connection on top of it??  This is what HCI dump shows..

this is correct and it must work like this.

> Can I in someway just create an HCI connection first and then pump HCI data
> packet with some known payload???How can i generate the test data
> packets........... In a way, i just want  pump raw bits.....

You can use the HCI raw socket. This is what the library and the tools
are doing. However be careful with the ACL packets, because some chips
expect L2CAP frames and not random payload.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
