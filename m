Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060905164657.GA16417@suse.de>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
	<1157454451.4206.17.camel@localhost>
	<20060905164657.GA16417@suse.de>
Date: Tue, 05 Sep 2006 19:13:19 +0200
Message-Id: <1157476399.5963.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	Bug#385857:	[Pkg-bluetooth-maintainers]	Bug#385857: please
	upgrade to bluez-utils and	bluez-libs 3.4
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

> > > - I will add to bluez-utils a default non-interactive passkey agent (more or less
> > >   like now but less hackish) which uses /etc/bluetooth/passkeys/<bt_addr> like
> > >   now
> > 
> > Doesn't make sense, because it is distro specific and you duplicate
> > functionality that is already present. Don't do this. This stuff must
> > die. I am serious about it.
> 
> JFYI, i packaged the passkey-agent as-is for openSUSE factory and added a
> README, so the users can authenticate at all until the Desktop environments
> are ready. It might make sense to keep it IMO for all those people that do
> neither use gnome nor kde and still want to occasionally pair a rfcomm device,
> but maybe a multitude of easy to use passkey agents will pop up soon and
> we will have one for every taste :-)

my advise would be to include passkey-agent.c in the docs section as an
example. This is how other packages do it and to make this really clear,
the passkey-agent.c is an example. It is _NOT_ meant for any regular
installation. This is the reason why it is marked as noinst_*.

If something is marked as noinst_* in bluez-utils, then it is either an
example, not ready yet or to risky for installation. If you can't get it
installed with a configure option, then it is _NOT_ meant to be.

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
