Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez scatternet
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <2621d9af05042212085b635558@mail.gmail.com>
References: <2621d9af05042212085b635558@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114197456.32265.74.camel@pegasus>
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
Date: Fri, 22 Apr 2005 21:17:36 +0200

Hi,

> I'm new to Bluetooth, as well as scatternet type of network.
> 
> I'm trying to create a scatternet network as followed:
> 
> Piconet 1:
> Master A
> Slave B, C, D
> 
> Piconet 2:
> Master C (slave in piconet 1)
> Slave M, N, Q.
> 
> My questions:
> 
> 1) What are the steps to create this type of scatternet?
>   What should be done to configure master/slave C to play this role
> in the network?

create ACL links from A to B, C and D. Then use C and create ACL links
to M, N, Q.

> 2) Assuming that the scatternet is created succesfully. If
> Master/Slave C dies, how can slaves M, N and Q be able to route
> messages to Master A?

They can't. If Master/Slave C dies, the piconet with M, N, Q dies also.
Remember that the hopping sequence of the master defines the piconet. No
master means no piconet and in your case no scatternet anymore.

> 3) For this current configuration of network, what should I consider
> in pairing devices in sunny situation (Master/Slave C up and running)
> and when master/slave C dies (rainy condition)?

I have no idea what you are talking about and what the weather has to do
with it ;)

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
