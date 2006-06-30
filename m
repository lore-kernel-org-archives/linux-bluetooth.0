Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 30 Jun 2006 12:25:02 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44A4F25C.5000408@infitsrl.com>
Message-ID: <Pine.LNX.4.63.0606301219200.18028@redbean.intranet.gw-instruments.de>
References: <44A4E5A4.5070904@infitsrl.com>
	<1151657604.20305.9.camel@localhost>
	<44A4E987.1000104@infitsrl.com> <1151658731.20305.11.camel@localhost>
	<44A4F25C.5000408@infitsrl.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] sdp_connect thread safe?
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


Hi Fabrizio,

On Fri, 30 Jun 2006, Fabrizio Guglielmino wrote:

> In Microsoft stack I suppose sdp discovery of push service is masked in 
> sense I don't have to specify the RFCOMM channel when  I made  the 
> connection with device. In the SOCKADDR_BTH struct used by connect I 
> simply specify -1 in port field (channel) and all works with 100% of 
> opush enabled devices tested.

They are doing the SDP just before connecting the device. This normaly is 
save because a device usualy supports only one opush service. You may get 
problems for other service types (like SPP) when a device supports more 
than one. In this case you can not control to which service you realy 
connect. 

I also suppose they are doing some synchronisation on the lower level to 
make sure there is only one outstanding connection attempt, like Marcel 
already wrote. 

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
