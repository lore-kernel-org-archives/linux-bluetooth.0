Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: Pavel Machek <pavel@suse.cz>, bluez-users@lists.sf.net,
        linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2006 15:56:09 +0200
References: <200608240859.11195.cijoml@volny.cz>
	<20060824130946.GB7055@elf.ucw.cz>
In-Reply-To: <20060824130946.GB7055@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <200608241556.09836.cijoml@volny.cz>
Subject: Re: [Bluez-users] Microsoft BT mouse's optical sensor switches
	off???
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Ahoj Pavle,

zkousel jsem vsechny predchozi jadra co tu mam 2.6.16.16,2.6.17.3 a delaj t=
o =

taky. To vypada spis jako chybu v nejakem upgradovanem programu. Napadaj me =

Xka nebo BlueZ stack.

Co je zajimavy, ta prodleva je presne 60 sekund a moje druha BT mys Logitec=
h =

V270 ani moje USB mys to nedelaji.

Michal

Hi Pavel,

I was testing all previous kernel versions I have (2.6.16.16, 2.6.17.3) whi=
ch =

worked before and it is also happening in them now. So it looks like error =
in =

some external out-of-kernel stuff. Maybe X.org or BlueZ utils???

Is interresting, that delay when sensor switch off is 60 seconds (like some =

timer) and my second BT mouse Logitech V270 and also my USB mouse don't do =

that and sensor is always on. When I connect Microsoft mouse to W2000 or my =

old linux installation, sensor also don't switch off.

Any clue whom to ask now?

Thanks
Michal

Dne =E8tvrtek 24 srpen 2006 15:09 jste napsal(a):
> On Thu 2006-08-24 08:59:11, CIJOML wrote:
> > Hi,
> >
> > I upgraded my debian linux to newest testing version:
> >
> > notas:/usr/src/linux-2.6.18-rc4# dpkg -l|grep -i bluez
> > ii  bluez-hcidump                    1.31-1                      Analys=
es
> > Bluetooth HCI packets
> > ii  bluez-utils                      3.1-3.1                    =

> > Bluetooth tools and daemons
> > ii  libbluetooth1                    2.25-2                      Library
> > to use the BlueZ Linux Bluetooth stack
> > ii  libbluetooth2                    3.1-1                       Library
> > to use the BlueZ Linux Bluetooth stack
> >
> > and linux kernel to 2.6.18-rc4 to have also latest BlueZ kernel.
> >
> > Everything works fine, except mouse?!
> >
> > Mouse works, but it sensor getts off in a very short time. I have to
> > click 2times any button on it to start it again to move cursor?!
> >
> > This really p*ss me off.
> >
> > Where can I switch off this "feature"??
>
> Find where it started happening with git bisect, then file proper
> bugzilla report, I'd say...
> 							Pavel

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
