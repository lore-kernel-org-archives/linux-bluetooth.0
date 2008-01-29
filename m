Return-Path: <cyrus@holtmann.org>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-users@lists.sourceforge.net
Date: Tue, 29 Jan 2008 12:35:36 +0000
References: <OF57915B80.8FBC7A49-ON802573DF.003F8EDF-802573DF.003FEE1C@camcon.co.uk>
In-Reply-To: <OF57915B80.8FBC7A49-ON802573DF.003F8EDF-802573DF.003FEE1C@camcon.co.uk>
MIME-Version: 1.0
Message-Id: <200801291235.37973.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-users] mx27, csr and bluez: initialisation timed out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

>  [Bluez-users] mx27, csr and bluez: initialisation timed out
> From: Peter Wurmsdobler <peter@wu...> - 2008-01-22 13:46
>
> The kernel boots, and the bluetooth related facilities printk some
> messages such as HCI UART driver ver 2.2, H4 and BCSP protocol
> initialised. Since the BlueTooth module does not know the clock
> frequency it is using, or the baud rate of the host, I need to
> "configure" the BlueCore and warm-reset it:
>
> mx27# bccmd -t BCSP -d /dev/ttymxc1 psload config.psr warmreset
>

What you actually want is:

bccmd -t BCSP -d /dev/ttymxc1 psload -r config.psr

as bccmd can only perform one command at a time.

> However, the only message I get is: "Initialization timed out",
> which, looking through the code, is generated in
> bluez/tools/csr_bcsp.c in the open function. But why?
>

There appear to be some races in the BCSP, which may not cause a problem 
on a PC. I have some changes and will publish to the devel list.

As a work around, the following works reliably for me:

hciattach /dev/ttyS0 bcsp
bccmd -t HCI psload -r my.psr
killall hciattach
hciattach /dev/ttyS0 bcsp

Cheers,
Tim


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
