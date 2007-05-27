Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Gilboa Davara <gilboad@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4659B8EC.3050708@gentoo.org>
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<4659B8EC.3050708@gentoo.org>
Date: Sun, 27 May 2007 20:31:57 +0300
Message-Id: <1180287117.30116.17.camel@gilboa-work-dev.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: gilboad@gmail.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, 2007-05-27 at 19:59 +0300, Petteri R=E4ty wrote:
> Gilboa Davara kirjoitti:
> > Hello all,
> > =

> > I'm currently trying to get kdebluetooth reviewed into Fedora Core (and
> > RHEL).
> > As some of you may be aware, the current version of kdebluetooth has no
> > support for recent (>=3D 3.9) bluez DBUS interface.
> =

> Works just fine here.
> http://dev.gentoo.org/~betelgeuse/kdebluetoothpin.png
> =

> betelgeuse@pena /mnt/checkouts/foobar/openjdk-trunk $ emerge --nodeps
> -pv bluez-utils kdebluetooth
> =

> These are the packages that would be merged, in order:
> =

> [ebuild   R   ] net-wireless/bluez-utils-3.11  USE=3D"cups hal usb -debug
> -examples -old-daemons* -test-programs" 0 kB
> [ebuild   R   ] net-wireless/kdebluetooth-1.0_beta2-r2  USE=3D"xinerama
> -arts -debug -irmc" LINGUAS=3D"fi -bg -br -ca -cs -cy -da -de -el -en_GB
> -es -et -fr -ga -gl -hu -is -it -ja -ka -lt -mt -nb -nl -nn -pa -pl -pt
> -pt_BR -ro -ru -rw -sk -sr -sr@Latn -sv -ta -tr -uk -zh_CN" 0 kB
> =

> Regards,
> Petteri
> --
> Gentoo Bluez maintainer

AFAIK there are 3 possibles solutions to this problem.
A. Patch bluez-utils' passkey-agent (adding old-style passkey support)
B. Use the un-official (?) SUSE patch that adds DBUS support to
kdebluetooth.
C. Keep kdebluetooth and bluez-utils as they are and create an out-side
wrapper.

Do you have any idea which course Gentoo used?

- Gilboa


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
