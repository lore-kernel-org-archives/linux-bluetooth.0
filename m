Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087520970.3103.87.camel@localhost.localdomain>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
	 <1087511321.3103.32.camel@localhost.localdomain>
	 <1087511911.4309.94.camel@pegasus>
	 <1087512926.3103.51.camel@localhost.localdomain>
	 <1087513312.4309.100.camel@pegasus>
	 <1087520970.3103.87.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087559360.4309.116.camel@pegasus>
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
Date: Fri, 18 Jun 2004 13:49:20 +0200

Hi Jon,

> > I think the problem here is your Bluetooth card. The Nokia card is
> > working fine, but it seems that it has problems when you try to get
> > another device into that piconet in which it is already master. I only
> > own the DTL-1 and so I can't test this, but with a newer card or USB
> > dongle everything should work, because I tested already this case with
> > seven HID devices and it was working perfect.
> 
> Ok, thank you very much for your help. I was actually happy when I
> received a Socket card of revision F instead of G, because then I
> wouldn't have to worry about the G card not working with the 2.6 kernel.
> But I guess there's a reason they never supported HID in their windows
> drivers for the previous revisions.

your thought is wrong here. The problem is not that the card don't
supports HID, because you can work with one of your devices. The problem
is that this card is "very old" and in the beginning of Bluetooth not
all chip manufacturers did a good job in implementing all features. Many
of them think to short and in a special case the phone companies. They
made sure that their card works with their phone and from their view
that was mostly an one-to-one communication. The keywords are scatternet
and multi-connection support. Another example is that in most phones you
can't synchronize your phonebook while you are makeing a phone call with
your Bluetooth headset.

Btw I also saw a very new Bluetooth 1.2 chip that don't really like a
piconet full of HID devices :(

> I've just ordered their special upgrade offer, so hopefully in a week or
> two I'll have both the F and the G revision to play with. Maybe I can
> even somehow make the newer card work with 2.6, so I can have both a new
> kernel and working HID. Wish me luck :)

If you find the real problem between hci_uart, serial_cs and 2.6 we will
all thank you.

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
