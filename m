Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth in promiscuous mode and passively
	collecting traffic?
From: Marcel Holtmann <marcel@holtmann.org>
To: blue ranger <theblueresearcher@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040320211932.69476.qmail@web60105.mail.yahoo.com>
References: <20040320211932.69476.qmail@web60105.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1079818858.31859.42.camel@pegasus>
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
Date: Sat, 20 Mar 2004 22:40:58 +0100

Hi Ken,

> I am wondering if there has been any development in using current
> Bluetooth chips in a promiscuous mode, being able to passively listen
> to any traffic around?  From the research I've done, I know that a
> year ago this was not really possible unless you bought a protocol
> analyzer that is very expensive.  I am working on a Bluetooth project
> at school and am trying to find a way to collect Bluetooth traffic
> that is not necessarily directed at my Bluetooth chip.  Thanks for any
> help you can give.  

you can only sniff the HCI traffic between the BlueZ stack and your
Bluetooth device.

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
