Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Steven Singer <steven.singer@csr.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <406B17A4.8000607@superbug.demon.co.uk>
References: <406A9E23.9000406@soft.uni-linz.ac.at>
	 <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at>
	     <406ADF3E.4020502@csr.com> <406AE027.7030000@soft.uni-linz.ac.at>
	 <406AF150.8080105@csr.com> <406B17A4.8000607@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1080761775.2536.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 31 Mar 2004 21:36:15 +0200

Hi James,

> Just out of interest, how does one upgrade the firmware on a USB device 
> using a CSR chip ?
> 
> I have this device: -
> 
> bash-2.05b# hciconfig hci0 version
> hci0:   Type: USB
>          BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x135
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> bash-2.05b# hciconfig hci0 revision
> hci0:   Type: USB
>          BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
>          HCI 13.10
>          Chip version: BlueCore01b
>          Max key size: 56 bit
>          SCO mapping:  HCI

you need a *.dfu firmware file from your dongle manufacturer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
