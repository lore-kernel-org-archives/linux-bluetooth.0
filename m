Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: "Ronan Naughton" <wadgienaughton@hotmail.com>,
   bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Setting up a bluetooth network
References: <BAY10-F29zjmbgGHk7s000090c8@hotmail.com>
In-Reply-To: <BAY10-F29zjmbgGHk7s000090c8@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403022300.27228.pavouk@pavouk.org>
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
Date: Tue, 2 Mar 2004 23:00:27 +0100

Hello,

> I am having some trouble. I want to set up a little bluetooth LAN say
> between 4 computers with bluetooth dongles and a pda. I don't know which to
> use PAN or LAN access profile and I am having trouble setting up both.

For your network will be great solution with PAN network.
You will setup one computer like a "master".
 pand --listen --master --role=NAP

Other computers and PDA will be a "slaves".

Maybe this document is best for you:
http://www.cs.ucla.edu/~cclljj/interest/notes/bluez/pand_bridge_nap.html

> Also is LAN acces profile just for say accesing a LAN rather than setting
> up a LAN. All the LAN how-to's show how to set up a PPP connection between
> ur pc and your phone, and that is even causing me trouble. It trys to make
> a PPP over rfcomm but fails to connect.

I use PPP through rfcomm only for GPRS dial-up with my mobile phone.

> both computers can ping the master but
> cannot ping each other and the master can only ping one pc, even though it
> seems that the connection is there and the pc's are beside each other.
> I assigned the master by un-commenting the config file ( at lm accept,
> master ).

If you have devices in same address space, you will need to configure
bridge on master.

If you have devices in different address spaces, you will need to setup
default gateway on slaves and enable routing in kernel on master:
echo "1" > /proc/sys/net/ipv4/ip_forward

But I don't have experience with more than two devices.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
