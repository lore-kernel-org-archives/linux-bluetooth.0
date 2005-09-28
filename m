Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <1265464416.20050928201649@andric.com>
To: Marcel Holtmann <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth filesystem integration
In-Reply-To: <1127899931.5321.16.camel@localhost.localdomain>
References: <1127865130.15926.18.camel@panic>
 <1127899309.14281.7.camel@bluez.bueche.ch>
 <1127899931.5321.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg="pgp-sha1";
  boundary="----------A31F218329C8F022"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Sep 2005 20:16:49 +0200

------------A31F218329C8F022
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 2005-09-28 at 11:32:10 Marcel Holtmann wrote:

> do you have any thoughts how the directory structure of this filesystem
> should look like. Let's discuss how we design it.

Maybe it's nice to look at how the KDE bluetooth project has
implemented this.  They already overlay some sort of 'virtual'
filesystem on top of Konqueror, which is similar to:

bluetooth root
   device1
     service1
     service2
     ...
   device2
   device3
   ...

etc.  See for instance:

http://kde-bluetooth.sourceforge.net/screenshots/index.html#kioslaves

------------A31F218329C8F022
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDOt4RsF6jCi4glqMRAhiDAJ9WtNvNmvTyl8cDj2Er3wTg9Ry7ZwCg5ZIS
f43MkgZqMLRwJqxPeRTfQEQ=
=5Qq3
-----END PGP MESSAGE-----

------------A31F218329C8F022--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
