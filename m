Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error on connect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42616275.1090103@gmx.ch>
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>
	 <42616275.1090103@gmx.ch>
Content-Type: text/plain
Message-Id: <1113682195.18450.0.camel@pegasus>
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
Date: Sat, 16 Apr 2005 22:09:55 +0200

Hi Marco,

> Yes. Broadcom dongles cause the problem.
> Actually it's only the slave (listening dongle).

what kind of Broadcom dongle is this?

> I tested all combinations with a minimal slave and master (only 
> connects/accept connection and quit directly again).
> the master (connecting one) doesn't care, csr and broadcom worked fine.
> 
> but the listening one gives the mentioned error (on more than 50% of the 
> tries) I tried with a acer and ednet broadcom dongle.
> A csr works just perfectly fine...
> 
> after the error, the dongle keeps waiting for a slave but won't access any 
> more connections. so, basically the dongle is completly freezed.

Send in the "hcidump -X -V" for it.

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
