Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: "Christopher E. Granade" <cgranade@greens.org>
Message-ID: <dr73je$gt8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Problems compiling btso.
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
Date: Tue, 24 Jan 2006 20:50:36 -0900

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

When I download and attempt to install the CVS version of btsco (as
recommended on the bluetooth-alsa project site, I got the following
errors from ./bootstrap:

/usr/share/aclocal/libxosd.m4:9: warning: underquoted definition of
AM_PATH_LIBXOSD
  run info '(automake)Extending aclocal'
  or see http://sources.redhat.com/automake/automake.html#Extending-aclocal
configure.in: installing `./install-sh'
configure.in: installing `./missing'
alsa-plugins/Makefile.am:5: Libtool library used but `LIBTOOL' is undefined
alsa-plugins/Makefile.am:5:
alsa-plugins/Makefile.am:5: The usual way to define `LIBTOOL' is to add
`AC_PROG_LIBTOOL'
alsa-plugins/Makefile.am:5: to `configure.in' and run `aclocal' and
`autoconf' again.
alsa-plugins/Makefile.am: installing `./depcomp'


Any help that you can offer would be greatly appreciated.

- --Chris

- -----------------------------
Information on system:
$ uname -r
2.6.14-1.1656_FC4

$ autoconf --version
autoconf (GNU Autoconf) 2.59

$ automake --version
automake (GNU automake) 1.9.5

$ gcc --version
gcc (GCC) 4.0.2 20051125 (Red Hat 4.0.2-8)

$ make --version
GNU Make 3.80

$ rpm -qa | grep libtool
libtool-ltdl-1.5.20-4.99_14.rhfc4.at
- -----------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1xGr0dXuuZr00J4RA793AJ9WmZefttV7tZcf9uRE83Leh1MmeACfexDd
gCF7l/I56/IQwy/dNBt2jL4=
=1COJ
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
