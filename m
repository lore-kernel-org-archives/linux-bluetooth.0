Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trouble pairing with new phone...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502081821250.18758@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0502081821250.18758@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1107905403.14624.0.camel@pegasus>
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
Date: Wed, 09 Feb 2005 00:30:03 +0100

Hi Jay,

> Ok, I had a SE T610 phone, and it paired with BlueZ no problems. I also
> have a Palm T and it paired with no problems...
> 
> The phone stoped charging, and I got it replaced under warantee.
> 
> Now, I can't pair the phone with the laptop running Linux/Bluez. (After
> entering the PIN on the phone, it gives a "Bluetooth connection failed"
> message.)
> 
> I deleted the pairing between all devices.
> 
> The phone is able to pair with the Palm. The Palm is able to pair with the
> laptop (running Bluez) and the phone. The phone still won't pair with the
> laptop.
> 
> My questions:
> 1) Is there a way to initate pairing FROM the laptop?
> 
> 2) Anybody see this type of behavior before?
>  (Is it a problem with my new phone? The old one worked fine...)

run "hcidump -X" as root while trying to pair/connect.

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
