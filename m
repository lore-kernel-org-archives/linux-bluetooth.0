Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Deresch <aderesch@fs.tum.de>
Reply-To: Andreas Deresch <aderesch@fs.tum.de>
To: =?iso-8859-1?q?Gary=20Martin?= <gary_martin_au@yahoo.com.au>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Desperate newbie
In-Reply-To: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56L0.0403311642280.9869@localhost>
References: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 31 Mar 2004 17:06:11 +0200 (CEST)

On Wed, 31 Mar 2004, [iso-8859-1] Gary Martin wrote:

> Thank you for your support Andreas. Problems like this make me
> want to go back to Mac OS X, but there is something about Linux
> that draws me back. It has been a struggle --- I think a lot of
> the problems I have encountered with Linux have been the result of
> trying to run it on a PowerPC chip!!
As Marcel explained, this certainly does result in additional difficulties,
yes.

> Service Name: IrMC Synchronization
> Service RecHandle: 0x10006
> Service Class ID List:
>   "IrMCSync" (0x1104)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 11
>   "OBEX" (0x0008)
> Profile Descriptor List:
>   "IrMCSync" (0x1104)
>     Version: 0x0100
>
> [...]
>
> Yes --- there is an option in Multisync (IRMC-Bluetooth) to
> "search for units", and if found, "test connection" It just hangs
> during the search

Fine, so the only difference (apart from multisync itself) between our
phones is that "hcitool info <BDA>" does not work for you. The problem there
seems to arise at HCIGETCONNINFO and then hci_create_connection. Anybody
with BE hardware care to take a closer look at it? I unfortunately do not
own any (bluetooth capable).

ad


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
