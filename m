Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 19 Aug 2006 15:40:29 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <04ED5B65E3B4A64B97C16E22E0DF16D5184947@mh23ex03.informatica.com>
Message-ID: <Pine.LNX.4.63.0608191533270.32617@redbean.intranet.gw-instruments.de>
References: <04ED5B65E3B4A64B97C16E22E0DF16D5184947@mh23ex03.informatica.com>
MIME-Version: 1.0
Cc: mdeiters@Informatica.com
Subject: Re: [Bluez-devel] BT connection hangs above a certain speed - help
 needed
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


Hello Michael, 

On Sat, 19 Aug 2006, Deiters, Michael wrote:

> > Hello everybody,
> > 
> > I am currently stuck with BlueZ Version 3.2 and seek help by posting to this list.
> > 
> > Technical environment:
> > - Several 3G Mobile Phones
> > - Sharp Zaurus 2.4.18 Kernel, Nokia DTL4
> > - Dell Laptop, 2.6.xx  (SuSE 10.1) 3Com BT Card.

This sounds very much like a hardware problem. I'm not familiar with 
the Zaurus but from our experience I would say there is a problem either 
with te HCI communication or with the Bluetooth Chip itself. 

First, make sure you use hardware handshake for the HCI port (see 
hciattach dokumentation). If this doesn't work you may also try to use 
BCSP protocol if the Zaurus uses a CSR chip. 

Good luck, 

Pete 



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
