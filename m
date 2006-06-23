Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 23 Jun 2006 12:11:24 -0400
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65ED87BC@MAIL006.mail.lan>
In-Reply-To: <Pine.LNX.4.63.0606231751350.25515@redbean.intranet.gw-instruments.de>
From: "Brand, Chris" <chris.brand@qwikker.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] CSR hci continuous transmit mode?
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


> > Does anyone know how to put a CSR Bluecore chip into continuous 
> > transmit mode using hcitool?
> > 
> You can not do that using HCI Tool because this is a CSR 
> specific low level testing command (may be you can figure our 
> the necessary command sequence, but this will be very complicated). 
> 
> And as far as I know also the bccmd tool does not support CSR 
> RF test commands. 

This might be completely off-base, but it might not, so here goes...

I was looking at how to send the CSR "Enter Device Under Test Mode"
command, which sounds like it may be related. I found the ogf, ocf and
parameters in the CSR documentation (0x6, 0x3 and none, in this case).
Then I used
hcitool cmd 0x6 0x3
To send that command to the chip.

Chris

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
