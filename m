Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 21:58:38 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060714195838.GA31119@suse.de>
References: <Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
	<20060714064703.GA19807@suse.de>
	<Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
	<1152862064.13430.9.camel@localhost>
	<Pine.LNX.4.64.0607140931090.19685@ysf-zvav.gfns.pu>
	<Pine.LNX.4.64.0607141906370.9987@ybpnyubfg.ybpnyqbznva>
	<20060714180057.GH22273@suse.de>
	<Pine.LNX.4.64.0607142012590.23317@ysf-zvav.gfns.pu>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0607142012590.23317@ysf-zvav.gfns.pu>
Subject: Re: [Bluez-users] rfcomm pairing and timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Fri, Jul 14, 2006 at 08:14:42PM +0200, Andreas Fehr wrote:
> On Friday, 14. July 2006, 20:00, Stefan Seyfried (as SS) wrote:
> =

> >SS: There is a "passkey-agent" that's compiled but not installed, in =

> >SS: the hcid subdirectory. Copy this into your path, then do
> =

> Isn't this the same 'problem' with the agent to be for the incoming =

> connections only?

I don't think so. However, my knowlede comes from lurking in this list
and playing with bluez-3.1 since ~3 days, so i might be wrong.

> >SS:     passkey-agent --default 9999
> >SS: =

> >SS: before trying to pair the phone.
> =

> No success... and now I have lost my pairing of the device I created =

> with BlueZ 2.25 :-/

Can't you just initiate a pairing from the phone, so you can use the
passkey in hcid.conf? Maybe that's what i did, which let me claim it
worked ;-)

I'll play with this stuff more intensively next week and try to put together
some howto so we can all use our phones until kbluetoothd and co have caught
up ;-)
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
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
