Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] unable to retrieve services
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?c=E9cile?= Ayr <tetilou2003@yahoo.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040313093829.3814.qmail@web41713.mail.yahoo.com>
References: <20040313093829.3814.qmail@web41713.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1079179762.1795.0.camel@pegasus>
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
Date: Sat, 13 Mar 2004 13:09:22 +0100

Hi Cecile,

> I have a laptop with a bluez environment and a USB
> port. I tried to connect to my laptop with a PDA
> running bluetooth. The PDA can locate my laptop but is
> unabled to retrieve the services of my laptop. I set
> the service/device class on my laptop, such as:
> 
> hciconfig hci0 class 0x92010C 
> 
> Any idea why it doesn't work? 

starting sdpd is a good idea and of course you must run some services ;)

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
