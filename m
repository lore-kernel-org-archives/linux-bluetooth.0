Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 11:07:33 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061113100733.GQ20881@suse.de>
References: <20061108210057.7c40adaa@nim.leo>
	<1163405694.26272.36.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1163405694.26272.36.camel@localhost>
Subject: Re: [Bluez-users] "Connect" button on Logitech bluetooth receiver
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

Hi Marcel,

On Mon, Nov 13, 2006 at 09:14:54AM +0100, Marcel Holtmann wrote:
> Hi Paul,
 =

> > I ask because sometimes lately I've noticed the keyboard and/or mouse
> > will become disconnected, requiring the above command to be run
> > simultaneously to pressing the "connect" button on the keyboard/mouse.
> > When the mouse has done that, not too difficult. But if the keyboard
> > goes, it's obviously more difficult to recover :)
> =

> A Bluetooth mouse and keyboard re-connects to you after the initial
> connect. Make sure "hidd --server" is running to accept these connects.

Although this is generally true and works fine for me most of the time
(going away on vacation, coming back 10 days later and the keyboard/mouse
reconnects immediately), sometimes it fails. Then i have to massage the
system quite a bit (replug the BT dongle, multiple hidd --search and
pressing the connect button on the keyboard/mouse required until it
suddenly works again).

So there might still be a bug in there. Unfortunately i was unable to
reproduce it (and in the way of doing so write down what i _exactly_
had to do to get it working) and after me fixing it in "headless chicken
mode" the logs are probably too polluted to be useful.

If i encounter it the next time, i try to be more careful and capture
hcidump -V -X etc.

Oh - and it seems to happen more often on some hardware (never had it
on my epox CSR based keyboard/mouse, but the Microsoft BT Desktop shows
it more often). Generally, this seems to be happen less frequently with
a recent system than, say, a year ago.
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
