Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM Question
From: Marcel Holtmann <marcel@holtmann.org>
To: Kasimir =?ISO-8859-1?Q?M=FCller?= <Kasimir.Mueller@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <403B8A20.3030806@t-online.de>
References: <403B7FA5.4050607@gmx.de> <1077642423.2919.18.camel@pegasus>
	 <403B8A20.3030806@t-online.de>
Content-Type: text/plain
Message-Id: <1077644228.2919.22.camel@pegasus>
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
Date: Tue, 24 Feb 2004 18:37:08 +0100

Hi Kasimir,

> The problem is, I must have at least 10 distinct connections from 10 
> devices, which must be
> identified by e.g. Hardware-Adress .
> So I must use 2 sticks on the server side ?

if you need 10 connections at the same time, then yes, you should better
use two adapters. Remember that you can have 10 connections at the same
time, but 3 of them must be parked.

> Thanks again very much for your quick and competent answer.

You are welcome.

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
