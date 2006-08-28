Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 28 Aug 2006 19:52:55 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44F32B56.3010803@evilgenius.de>
Message-ID: <Pine.LNX.4.63.0608281950380.30948@redbean.intranet.gw-instruments.de>
References: <70DCB28C5BB04A4BBB1C8512589BAC65012DD931@MAIL006.mail.lan>
	<44F32B56.3010803@evilgenius.de>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] flexible bt-dongle and bccmd
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


Hi 

	0 - No chip to host connection
        1 - BCSP
        2 - H2 - USB
        3 - H4 - UART
        4 - VM access to the UART
        6 - H5
        7 - H4DS

not all variants are available with all firmware versions. Anyway, you're 
not expected to play with it unless you realy know what you are doing 
there. If changed to a wrong setting your hardware is ready for the 
garbage can. 

Ciao, 

Peter 


On Mon, 28 Aug 2006, Martin Karger wrote:

> Brand, Chris wrote:
> >  
> >> and btw, what is PSKEY_HOST_INTERFACE for?
> > 
> > It controls how the host interfaces with the BlueCore chip (USB or
> > UART).
> 
> i guess 0x0002 stands for usb? so 0x0001 should be uart? any other
> possible values?
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


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
