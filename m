Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP service
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050228120815.30584.qmail@web60901.mail.yahoo.com>
References: <20050228120815.30584.qmail@web60901.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109599768.17256.72.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Feb 2005 15:09:28 +0100

Hi Michael,

>     I'm configuring BlueZ's SDP. But when I searched
> my home's and lab's Linux PC respectively, the
> services provided by my lab's PC is more than that by
> my home one, with the following that my home's PC
> doesn't apply: SAP (SIM Access) and HF (Handsfree).
> Also, I doesn't find any service that represents
> "synchronization". Therefore, even though I added T610
> as "handsfree device", and the "connect" item is
> displayed in my home's PC's   selection list, when I
> tried to connect to my PC, the "Bluetooth connection
> failed" dialog appeared. The tools and libraries
> installed in my home's and lab's PCs are the same,
> with utils, libs, pan rpm, sdp rpm, and hcidump all
> most updated version. What is the problem, and how can
> I do?

if you use the old bluez-{sdp|pan} packages then this is your first
mistake. They are no longer supported and not needed anymore.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
