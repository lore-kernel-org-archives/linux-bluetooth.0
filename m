Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 18:46:57 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060905164657.GA16417@suse.de>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
	<1157454451.4206.17.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1157454451.4206.17.camel@localhost>
Subject: Re: [Bluez-devel] Bug#385857:
	[Pkg-bluetooth-maintainers]	Bug#385857: please upgrade to
	bluez-utils and bluez-libs 3.4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, Sep 05, 2006 at 01:07:31PM +0200, Marcel Holtmann wrote:
> Hi Filippo,
> > =

> > - I will add to bluez-utils a default non-interactive passkey agent (mo=
re or less
> >   like now but less hackish) which uses /etc/bluetooth/passkeys/<bt_add=
r> like
> >   now
> =

> Doesn't make sense, because it is distro specific and you duplicate
> functionality that is already present. Don't do this. This stuff must
> die. I am serious about it.

JFYI, i packaged the passkey-agent as-is for openSUSE factory and added a
README, so the users can authenticate at all until the Desktop environments
are ready. It might make sense to keep it IMO for all those people that do
neither use gnome nor kde and still want to occasionally pair a rfcomm devi=
ce,
but maybe a multitude of easy to use passkey agents will pop up soon and
we will have one for every taste :-)
-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
