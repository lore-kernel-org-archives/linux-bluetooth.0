Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Desperate newbie
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Deresch <aderesch@fs.tum.de>
Cc: Gary Martin <gary_martin_au@yahoo.com.au>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56L0.0403311642280.9869@localhost>
References: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
	 <Pine.LNX.4.56L0.0403311642280.9869@localhost>
Content-Type: text/plain
Message-Id: <1080746814.2536.16.camel@pegasus>
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
Date: Wed, 31 Mar 2004 17:26:54 +0200

Hi Andreas,

> Fine, so the only difference (apart from multisync itself) between our
> phones is that "hcitool info <BDA>" does not work for you. The problem there
> seems to arise at HCIGETCONNINFO and then hci_create_connection. Anybody
> with BE hardware care to take a closer look at it? I unfortunately do not
> own any (bluetooth capable).

the "hcitool info" problems should already be fixed with newer libs and
utils versions. Look at the mailing list archives for details.

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
