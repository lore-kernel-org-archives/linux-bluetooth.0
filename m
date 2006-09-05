Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060905203814.GA4515@suse.de>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
	<1157454451.4206.17.camel@localhost>
	<20060905164657.GA16417@suse.de> <1157476399.5963.4.camel@localhost>
	<20060905181547.GA17557@suse.de> <1157482774.5963.27.camel@localhost>
	<20060905203814.GA4515@suse.de>
Date: Tue, 05 Sep 2006 23:08:31 +0200
Message-Id: <1157490511.5963.53.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	Bug#385857:	[Pkg-bluetooth-maintainers]	Bug#385857: please
	upgrade	to	bluez-utils and	bluez-libs 3.4
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

Hi Stefan,

> > Let me put it this way. The 3.0 announcement came with a clear warning
> > that the PIN helper is dead and we now need a default passkey agent for
> > every desktop. It was one reason why I jumped to next major number. I
> > don't do this without a serious reason. I provided an example of a
> > passkey agent and the Maemo guys implemented a passkey agent for their
> > platform, but nobody else seemed to care.
> 
> In the KDE case, i think that the kdebluetooth code is pretty much without
> an active maintainer. But i have a promising new talent at hand that will
> start fixing and bring it up to date :-)

sounds great. Please tell him that he should use the BlueZ D-Bus API
only. So a linking against libbluetooth is not an option anymore. This
will be the way we will go for the GNOME stuff, too.

Since I will travel tomorrow to Nuremberg for the Linux-Kongress, you
might wanna send him to my talk ;)

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
