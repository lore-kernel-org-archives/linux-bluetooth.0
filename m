Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05042813004f4609a6@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] DBUS service support - Initial library
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
Date: Thu, 28 Apr 2005 17:00:19 -0300

Hi Marcel,

I wrote the skeleton of the library. Please verify if I=20
am following the BlueZ principles.=20
At the moment, the code is not fully integrated=20
with BlueZ daemons and applications. Some functions=20
shall be changed due function outputs: the result=20
should be returned instead of displayed on the=20
screen.

It is only a initial draft. The idea is provide a=20
library to user mode application controls bluetooth=20
connections. Please validate my suggestions before=20
I start coding and verify if this library can be=20
useful for BlueZ community. I know that some features
of this library are provided by "pand", but I need
control connections from a user mode application=20
or DBUS application.

The code is available in the link below:
http://www.cin.ufpe.br/~ckt/panz_lib.tar.gz

The following changes were done:
1. Makefile.am
    added libpanz in the SUBDIR
2. configure.in
    added libpanz/Makefile in the AC_OUTPUT
3. Added libpanz directory
   the files are in libpanz.tar.gz file
4. Common hcitool functions
   hcitool functions used by the library were moved
   to hci_common.c
5. Dynamic Link Local Layer addresses
   The automatic IP assignment will be based on the=20
   following IETF draft=20
   http://files.zeroconf.org/draft-ietf-zeroconf-ipv4-linklocal.txt

There are a lot of chalenges until I reach=20
my objective: integrate with a DBUS application.


Best regards,
Claudio.


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
