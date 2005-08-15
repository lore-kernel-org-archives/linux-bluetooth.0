Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A90@netbe01.net.unimis>
Message-ID: <Pine.LNX.4.33.0508151215550.14429-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Aug 2005 12:16:42 +0200 (CEST)


Hi AL,

I think you will need hcid anyway to do anything usefull.

Ciao,

Peter

On Mon, 15 Aug 2005, Al wrote:

> Hi,
>
>      I resolved the problem of integrating HCI driver. I can now use
> "hciconfig hci0 up" to bring up the device. MAC address can be read
> correctly. Kernel porting seems ok so far.
>
>     But when I use "hciconfig -a", it has problem to read "Name", "Clas=
s",
> and so on from /etc/bluetooth/hcid.conf (which I created already in the
> embedded
> ramdisk). Any dependancy among those utilities? For example, if I need =
to
> use "hciconfig",
> "hcid" is needed?
>
> thanks for helps,
>
> Al
>
> ----- Original Message -----
> From: "durai" <durai@isofttech.com>
> To: <bluez-devel@lists.sourceforge.net>
> Sent: Monday, August 15, 2005 3:22 PM
> Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
>
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net =A5N=B2z durai
> Sent: 2005/8/15 [=ACP=B4=C1=A4@] =A4U=A4=C8 03:22
> To: bluez-devel@lists.sourceforge.net
> Cc:
> Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
>
>
>
> 	Hi Al,
> 	I recently ported bluez stack in a embedded linux running 2.4.18 kerne=
l.
> 	First I downloaded the MH patch from  http://www.holtmann.org/linux/ke=
rnel/.
> 	and
> 	applied it. Now both statically compiled driver as well as modules are
> 	working correctly.
> 	You can also try finding an appropriate patch and patch it with your k=
ernel.
> 	But what is
> 	surprising for me is, though your kernel is 2.4.21 and you are not abl=
e to
> 	find the options in
> 	make menuconfig.  I guess something  is messed up in your package.
>
> 	Can you find "hci_usb_init" in your System.map? Is it integrated corre=
ctly?
> 	regards
> 	durai
>
>
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
