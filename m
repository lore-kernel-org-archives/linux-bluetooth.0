Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 5 Jul 2006 14:38:03 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003501c6a02d$e6b8c8c0$2800a8c0@Desarrollo>
Message-ID: <Pine.LNX.4.63.0607051432230.3048@redbean.intranet.gw-instruments.de>
References: <003e01c69e8c$c0717970$2800a8c0@Desarrollo><Pine.LNX.4.63.0607031426320.28132@redbean.intranet.gw-instruments.de><e1effdeb0607030546w38382e5ct4bb6bed8c0271da8@mail.gmail.com><01e101c69eb9$50f41670$2800a8c0@Desarrollo><003001c69f95$0b1ab140$2800a8c0@Desarrollo><e1effdeb0607041156y797a376cn2081738e19559605@mail.gmail.com><e1effdeb0607041532x5701ab2eib524b5c70f0dc436@mail.gmail.com>
	<1152053676.29250.4.camel@localhost>
	<003501c6a02d$e6b8c8c0$2800a8c0@Desarrollo>
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


Hello Victor, 

On Wed, 5 Jul 2006, Victor Andres wrote:

> Well, I really want to conect more than 7 devices to my Pc, using 
> bluetooth-usb adapters (one, or more than one adapters). And the profile a 
> need to use is SPP, serial port. the devices are gps-gluetooth.
> 
> Where can I find a exaple about how can I do it?
> 
> Thanks, and excuse my persistance.
Well, you have to choices (maybe 3 if DBUS is one, haven't checked). 
You may use either rfcomm ttys or direct rfcomm socket programming. For 
tty just bind all remote devices (man rfcomm). Than connect by openning 
the rfcomm ttys and you can read the GPS data from teh tty like a normal 
serial connection. 

For an example on how to use direct socket programming you may have a look 
at dund or some other examples. 

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
