Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: "'Steven Singer'" <steven.singer@csr.com>
Cc: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] AUX1 packets
Message-ID: <000601c3ffc0$b0e35cc0$46a57e40@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <40437D65.9050004@csr.com>
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
Date: Mon, 1 Mar 2004 11:09:16 -0800

>It's not clear to me how knowing the QoS settings for link will alter
what settings are best for the link, so it's not clear to me what your
middleware brings to the situation.

My research intends to enumerate mechanisms for QoS in wireless CORBA
transports - figuring out the switches in each standard that can be
toggeled to change the behavior of the wireless network. Then the
application designer (using CORBA) will decide on a type of wireless
network, and network requirements (these are generecized and not tied to
BT/IEEE8011.b etc). The middleware then takes these requirements and
uses the hooks specific to the wirless network to achieve what was
asked.

>You're trying to reinvent the wheel badly.

Thanks for the info on the received signal strenght versus the
transmission packet type. I didn't think of that. I could of course be
stubborn and say that if I wanted to let the application decide packet
types, I'd attach a byte of link quality to every message for the
receiver to use. But as you say, it is really reinventing the wheel
somewhat.

But if there are multiple CORBA server replicas, it could be interesting
to send each CORBA request to both servers, one link having packet
requirements, and the other letting CQDDR decide, then the client uses
the first reply and discards the other (in a CORBA client/server
application using BT).

More interesting: Is CQDDR implemented on all devices? I have a couple
that don't support reading RSSI/Link Quality?

Anyway, it makes some sence to me to try and force certain packet types,
since the system may have strict latency requirements, combining this
with flush timeouts for the connection.

Thor


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
