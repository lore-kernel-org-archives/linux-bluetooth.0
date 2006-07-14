Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 08:47:03 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060714064703.GA19807@suse.de>
References: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
	<1152820951.4838.76.camel@localhost>
	<Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
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

On Fri, Jul 14, 2006 at 06:12:41AM +0200, Andreas Fehr wrote:
> On Thursday, 13. July 2006, 23:04, Marcel Holtmann (as MH) wrote:
> =

> >MH: > >MH: > I've still a problem with pairing my phone with my =

> >MH: > >MH: > bluetooth dongle. My phone asks me if I want a serial port =

> >MH: > >MH: > connection with computer. As soon as I accept this, the =

> >MH: > >MH: > dialog to enter the pin shows but disappears within about =

> >MH: > >MH: > 1 second. Far to few time to enter any pin.
> >MH: > >MH: > =

> >MH: > >MH: > Is there a way to set some other timeout for pairing?

How did you configure the PIN on your machine?
Do you have a passkey agent?

> And again, vmware with USB and the same bluetooth dongle does work and =

> the old driver 2.x did work to.

Do you know, that the PIN handling changed with BlueZ 3.0?

Short:
- pin is no longer in /etc/bluetooth/pin. Now is in /etc/bluetooth/hcid.con=
f.
- set "security auto;" and "passkey "yourpin";" in /etc/bluetooth/hcid.conf
  and try again.

I guess you do not see a timeout, but an rejection, since hcid has no PIN a=
nd
no passkey-agent, so it already knows, that it cannot authenticate the phone
and rejects it right away.
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
