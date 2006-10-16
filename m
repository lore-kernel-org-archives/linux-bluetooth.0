Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 16 Oct 2006 12:40:27 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4532BD75.6050405@xmission.com>
Message-ID: <Pine.LNX.4.63.0610161234370.18216@redbean.intranet.gw-instruments.de>
References: <453296A6.5030505@xmission.com>
	<1160943663.14340.10.camel@localhost>
	<4532A5C1.4080504@xmission.com> <1160947761.14340.13.camel@localhost>
	<4532BD75.6050405@xmission.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] pskey gone, but bccmd won't build
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


Hi Brad, 

inofficial answer below ...... 

On Sun, 15 Oct 2006, Brad Midgley wrote:

> Marcel
> 
> I see a few values without a description. If someone knows where I can
> look these up, I'd give you a patch.
> 
> # ./bccmd -t HCI psread

> // 0x00dc
Local Name 0 (only used by older FW) 
> &00dc = 006d 0065 0064 002d 0030 0000 0000 0000 0000 0000 0000 0000 0000
> 0000

> // 0x00dd
Local Name 1 (only used by older FW) 
> &00dd = 002e 0063 006f 006d 002d 0030 0000 0000 0000 0000 0000 0000 0000
> 0000

> // 0x00ee
Local Name Length
> &00ee = 0005

> // 0x0191
PSKEY_HOSTIO_UART_PS_BLOCK
> &0191 = 03b0 00a8 00fa 0014 0004 0000 0004 001e 0064 000a

All keys you asked for are only used by older CSR FW Versions (I think pre 
1.2.18 or so). 

Ciao, 

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
