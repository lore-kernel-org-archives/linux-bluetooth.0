Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151505157.599646.3431.nullmailer@galant.ukfsn.org>
References: <1151505157.599646.3431.nullmailer@galant.ukfsn.org>
Date: Wed, 28 Jun 2006 20:16:44 +0200
Message-Id: <1151518604.26495.13.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] ACL packet types
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

Hi Iain,

>    In bluez-lib-2.25 (I'm not up on latest version, sorry) there are
> functions to convert packet types to bit masks and vice versa but they are
> wrong.
> 
> If you look at the 2.0 Core specification for the "Create Connection"
> command, it shows that the bits for the 2Mbps and 3Mbps packet types are
> inverted - ie, when the bit is set, the packet type is NOT permitted.
> 
> I noticed this using hcidump, it prints the packet types wrongly.
> 
> 0xff1e = DH1 DM1 DH3 DM3 DH5 DM5
> 0xcc18 = DH1 DM1 DH3 DM3 DH5 DM5 2-DH1 3-DH1 2-DH3 3-DH3 2-DH5 3-DH5

I don't get your point. If you see 2-x and 3-x, it means that EDR has
been disabled. You will see this if a EDR capable dongle tries to
connect to a non-EDR capable device.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
