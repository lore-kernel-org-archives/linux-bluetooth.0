Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] tx submit failed urb c4c6b014 type 3 err -19
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4227CE32.5060306@gmx.ch>
References: <Pine.LNX.4.21.0503031418590.28800-100000@blomma.comm2000.it>
	 <4227CE32.5060306@gmx.ch>
Content-Type: text/plain
Message-Id: <1109953167.8058.78.camel@pegasus>
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
Date: Fri, 04 Mar 2005 17:19:27 +0100

Hi Marco,

> > The reason I'm using multiple dongles is that I need to control more than
> > one phone, and apparently I'm unable to open concurrent SCO links to
> > different phones through the same dongle. 
> 
> Well, in my opinion this is possible... I'm able to connect with two mobile 
> phones to one laptop with one dongle at the same time. maybe you have a 
> dongle that doesn't support multiple connections?

the SCO connections are different than the ACL links. The SCO links are
attached to a previous established ACL link and you can have three SCO
links attached to one ACL, but only three SCO max are allowed inside a
piconet. However BlueZ only supports one SCO connection per ACL link.
This is a stupid limitation, but so far nobody removed it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
