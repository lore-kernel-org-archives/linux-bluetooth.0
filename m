Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
From: Marcel Holtmann <marcel@holtmann.org>
To: EXT-Somil.Asthana@nokia.com
Cc: d.mackie@ru.ac.za, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E320A8529CF07E4C967ECC2F380B0CF90140382B@bsebe001.americas.nokia.com>
References: 
	 <E320A8529CF07E4C967ECC2F380B0CF90140382B@bsebe001.americas.nokia.com>
Content-Type: text/plain
Message-Id: <1086642107.28514.21.camel@pegasus>
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
Date: Mon, 07 Jun 2004 23:01:48 +0200

Hi Somil,

>   Looks like I am in minority here :(. Actually you are very correct there aren't any phone with PAN or UPnP (its in one of our TODO list). Further, Symbian 8.0 release will have a PAN stack anyway (it will be interesting to interface with Bluez PAN  stack, as there are some issues). So for the time being you can look for solutions like Distributed SDP database, tunneling for the RFCOMM channels. They look every exciting but requires lot of debugging/testing  based on my experience on developing/debugging l2cap broadcast utility (using Bluez util code) and I didn't do anything novel there. As far as I see maintaining /updating Distributed SDP database is no different from cache coherence problem (but I am nt expert so I shouldn't really say that but I thought about it :)).

if you think that there are BlueZ PAN vs. Symbian PAN problems, feel
free to send me a PAN enabled phone and I will check what happens on our
side. Maybe the BlueZ code is buggy. I hope not, but it may be possible.

The idea with distributed SDP and a L2CAP/RFCOMM tunnel is very old. I
know that this works, because I already used it to reverse engineer the
FBus over Bluetooth part of the Nokia Data Suite that way. I didn't used
IP as tunnel between the two piconet, because BlueZ is able to work with
more than one dongle (or expensive PCMCIA cards in my case) attached to
the same host. Some easy tricks if you can't buy yourself a protocol
analyzer ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
