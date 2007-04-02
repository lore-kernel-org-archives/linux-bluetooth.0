Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4610DF4D.4040003@access-company.com>
References: <4610D098.1030805@access-company.com>
	<1175510111.5815.310.camel@violet>
	<4610DF4D.4040003@access-company.com>
Date: Mon, 02 Apr 2007 12:54:54 +0200
Message-Id: <1175511294.5815.327.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Running bluez on vmware?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> Aside from vmware, we also tried qemu and the dongle was working, but it 
> was very slow. The whole emulator was locked and reacted from time to 
> time, thus we could do a discovery in 5 minutes... We were told this was 
> a qemu issue which used blocking IO, but an irda usb device was working 
> correctly.

depends on how the IrDA dongles works. If it only uses bulk endpoints
than this is quite clear. Bluetooth uses an interrupt endpoint for the
HCI events and this includes command status and command complete to
report the number of completed packets.

I never looked at the details of the Qemu implementation, but if it
doesn't use the async URB interface then you have problems. VMware is
using this interface and normally works quite good. You might wanna
simply try out VMware Workstation 6.0 beta something.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
