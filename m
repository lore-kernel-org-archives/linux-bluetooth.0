Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MTU and MRU for Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040505211012.GA11210@gmx.net>
References: <opr7hpnaqeqdj9uv@mail.gmx.de>
	 <1083692600.4666.57.camel@pegasus>  <20040505211012.GA11210@gmx.net>
Content-Type: text/plain
Message-Id: <1083790231.4420.40.camel@pegasus>
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
Date: Wed, 05 May 2004 22:50:31 +0200

Hi Nicholas,

> I think, he wants a MTU size that doesn't lead to fragmentation on the
> carrying transport medium. I think this doesn't make much sense due to
> the "short" packets of bluetooth, and the fact that L2CAP packets can be
> up to 2^16 bytes large.

actually there is no proof that choosing a different MTU on the L2CAP
level gives you any performance improvements. However a too small MTU
decreases the performance and this is why we are using 1024 even if 672
is the default MTU. Some time ago we discussed this and until now nobody
really proofed that a different MTU is better or that we should make the
L2CAP MTU for RFCOMM configurable, because some upper layer will improve
if we do so. Proof it to me and we will see ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
