Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Scatternet
From: Marcel Holtmann <marcel@holtmann.org>
To: Ronan Naughton <wadgienaughton@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY10-F36jyAG8SjQhX00018932@hotmail.com>
References: <BAY10-F36jyAG8SjQhX00018932@hotmail.com>
Content-Type: text/plain
Message-Id: <1080397614.2281.52.camel@pegasus>
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
Date: Sat, 27 Mar 2004 15:26:55 +0100

Hi Ronan,

> Ya, I can do that. I can connect to one pan using bnep0 acting as a slave. 
> Then I can make it a master on bnep1 and conncet to it form another pc. When 
> I do "pand --show", it shows both interfaces bnep0 and bnep1 and their 
> connections.
> However, I cannot communicate between the two networks. When I even try to 
> ping the master of the other network it comes up host unreachable. I don't 
> know why this is?

this is not a Bluetooth problem, because this is TCP/IP stuff. You
should read somehting about IP forwarding, bridging, routing etc.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
