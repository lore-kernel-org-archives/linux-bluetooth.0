Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c638dc0503290934170df12@mail.gmail.com>
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
	 <1112114217.9016.92.camel@pegasus>
	 <b5c638dc050329084145c6fecd@mail.gmail.com>
	 <1112114986.9016.94.camel@pegasus>
	 <b5c638dc05032908584e207be8@mail.gmail.com>
	 <b5c638dc05032909155d940a3c@mail.gmail.com>
	 <b5c638dc0503290934170df12@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112117903.9016.103.camel@pegasus>
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
Date: Tue, 29 Mar 2005 19:38:23 +0200

Hi David,

> ok sorry for the update.. i ran this command
> 
> hciattach ttyS14 any 16550
> 
> (From the above hints you gave me :) ) and something happenned in dmesg.. 

the command can't be right, because 16550 is not a valid baud rate. It
is the UART type. Use 115200 as baud rate. You have to play with it and
see if it works.

Start "hcid" as root and check with "hciconfig" if you see the Bluetooth
device address. If yes, then your card is working.

> i think it's working .. gnome-bluetooth manager still gives me the
> gconf error . and gnome authentication error (no ideas.. and nobody
> has been able to answer me on what that error is.. plus a google
> search didn't pull anything up"

This is the wrong mailing list for a Gnome-Bluetooth questions.

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
