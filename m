Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] reconnect if a remote device quits
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4260015E.1090104@gmx.ch>
References: <4260015E.1090104@gmx.ch>
Content-Type: text/plain
Message-Id: <1113607275.16433.44.camel@pegasus>
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
Date: Sat, 16 Apr 2005 01:21:15 +0200

Hi Marco,

> I connect from a PC to another like this:
> sock = socket(...)
> bind(sock, ...)
> connect(sock, ...)
> // here the data is exchanged
> 
> 
> I now wish to automatic reconnect if the other PC closes the connection 
> (reboot for example), so I do:
> 
> while(true)
> {
> 	sock = socket(...)
> 	bind(sock, ...)
> 	connect(sock, ...)
> 	// here the data is exchanged until the remote device quits
> 	sleep(a little);
> }
> 
> this works fine. but actually i expected this to be enough:
> 
> sock = socket(...)
> bind(sock, ...)
> while(true)
> {
> 	connect(sock, ...)
> 	// here the data is exchanged
> 	sleep(a little);
> }
> 
> but this won't reconnect...
> why is socket() and bind() required again? don't they stay the same if I 
> try to connect to the same bluetooth device again?

you need to do the full stuff, because close() means closed.

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
