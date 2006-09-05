Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200609052056.45443.cijoml@volny.cz>
References: <200609032015.51210.cijoml@volny.cz>
	<200609052044.30098.cijoml@volny.cz>
	<1157482537.5963.22.camel@localhost>
	<200609052056.45443.cijoml@volny.cz>
Date: Tue, 05 Sep 2006 21:00:33 +0200
Message-Id: <1157482833.5963.29.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez utils
	debian	package	doesn't	autoswith	dongle on?
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

Hi Michal,

> > > > > I just upgraded to 3.4 (my own compilation), but still the same -
> > > > > mouse's sensor switches off after 1 minute. Can you verify with your
> > > > > mouse? I think you have the same (Microsoft Intellimouse Explorer for
> > > > > Bluetooth 1st generation).
> > > >
> > > > I have no idea what you are talking about. First you spoke about the
> > > > dongle not autoinit and now it is about the mouse.
> > >
> > > Eh sorry this should go to different thread I have created and Pavel
> > > answered - see down here.
> > >
> > > But same problem with dongle autoinit with 3.4 - it doesn't go up when
> > > hid2hci is called, so I have to call it manually hciconfig hci0 up.
> >
> > can you test the CVS version. It is almost the 3.5 release. Only some
> > small cosmetic changes are missing. For me this is actually working.
> 
> this means autoup or sensor problem?

for the autoinit feature. Make sure it is set in hcid.conf and check
your syslog for error messages.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
