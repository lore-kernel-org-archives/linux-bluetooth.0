Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
	service happens on two systems trying to talk to each other
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Marc-Andr=E9_Laverdi=E8re?= <m_laverd@alcor.concordia.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077033023.4032383f0b3d3@alcor.concordia.ca>
References: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>
	 <1077022337.2841.15.camel@pegasus>
	 <1077033023.4032383f0b3d3@alcor.concordia.ca>
Content-Type: text/plain
Message-Id: <1077034212.2665.19.camel@pegasus>
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
Date: Tue, 17 Feb 2004 17:10:12 +0100

Hi Marc-Andre,

> Only the 1.2 spec is available for people not from member companies. I hope
> this
> version is OK.

this version is almost fine.

> I'll get the non-Java terminology right and I'll write an understandable report
> then. This is frustrating.

I don't think so.

	inquiry scan	-> device is visible
	page scan	-> device is connectable

	inquiry		-> search for other devices
	page		-> connect to another device

	SDP connection	-> service discovery (includes page)

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
