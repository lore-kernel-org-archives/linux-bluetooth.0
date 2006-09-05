Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 22:38:15 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060905203814.GA4515@suse.de>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
	<1157454451.4206.17.camel@localhost>
	<20060905164657.GA16417@suse.de>
	<1157476399.5963.4.camel@localhost>
	<20060905181547.GA17557@suse.de>
	<1157482774.5963.27.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1157482774.5963.27.camel@localhost>
Subject: Re: [Bluez-devel]
	Bug#385857:	[Pkg-bluetooth-maintainers]	Bug#385857: please
	upgrade to	bluez-utils and	bluez-libs 3.4
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

Hi,

On Tue, Sep 05, 2006 at 08:59:34PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
> =

> > Well, that would mean that i'd have to document /var/lib/bluetooth/*/pi=
ncodes
> > and i'd want to avoid that.
> =

> you should avoid this when possible.

absolutely. This is why i'd rather provide passkey-agent as a band-aid :-)

> >  	snprintf(default_path, sizeof(default_path),
> >  				"/org/bluez/passkey_agent_%d", getpid());
> =

> That might do it. Of course every user must start this by hand and it is
> not automated somehow (init script or desktop startup). There can only

Yes. This is only for the "user has installed new openSUSE factory and now
wants to pair his device"-case. And now he even gets a warning that he shou=
ld
not build important parts of his enterprise infrastructure on the availabil=
ity
of passkey-agent :-)

> > Yes. But for the users, there is no way to pair their devices without a
> > passkey agent. And not everybody can use latest bluez-gnome, but might =
still
> > be a valuable tester for bluez-utils :-)
> =

> Let me put it this way. The 3.0 announcement came with a clear warning
> that the PIN helper is dead and we now need a default passkey agent for
> every desktop. It was one reason why I jumped to next major number. I
> don't do this without a serious reason. I provided an example of a
> passkey agent and the Maemo guys implemented a passkey agent for their
> platform, but nobody else seemed to care.

In the KDE case, i think that the kdebluetooth code is pretty much without
an active maintainer. But i have a promising new talent at hand that will
start fixing and bring it up to date :-)

> The passkey agent interface is fully language independent and they could
> have written one in C, C++, C#, Perl, Python, Java, Haskell and every
> language that provides a D-Bus binding. And again, nobody did. Now I
> gave people two examples on how to write a passkey agent. So they either
> do it now or start using GNOME ;)

There is already work being done for kdebluetooth, i have seen the
"prototype". But apparently the existing code is quite - "interesting"
and needs some cleanup before this can go out to the public.

Everything will be fine :-)
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


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
