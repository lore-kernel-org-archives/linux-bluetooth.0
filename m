Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
	<45094871.7010003@infitsrl.com>
	<Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
Date: Fri, 15 Sep 2006 11:44:25 +0200
Message-Id: <1158313465.5233.3.camel@localhost>
Mime-Version: 1.0
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

Hi Peter,

> > I'm not expert in bluez kernel driver programming but I've developed an 
> > application using socket abstraction
> > on Windows (microsoft stack) and I can connect simultaneously to many 
> > devices (7 max) with the same usb dongled
> > tested with bluez on linux. So I think it can't be a hardware problem, 
> > or better may be the hardware limitation but I think it's bypassable
> > in software layers.
> > bye
> > Fabrizio
> 
> The problem is not to connect to 7 devices simultaniuous. The problem is 
> that (on the HCI level) most (or all??) devices gives you an error 
> response when you start a new connection while there is an outstanding 
> connection request. Of cause you can come arround this by software on the 
> upper level. E.g. you can make sure not to send a new connect request to 
> the device while it has not responeded to the previous one. 

my last attempt to make this work actually failed, but I didn't put much
energy into it. Feel free to come up with a working version. The path
how to handle this is clear.

> Don't know what microsoft is doing here (don't have their source ;-). 

They will do something similar. If you get a HCI trace, then you can see
for yourself what they are doing.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
