Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44FC4E5F.1000308@evilgenius.de>
References: <44F22717.1080308@evilgenius.de>
	<1156772287.5613.31.camel@aeonflux.holtmann.net>
	<44F32933.90808@evilgenius.de>
	<1156799873.5613.51.camel@aeonflux.holtmann.net>
	<44F353E9.7080406@evilgenius.de>
	<1156809428.5613.59.camel@aeonflux.holtmann.net>
	<44F43AA3.3020600@evilgenius.de>
	<1156874442.4026.22.camel@aeonflux.holtmann.net>
	<Pine.LNX.4.63.0608291840350.30948@redbean.intranet.gw-instruments.de>
	<44FC4E5F.1000308@evilgenius.de>
Date: Mon, 04 Sep 2006 20:06:09 +0200
Message-Id: <1157393169.32195.86.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

Hi Martin,

> >> and remember that it is dangerous. I already killed a couple of my
> >> dongles and I only use a Casira development kit from CSR when playing
> >> with this stuff. In the cases I screwed up, I can reset the module and
> >> get it back working. Most times at least. I already killed one module
> >> some time ago.
> > 
> > You normaly can recover from this by doing a full chip erase and 
> > reprogramming from scratch. However, any module specific PS settings will 
> > be lost if you don't have a "backup".......
> 
> is casira more than some hardware which consists of some
> voltage-converters, and software mostly equivalent to several bluez tools?

the Casira gives you access to the SPI interface of the BlueCore chip
and this lets you do some of the nasty stuff you basically only need in
pre-production.

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
