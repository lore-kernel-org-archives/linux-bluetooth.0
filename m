Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] auto pairing between client & server
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <2621d9af05042213064d0df1dc@mail.gmail.com>
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114205889.10706.9.camel@pegasus>
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
Date: Fri, 22 Apr 2005 23:38:09 +0200

Hi,

> I have a laptop which runs my application as server, and another
> cellphone as client. Both of them communicate to each other using
> Bluetooth (Bluez implementation).
> 
> What should I do in order to perform automatic pairing between these 2
> devices (knowing the BD_ADDR) inside my application?

there is no such thing than automatic pairing.

> How can I detect if the pairing had been done between these
> client-server devices inside my application? And from that, how to do
> pairing using the "givepin" script?
> 
> I want to avoid the pop-ups window asking for entering the PIN.

Write your own PIN helper shell script that uses a fixed PIN. Check the
link key file for the current state of the pairing.

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
