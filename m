Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060820105235.GB12991@esaurito.net>
References: <20060820105235.GB12991@esaurito.net>
Date: Sun, 20 Aug 2006 16:26:05 +0200
Message-Id: <1156083965.23331.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: fexpop@onlinehome.de, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [fexpop@onlinehome.de:	[Pkg-bluetooth-maintainers]
	Bug#379401: bluez-utils: 3.1-2 renders system	invisible for
	other BT devices]
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

Hi Filippo,

> I'm forwarding this bug upstream also because I've received another private
> report with the same problem.
> The problem is that [ip]scan isn't enabled on device even if specified into
> hcid.conf, but setting it with hciconfig works.
> I suspect that this is dongle-specific because on my system it works as
> expected.

if I am not mistaken, then this is the problem with actually setting the
inquiry mode on a dongle that doesn't support this command. This is
fixed in the CVS and will show up in the next release.

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
