Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: "'Steven Singer'" <steven.singer@csr.com>
Cc: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] AUX1 packets
Message-ID: <000401c3ffa7$5b52f310$46a57e40@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <40435D9D.5020509@csr.com>
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
Date: Mon, 1 Mar 2004 08:07:55 -0800

>If both ends of the link support CQDDR then the Link Managers will do
this automatically.
>
>If you try to do this yourself, you'll just end up with the host and
the controller fighting each other.
>
>	- Steven

But the LM can only use packet types that I specified in
create_connection or change_connection_packet_type,
in addition to the mandatory DM1 type. Am I correct in assuming this?

Will the link manager notify me through events that CQDDR scheme has
changed packet type?

How do I know whether CQDDR is supported, and is there any way of
disabling this?

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
