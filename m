Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2CAP connectionless
From: Marcel Holtmann <marcel@holtmann.org>
To: Michel Planques <mplanque@laas.fr>
Cc: kdesai@mail.smu.edu,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3902.82.255.26.193.1076967794.squirrel@www.laas.fr>
References: <38F76B90B82C0A4A822651EACE4FF8E9C23322@s31xs2>
	 <1076922085.2840.46.camel@pegasus>
	 <3902.82.255.26.193.1076967794.squirrel@www.laas.fr>
Content-Type: text/plain
Message-Id: <1076972404.2840.60.camel@pegasus>
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
Date: Tue, 17 Feb 2004 00:00:04 +0100

Hi Michel,

> As I know, a L2CAP link is connection oriented, so I don't understand how
> the connectionless mode is working.

it supports both, but the most used is the connection oriented.

> I already searched informations about SOCK_DGRAM implementation in Bluez
> and never found anything : even in this mailing list (maybe I'm blind !)
> If anybody could point me on some informations ...

Some time ago Max includes support for SOCK_DGRAM and there was a
discussion about it, but I wasn't involved in it.

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
