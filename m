Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 16 Oct 2006 20:40:20 +0300
From: Anssi Saari <anssi.saari@iki.fi>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061016174019.GA32424@jolt.modeemi.cs.tut.fi>
References: <20061013114406.GA857@jolt.modeemi.cs.tut.fi>
	<1160918097.23675.15.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1160918097.23675.15.camel@localhost>
Subject: Re: [Bluez-users] Old Socket CF BT hangs
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

On Sun, Oct 15, 2006 at 03:14:57PM +0200, Marcel Holtmann wrote:
> Hi Anssi,
> 
> > I have this old Socket CF bluetooth card which uses the dtl1_cs driver.
> > It works fine, except it hangs every now and then, when using it for net
> > access via a GSM phone. By hanging I mean that data stops flowing over
> > the ppp interface and the card won't respond to hcitool scan or other
> > similar commands, I just get a timeout. I need to do pccardctl eject 1;
> > pccardctl insert 1 to recover. I can't find any error messages in the
> > logs when this hang occurs.
> > 
> > Usually I can cause the hang by opening a bunch of links in a web
> > browser. The odd thing is that this seems to be more common the faster
> > the phone is. With my old Ericsson T68 (GPRS) it's very rare but with
> > my newer Nokia 6820 (EDGE) it's annoyingly common.
> > 
> > I'm currently running Arch Linux with kernel 2.6.17-beyond4 on an IBM
> > Thinkpad X20. Bluez-libs and bluez-utils are version 3.1. However,
> > I noticed this problem in 2005 summer already with I think kernel 2.6.11
> > and 2.6.12.
> > 
> > Has this sort of thing been reported by anyone else?
> 
> when I wrote the dtl1_cs driver it was back in 2001 and most devices
> where not capable of high speeds like EDGE. So this is actually a driver
> problem, but at the moment I have no idea on how to fix it. I haven't
> looked at this driver for a very long time.

Well, can I help in any way? I'm sure I have even less idea how to fix this
than you :) If you need the card, I can loan it since it's not very
useful as is. I'll just have to get by with one of those cheap USB thingies.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
