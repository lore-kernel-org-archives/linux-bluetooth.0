Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087512926.3103.51.camel@localhost.localdomain>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
	 <1087511321.3103.32.camel@localhost.localdomain>
	 <1087511911.4309.94.camel@pegasus>
	 <1087512926.3103.51.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087513312.4309.100.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 18 Jun 2004 01:01:52 +0200

Hi Jon,

> Can anyone? This may be a silly question, but what exactly is the link
> manager? Is there anything I can do to track the problem down, or should
> I just give up?

you must buy a protocol analyzer for this ;)

> Just to make sure I've understood this right: The problem is that once
> the first connection is set up, the link manager won't accept (or
> detect?) another incoming connection. The reason it works when I do it
> manually is that the connect button on the keyboard makes the keyboard
> listen for a connection, and the subsequent 'hidd --connect <addr>'
> makes the CF card connect to the keyboard. Is that right?

I think the problem here is your Bluetooth card. The Nokia card is
working fine, but it seems that it has problems when you try to get
another device into that piconet in which it is already master. I only
own the DTL-1 and so I can't test this, but with a newer card or USB
dongle everything should work, because I tested already this case with
seven HID devices and it was working perfect.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
