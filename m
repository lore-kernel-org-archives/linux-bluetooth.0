Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9050516b0705271141v10dc2b25i83b43275acea480@mail.gmail.com>
Date: Sun, 27 May 2007 21:41:40 +0300
From: "Gilboa Davara" <gilboad@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4659C461.8070405@gentoo.org>
MIME-Version: 1.0
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<4659B8EC.3050708@gentoo.org>
	<1180287117.30116.17.camel@gilboa-work-dev.localdomain>
	<4659C461.8070405@gentoo.org>
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

On 5/27/07, Petteri R=E4ty <betelgeuse@gentoo.org> wrote:
> Gilboa Davara kirjoitti:
> > AFAIK there are 3 possibles solutions to this problem.
> > A. Patch bluez-utils' passkey-agent (adding old-style passkey support)
> > B. Use the un-official (?) SUSE patch that adds DBUS support to
> > kdebluetooth.
> > C. Keep kdebluetooth and bluez-utils as they are and create an out-side
> > wrapper.
> >
> > Do you have any idea which course Gentoo used?
> >
> > - Gilboa
> >
>
> http://viewcvs.gentoo.org/viewcvs.py/gentoo-x86/net-wireless/kdebluetooth=
/kdebluetooth-1.0_beta2-r2.ebuild?rev=3D1.1&view=3Dlog
>

A short comment about the OpenSUSE patch.
Unless Gentoo's kdebluetooth maintainer is QT/KDE/CPP programmer, he's
taking an unreasonable risk.
If I'm using a wrapper and something breaks, it's either in the
wrapper code (and I'm the one to blame) or in kdebluetooth (which can
be reported upstream to kmobiletools).
... But if an unsupported patch is used, you're S.O.L.
You can't report the bug upstream (not their code) and you can't
report the bug to SUSE people. (Not their distro)
In short, you get to keep all the broken pieces....

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
