Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Fri, 16 Jul 2010 15:08:18 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluez installs alsa related stuff under /etc/alsa instead of
 /usr/share/alsa
Message-ID: <20100716180817.GA10326@vigoh>
References: <20100716170135.GA22166@jh-x301>
 <1279300905.29479.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1279300905.29479.2.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

* Pacho Ramos <pacho@condmat1.ciencias.uniovi.es> [2010-07-16 19:21:45 +020=
0]:

> El vie, 16-07-2010 a las 14:01 -0300, Johan Hedberg escribi=F3:
> >=20
> > On Fri, Jul 16, 2010, Pacho Ramos wrote:
> > > Can this be finally committed please? Thanks a lot :-)
> >=20
> > It's strange the the patch has gone unnoticed ever since March. Anyway,
> > could you please provide a git format-patch version of it since that's
> > the convention for all patch submisions. That way I don't need to play
> > manual tricks to get the git author name and email correct for the
> > commit.
> >=20
> > Johan
> >=20
>=20
> Sadly I have always failed to create patches in a git format-patch
> version :'(
>=20
> This is what I have tried:
> $ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
> Initialized empty Git repository in /home/pacho/bluez/.git/
> remote: Counting objects: 35451, done.
> remote: Compressing objects: 100% (8577/8577), done.
> remote: Total 35451 (delta 27190), reused 34976 (delta 26858)
> Receiving objects: 100% (35451/35451), 6.16 MiB | 1.39 MiB/s, done.
> Resolving deltas: 100% (27190/27190), done.
> $ cd bluez/
> $ git checkout -b fix_alsa_path
> Switched to a new branch 'fix_alsa_path'
> $ patch -p0
> </usr/portage/net-wireless/bluez/files/bluez-alsa_location.patch=20
> patching file Makefile.am
> Hunk #1 succeeded at 248 (offset 7 lines).
> $ git format-patch master --stdout
> $ (nothing is shown)

If your patch is on HEAD then just do:

git format-patch -1

and then use 'git send-email' to send it to the mailing list.

--=20
Gustavo F. Padovan
http://padovan.org
