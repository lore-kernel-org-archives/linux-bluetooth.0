Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41ED434B.9060207@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [btsco] automake error
References: <41ED224E.9030702@pca.it>
In-Reply-To: <41ED224E.9030702@pca.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 18 Jan 2005 10:11:39 -0700

thanks Luca. keep those patches coming :)

Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> I'm new to the list, so hello to everyone :-)
> 
> I just bought a Bluetake i-Phono and I was trying to test it (Debian
> unstable, kernel 2.6.10, ALSA 1.0.8), but I got an automake error:
> =====
> luca@gismo:~/src/kernel/bluetooth$ cvs
> - -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa login
> Logging in to :pserver:anonymous@cvs.sf.net:2401/cvsroot/bluetooth-alsa
> CVS password:
> luca@gismo:~/src/kernel/bluetooth$ cvs
> - -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
> cvs checkout: Updating btsco
> <cut>
> U btsco/sbc/sbcinfo.c
> 
> luca@gismo:~/src/kernel/bluetooth$ cd btsco/
> luca@gismo:~/src/kernel/bluetooth/btsco$ ./bootstrap
> automake: unrecognized option -- `--ignore-deps'
> Try `automake --help' for more information.
> 
> luca@gismo:~/src/kernel/bluetooth/btsco$ automake --help | grep ignore
> luca@gismo:~/src/kernel/bluetooth/btsco$ automake --version | grep automake
> automake (GNU automake) 1.4-p6
> =====
> 
> So, the attached patch check for automake-1.7 during the bootstrap
> process and add an info in the README.
> 
> But I still have some compilation problems... (new post, IMHO it's better).
> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFB7R1mVAp7Xm10JmkRAsS6AJ0cJCqjyaxxDdVW2HafWJFWwJbatQCdF002
> OXtjJYOo4mfeYcpDZyGT9Y0=
> =eIey
> -----END PGP SIGNATURE-----
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Naur btsco_cvs-20050118-1520/bootstrap btsco/bootstrap
> --- btsco_cvs-20050118-1520/bootstrap	2005-01-18 15:22:44.000000000 +0100
> +++ btsco/bootstrap	2005-01-18 15:19:38.000000000 +0100
> @@ -1,2 +1,10 @@
>  #! /bin/sh
> -aclocal && autoheader && automake --add-missing --copy --ignore-deps && autoconf
> +
> +if [ ! `which automake-1.7` ]; then
> +    echo -e "\n*** You need automake-1.7 to compile this software ***\n"
> +    exit 1
> +elif [ ! `automake --version | grep -q 1.7` ]; then
> +    AUTOMAKE_VERSION="-1.7"
> +fi
> + 
> +aclocal$AUTOMAKE_VERSION && autoheader && automake$AUTOMAKE_VERSION --add-missing --copy --ignore-deps && autoconf
> diff -Naur btsco_cvs-20050118-1520/README btsco/README
> --- btsco_cvs-20050118-1520/README	2005-01-18 15:23:32.000000000 +0100
> +++ btsco/README	2004-11-25 01:51:40.000000000 +0100
> @@ -37,7 +37,7 @@
>      1. The CVS repository must be checked out:
>          cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa login
>          cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
> -    2. After that it must be compiled, you need automake1.7 to do it:
> +    2. After that it must be compiled:
>          ./bootstrap
>          ./configure
>          make


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
