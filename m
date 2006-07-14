Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 20:00:57 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060714180057.GH22273@suse.de>
References: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
	<1152820951.4838.76.camel@localhost>
	<Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
	<20060714064703.GA19807@suse.de>
	<Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
	<1152862064.13430.9.camel@localhost>
	<Pine.LNX.4.64.0607140931090.19685@ysf-zvav.gfns.pu>
	<Pine.LNX.4.64.0607141906370.9987@ybpnyubfg.ybpnyqbznva>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0607141906370.9987@ybpnyubfg.ybpnyqbznva>
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

On Fri, Jul 14, 2006 at 07:26:17PM +0200, Andreas Fehr wrote:

> Anyway... this might be the problem... how do I configure a pin_helper? =

> I read the announcement of BlueZ 3.0, all I saw was the new ability with =

> a D-Bus passkey agent. But how to setup? (I have to admit, I didn't read =

> the D-Bus documentation, but a link would be nice).

There is a "passkey-agent" that's compiled but not installed, in the hcid
subdirectory. Copy this into your path, then do

    passkey-agent --default 9999

before trying to pair the phone.

This worked for me.
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
