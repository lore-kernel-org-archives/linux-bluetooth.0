Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4749FAD6.6080403@uni-koeln.de>
References: <4745D9EE.4020101@uni-koeln.de>  <4749FAD6.6080403@uni-koeln.de>
Date: Mon, 26 Nov 2007 06:38:46 +0100
Message-Id: <1196055526.4217.44.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
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

Hi Paul,

> after a lot of testing, I found a (really ugly) workaround for my 
> problem, so I post it here, if someone gets the same wired problem someday:
> The verbose mode of hcidump show the right Mac while a 'hcitool scan' on 
> an other console:
> 
> # hcidump -V
> HCI sniffer - Bluetooth packet analyzer ver 1.39
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 8 num 0
>  > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
>  > HCI Event: Inquiry Result (0x02) plen 15
>     bdaddr 00:12:EE:58:72:1C mode 1 clkoffset 0x5c3f class 0x5a0204
>  > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 02:01:00:12:EE:58 mode 0 clkoffset 0x0000 (valid)
>  > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>  > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x04 bdaddr 02:01:00:12:EE:58 name ''
> 
>     Error: Page Timeout
> 
> the name request fails of course with a annoying timeout.  So I make the 
> scan with python and without name checking (of course you can use 
> hcitool inq too):

if you would use the D-Bus API, then you don't have this problem.
However there was a bug in the 3.22 library that I fixed now. Install
the library from CVS and you should be good. Or use 3.21.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
