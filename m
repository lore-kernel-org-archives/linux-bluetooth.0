Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sniffing others devices - noob
From: Marcel Holtmann <marcel@holtmann.org>
To: tpeyrin@cpe.fr
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1081425934.4075400e59f4f@webmail.cpe.fr>
References: <20040408114459.19348.qmail@web60309.mail.yahoo.com>
	 <1081425612.2970.25.camel@pegasus>
	 <1081425934.4075400e59f4f@webmail.cpe.fr>
Content-Type: text/plain
Message-Id: <1081426395.2970.27.camel@pegasus>
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
Date: Thu, 08 Apr 2004 14:13:15 +0200

Hi Thomas,

> on the net I saw example of output of hcidump and after a link key request, the
> response is a 16 bytes value ... this is not the in_rand value in the
> authentification ??

the 16 bytes you have seen must be the 128 bit link key. Read the
Bluetooth HCI specification.

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
