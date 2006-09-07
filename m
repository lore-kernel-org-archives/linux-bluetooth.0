Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4500A2A7.6000606@xmission.com>
Date: Thu, 07 Sep 2006 16:52:23 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>	<44FE42C7.7030100@xmission.com>
	<44FE95CE.1090502@palmsource.com>	<1157647703.16404.2.camel@localhost>
	<45007741.8020506@xmission.com>
	<1157663181.14539.4.camel@localhost>
In-Reply-To: <1157663181.14539.4.camel@localhost>
Subject: Re: [Bluez-devel] Big patch to a2dpd
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

Andrew

> I notice that the maximum volume is a lot lower from my PC than my
> wondows PDA is there anyway to increase the volume at the PC side before
> transmission to the headset.?

I'm afraid the problem is in the encoder. When we went to fixed point,
the stream would "snap" every few seconds when the math would overflow.
we had to fiddle a lot with levels so it wouldn't overflow and now we're
knocking out too much steam.

brad



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
