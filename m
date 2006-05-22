Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <447140B7.2090100@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <4461A33F.1060702@killesreiter.de> <44634846.3000006@xmission.com> <Pine.LNX.4.63.0605111727560.7379@redbean.intranet.gw-instruments.de> <4461FE7D.3050108@killesreiter.de> <447105B1.3060908@killesreiter.de>
In-Reply-To: <447105B1.3060908@killesreiter.de>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: broadcom in disguise...
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 May 2006 22:40:23 -0600

Gerhard

> I went to town and did just that. I ended up buying a Typhoon bluetooth
> usb adapter (http://www.typhoon.de/de/art.php?p=838&pv=3). I had the
> clerk check out the webpage for me and there we found "Functions: Main
> chip - CSR BlueCore ". That's why I bought it and didn't check out th
> other available devices (only one).

A couple of manufacturers switched from csr to broadcom around the time
bluecore4 and the other edr chips came out. Not sure why.

The mtu workaround is the only way we've had any success using broadcom
but it only works with some chips. If you've used the adapter in windows
for sco audio then it might change some nvram settings. I'm not familiar
enough with the lower layers to suggest anything else.

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
