Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] killing a persisted pand session
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070221.59578.wim.delvaux@adaptiveplanet.com>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
	 <1078622263.2807.2.camel@pegasus>
	 <200403070221.59578.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078623235.2807.6.camel@pegasus>
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
Date: Sun, 07 Mar 2004 02:33:55 +0100

Hi Wim,

> 	Ah so it means that pand -k does not send anything to the pand that is 
> running .  pand --connect just does something to create the connection.
> 
> 	If that is the case why doesn't pand without --persist return after the
> 	connection was established ?

what are you talking about? After pand has established the connection it
hands it over to the kernel BNEP module and exit.

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
