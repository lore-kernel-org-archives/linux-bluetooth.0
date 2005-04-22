Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2621d9af05042212085b635558@mail.gmail.com>
From: "N. I." <neutralidea@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] bluez scatternet
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
Date: Fri, 22 Apr 2005 15:08:45 -0400

I'm new to Bluetooth, as well as scatternet type of network.

I'm trying to create a scatternet network as followed:

Piconet 1:
Master A
Slave B, C, D

Piconet 2:
Master C (slave in piconet 1)
Slave M, N, Q.

My questions:

1) What are the steps to create this type of scatternet?
  What should be done to configure master/slave C to play this role
in the network?

2) Assuming that the scatternet is created succesfully. If
Master/Slave C dies, how can slaves M, N and Q be able to route
messages to Master A?

3) For this current configuration of network, what should I consider
in pairing devices in sunny situation (Master/Slave C up and running)
and when master/slave C dies (rainy condition)?

Please help,

Thanks

N.I.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
