Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 18 Oct 2006 17:39:50 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061018153950.GJ30135@suse.de>
References: <1160984127.5498.0.camel@localhost> <A32i87f9SyB@trebges.web.de>
MIME-Version: 1.0
In-Reply-To: <A32i87f9SyB@trebges.web.de>
Subject: Re: [Bluez-users] PIN Authentication Problems on MDV 2007
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

On Tue, Oct 17, 2006 at 06:21:00PM +0200, Dietmar Segbert wrote:
> Hello Marcel,
> =

> > marcel@holtmann.org schrieb am 17.10.06:
> >>>> starting with bluez-utils-3.x the PIN helper concept has been
> >>>> replaced with a passkey agent interface. You need to run a
> >>>> passkey agent to get you PIN request dialog. One example would
> >>>> be bt-applet from the bluez-gnome package
> i have compiled bluez-utils-3.7 and copied the passkey-agent from the
> hcid/ to /usr/local/bin manually.
> =

> I have googled and i find a line
> =

> passkey-agent --default /usr/bin/bluepin

Well, only if you want your PIN to be "/usr/bin/bluepin" :-)

Just use "passkey-agent --default 1468", replace 1468 with $YOURPIN.

> I have not installed gnome on my system and so i can't compile bluez-
> gnome. I only use a textbased slackware 10.2 with speakup and brltty for
> speech and braille.
> =

> Must i install an other key-agent?

No, the passkey-agent from the hcid/ dir should work just fine for your cas=
e.
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
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
