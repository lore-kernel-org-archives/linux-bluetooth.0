Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 8 Nov 2006 08:45:57 +0100
From: Stefan Seyfried <seife@suse.de>
To: systemparadox@gmail.com, BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061108074557.GF12136@suse.de>
References: <4550A095.6060000@gmx.de> <20061107155257.GB22290@suse.de>
	<4550BC83.6070607@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4550BC83.6070607@gmail.com>
Subject: Re: [Bluez-users] usb-device cannot be found by other
	bluetooth	devices
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

On Tue, Nov 07, 2006 at 05:04:03PM +0000, Simon Williams wrote:
> Stefan Seyfried wrote:

> > use "apitest" to set the DiscoverableTimeout to 0:
> > =

> >     apitest SetDiscoverableTimeout 0
> > =

> > then set your device to discoverable:
> > =

> >     apitest SetMode discoverable
> > =

> > verify your settings with
> > =

> >     apitest IsDiscoverable
> >     apitest GetMode
> >     apitest GetDiscoverableTimeout
> > =

> =

> Alternatively, make sure that hscan and pscan are enabled for that device.

IIRC this will still be disabled after DiscoverableTimeout seconds.
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

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
