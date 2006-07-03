Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 3 Jul 2006 14:29:42 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003e01c69e8c$c0717970$2800a8c0@Desarrollo>
Message-ID: <Pine.LNX.4.63.0607031426320.28132@redbean.intranet.gw-instruments.de>
References: <003e01c69e8c$c0717970$2800a8c0@Desarrollo>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Serial comunication RFCOMM
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


Hi Victor, 

On Mon, 3 Jul 2006, Victor Andres wrote:

> Hi. I'm a new developer of bluez API. I would like that someone say if 
> is posible to do I want.
> 
> Is it posible to link (bluetooth) multiple devices to mi PC using Linux 
> and Bluez stack (using multple usb-bluetooth adapter if it's necesary)?
> 
> I want link my PC with multiples (more than 7) GPS bluetooth (so I 
> can't do it with windows stack), to receive the NMEA sentences and 
> manipulate then (get the latitud, longitud, speed ...).

I don't see anything which should prevent you from doing so. 
And as far as I know BlueZ currently is the only Bluetooth Stack which 
supports multiple HCI devices. 

Ciao, 

Peter 



|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
