Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] auto pairing between client & server
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <426E1B8F.8030901@gmx.ch>
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
	 <426ABEBD.5060701@gmx.ch> <2621d9af0504250729e34a2aa@mail.gmail.com>
	 <426D00CB.7060508@gmx.ch> <2621d9af0504260302e1c13c7@mail.gmail.com>
	 <426E1B8F.8030901@gmx.ch>
Content-Type: text/plain
Message-Id: <1114522760.10706.280.camel@pegasus>
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
Date: Tue, 26 Apr 2005 15:39:20 +0200

Hi Marco,

> > What I want is to avoid the pin popup for certain bluetooth devices
> > (know specific BD_ADDR). When those allowed devices connect to my
> > device, then I will try to provide "silently" the PIN (no popups) and
> > the pairing should be done from there. If other device which BD_ADDR
> > does not belong to the list of addresses that my device has, it should
> > not be rejected.
> 
> I don't think this is possible because you don't know the remote BD_ADDR 
> until the device has connected to your device. And if it has already 
> connected, it's too late for bluteooth based autentication/encryption. So 
> you might implement an own authentication/encryption algorithm for your 
> purpose.

you already have an temporary underlaying ACL link, because otherwise it
is impossible to request the authentication and encryption. All pin code
and link key oriented events tell you the remote BD_ADDR. So this is
actually no problem to realize.

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
