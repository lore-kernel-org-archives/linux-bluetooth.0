Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sniffing others devices - noob
From: Marcel Holtmann <marcel@holtmann.org>
To: tpeyrin@cpe.fr
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040408114459.19348.qmail@web60309.mail.yahoo.com>
References: <20040408114459.19348.qmail@web60309.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1081425612.2970.25.camel@pegasus>
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
Date: Thu, 08 Apr 2004 14:00:12 +0200

Hi Thomas,

> i'm would like to get the random values (in_rand) and
> all the other data (Ca - Cb) sent while the
> authentification of two devices. Can hcidump get these
> values if he runs on a different machine than the two
> ones authentificating ?? how so ??

hcidump only sniffs on HCI level. What you need is a protocol analyser.

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
