Return-Path: <cyrus@holtmann.org>
Message-ID: <479F5780.7080101@wurmsdobler.org>
Date: Tue, 29 Jan 2008 16:42:40 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <OF57915B80.8FBC7A49-ON802573DF.003F8EDF-802573DF.003FEE1C@camcon.co.uk>
	<200801291235.37973.chick@computergeek.freeserve.co.uk>
In-Reply-To: <200801291235.37973.chick@computergeek.freeserve.co.uk>
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

Thanks for the hints.
> hciattach /dev/ttyS0 bcsp
> bccmd -t HCI psload -r my.psr
> killall hciattach
> hciattach /dev/ttyS0 bcsp
hciattach, most of the time, does not work:

	peter@linuxpc:> hciattach /dev/ttyS0 bcsp
	Initialization timed out

On one occasion, which I cannot reproduce, hciattach actually worked to 
some extent:

	peter@linuxpc:> hciattach /dev/ttyS0 bcsp
	peter@linuxpc:> hciconfig
	hci0:   Type: UART
	        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
	        DOWN
	        RX bytes:15 acl:0 sco:0 events:0 errors:0
	        TX bytes:8 acl:0 sco:0 commands:0 errors:0

Any subsequent call to download the psr file failed:

	peter@linuxpc:> bccmd -t hci psload my.psr
	Device not available
	peter@linuxpc:> bccmd -t hci -d /dev/ttyS0 psload my.psr
	Device not available

I also tried to connect from a Windows PC using BTcli:

	btcli (built Jan 17 2007, 15:35:14)
	Version 1.24
	BSCP on COM1 at 38400 bps
	rba
	command_complete nhcp:0x01 read_bd_addr success ba 0x00025b00a5a5

Why is it impossible for the Linux host to communicate with the BC4-ROM? 
What do I miss?

Thanks for any hints,
peter




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
