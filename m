Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm connection setup
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick Duchstein <patrick@duchstein.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040609030049.0a9212bd.patrick@duchstein.com>
References: <20040608230122.3504775c.patrick-bluez.org@prote.st>
	 <1086735971.5040.52.camel@pegasus>
	 <20040609030049.0a9212bd.patrick@duchstein.com>
Content-Type: text/plain
Message-Id: <1086771103.5040.67.camel@pegasus>
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
Date: Wed, 09 Jun 2004 10:51:43 +0200

Hi Patrick,

> yep that's correct. I attached the resulting file; l2cap parameter
> negotiation (conf_req/conf_rsp from both sides) runs without problems,
> and then nothing else happens, whilst IMHO bluez should send SABM.

	< ACL data: handle 0x0029 flags 0x02 dlen 12
	    L2CAP(s): Connect req: psm 3 scid 0x0040
	< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
	  29 00 0E 00 
	> HCI Event: Number of Completed Packets(0x13) plen 5
	  01 29 00 01 00 
	> HCI Event: Command Complete(0x0e) plen 6
	  01 0D 08 00 29 00 
	> ACL data: handle 0x0029 flags 0x02 dlen 16
	    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
	< ACL data: handle 0x0029 flags 0x02 dlen 16
	    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
	    MTU 1024 
	> HCI Event: Max Slots Change(0x1b) plen 3
	  29 00 05 
	> HCI Event: Number of Completed Packets(0x13) plen 5
	  01 29 00 01 00 
	> ACL data: handle 0x0029 flags 0x02 dlen 15
	    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 3 clen 1
	    Unknown (type 04, len 4) 
	< ACL data: handle 0x0029 flags 0x02 dlen 12
	    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

take another look at your L2CAP code, because the config response is not
correct and BlueZ disconnects. The config type 4 is a Bluetooth 1.2 only
feature which is not supported at the moment. However you must response
to the MTU config request.

If the L2CAP link is not fully setup, the RFCOMM layer won't send the
SABM command.

> Btw, is there a reason for bluez rejecting non-default l2cap parameters,
> such as a smaller MTU? I might consider implementing this into bluez
> when I find the time if it is desired at all....at least by me it
> definitely is since I'm working on only 4KB of RAM.

I don't see your problem here, because the MTU can be different for the
incoming and outgoing side. And for the above RFCOMM layer we accept any
OMTU that the other system gave us and we say that our IMTU is 1024.

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
