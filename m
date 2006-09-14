Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 14 Sep 2006 14:30:22 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45094871.7010003@infitsrl.com>
Message-ID: <Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
	<45094871.7010003@infitsrl.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] About concurrency sdp_connect
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

On Thu, 14 Sep 2006, Fabrizio Guglielmino wrote:

> Hi Peter,
> I'm not expert in bluez kernel driver programming but I've developed an 
> application using socket abstraction
> on Windows (microsoft stack) and I can connect simultaneously to many 
> devices (7 max) with the same usb dongled
> tested with bluez on linux. So I think it can't be a hardware problem, 
> or better may be the hardware limitation but I think it's bypassable
> in software layers.
> bye
> Fabrizio

The problem is not to connect to 7 devices simultaniuous. The problem is 
that (on the HCI level) most (or all??) devices gives you an error 
response when you start a new connection while there is an outstanding 
connection request. Of cause you can come arround this by software on the 
upper level. E.g. you can make sure not to send a new connect request to 
the device while it has not responeded to the previous one. 

Don't know what microsoft is doing here (don't have their source ;-). 

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
