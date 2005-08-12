Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A89@netbe01.net.unimis>
Message-ID: <Pine.LNX.4.33.0508121431290.4037-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 12 Aug 2005 14:34:09 +0200 (CEST)


Hi Al,

when I remember your original posting right the error message was
something like "protokoll family not registered...". This may be the case
when the BlueZ is not initialized. Do you get some start up message from
BlueZ when your system boots up ??

Ciao,

Peter

On Fri, 12 Aug 2005, Al wrote:

> Hi,
>
> > Strange ! What "package" are you using ??
> Yeah, somehow BlueZ is missing in config file. But
> other BlueZ stuffs are there in kernel.
> It's an ARM7 development toolkit with uClinux ported.
>
> > Is the USB dongle detected by the USB subsystem ???
> Yes, I think so.
>
> I just wonder did I miss any other BlueZ directory in kernel?
> 1. Protocol stack: linux/net/bluetooth
> 2. HCI device driver: linux/drivers/bluetooth
> 3. I haven't put anything in /etc/bluetooth, does it matter for the error?
>     I just want to use " hciconfig" to list bluetooth USB dongle now.
>
> Thanks for helps,
>
> Al
>
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
