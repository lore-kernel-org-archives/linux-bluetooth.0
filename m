Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Date: Thu, 14 Sep 2006 19:03:31 +0200
References: <200608240859.11195.cijoml@volny.cz>
	<20060824130946.GB7055@elf.ucw.cz>
In-Reply-To: <20060824130946.GB7055@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <200609141903.32000.cijoml@volny.cz>
Cc: bluez-users@lists.sf.net, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
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

Hi I fixed this issue - Sensor switches off if hcid daemon doesn't run. If =

does, everythink works fine!

I find out that hcid not running, because I was missing DBUS.

Hope this will help others having this issue.

Michal

Dne =E8tvrtek 24 srpen 2006 15:09 Pavel Machek napsal(a):
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
