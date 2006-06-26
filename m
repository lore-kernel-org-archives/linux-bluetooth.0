Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BED9D15F73EDDE48BF480604236A456001DE40F7@ex1.ad.dcs.gla.ac.uk>
References: <1151066205.6247.19.camel@addu>
	<1151324247.7694.10.camel@localhost> <1151334192.29221.7.camel@addu>
	<1151336865.7694.37.camel@localhost>
	<BED9D15F73EDDE48BF480604236A456001DE40F7@ex1.ad.dcs.gla.ac.uk>
Date: Mon, 26 Jun 2006 19:21:40 +0200
Message-Id: <1151342500.7694.40.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] L2CAP MTU and packet fragmentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Stephen,

> > If you actually use L2CAP data channel with SOCK_SEQPACKET then you
> > won't see a loss at all. It is a reliable channel.
> 
> Yeah, this is what I'm doing, but I'm seeing loss.
> 
> I'm following the code from http://people.csail.mit.edu/albert/bluez-intro/x556.html, but not fiddling with anything related to unreliability in section 4.3.2.
> 
> Trying the same between two different machines gets me the reliable data transfer.
> 
> Am I dealing with bad hardware here? Hardware with bad drivers (I'm dealing with Bluetooth built into a HP iPaq running Familiar Linux, kernel version 2.6.12)? Or an out of date bluez-utils (bluez-utils-nodbus package is version 2.14-r4)?

you can't see loss on the L2CAP data channel. This is impossible.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
