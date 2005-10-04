Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <96c186cf0510041630i679033b1r@mail.gmail.com>
From: =?ISO-8859-1?Q?Rubi_Santiago_Ram=EDrez?= <rubisantiago@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10330_31848239.1128468630740"
Subject: [Bluez-devel] Problem install packages Bluetooth!!!
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
Date: Tue, 4 Oct 2005 18:30:30 -0500

------=_Part_10330_31848239.1128468630740
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I have problems when I tried install the packages Bluetooth. The problems
with hcidump I compiling how said the README file but I typed make install
the display show next error:

gcc -I/usr/include -Wall -O2 -o bpasniff bpasniff.o -L/usr/lib -lbluetooth
../parser/libparser.a
../parser/libparser.a(lmp.o)(.text+0x7b9): En la funci=F3n `lmp_dump':
: undefined reference to `bt_get_unaligned'
../parser/libparser.a(lmp.o)(.text+0x844): En la funci=F3n `lmp_dump':
: undefined reference to `bt_get_unaligned'
../parser/libparser.a(lmp.o)(.text+0x85b): En la funci=F3n `lmp_dump':
: undefined reference to `bt_get_unaligned'
../parser/libparser.a(lmp.o)(.text+0xb11): En la funci=F3n `lmp_dump':
: undefined reference to `bt_get_unaligned'
../parser/libparser.a(lmp.o)(.text+0xd1f): En la funci=F3n `lmp_dump':
: undefined reference to `bt_get_unaligned'
../parser/libparser.a(lmp.o)(.text+0xd40): more undefined references to
`bt_get_unaligned' follow
collect2: ld devolvi=F3 el estado de salida 1
make[1]: *** [bpasniff] Error 1
make[1]: Leaving directory `/root/BlueZ/bluez-hcidump-1.25/src'
make: *** [install-recursive] Error 1

How I compiling and run bluez-pin-0.26? Can you explain me please?
Thanks

------=_Part_10330_31848239.1128468630740
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
I have problems when I tried install the packages Bluetooth. The
problems with hcidump I compiling how said the README file but I typed
make install the display show next error:<br>
<br>
gcc -I/usr/include -Wall -O2&nbsp;&nbsp; -o bpasniff&nbsp; bpasniff.o -L/us=
r/lib -lbluetooth ../parser/libparser.a<br>
../parser/libparser.a(lmp.o)(.text+0x7b9): En la funci=F3n `lmp_dump':<br>
: undefined reference to `bt_get_unaligned'<br>
../parser/libparser.a(lmp.o)(.text+0x844): En la funci=F3n `lmp_dump':<br>
: undefined reference to `bt_get_unaligned'<br>
../parser/libparser.a(lmp.o)(.text+0x85b): En la funci=F3n `lmp_dump':<br>
: undefined reference to `bt_get_unaligned'<br>
../parser/libparser.a(lmp.o)(.text+0xb11): En la funci=F3n `lmp_dump':<br>
: undefined reference to `bt_get_unaligned'<br>
../parser/libparser.a(lmp.o)(.text+0xd1f): En la funci=F3n `lmp_dump':<br>
: undefined reference to `bt_get_unaligned'<br>
../parser/libparser.a(lmp.o)(.text+0xd40): more undefined references to `bt=
_get_unaligned' follow<br>
collect2: ld devolvi=F3 el estado de salida 1<br>
make[1]: *** [bpasniff] Error 1<br>
make[1]: Leaving directory `/root/BlueZ/bluez-hcidump-1.25/src'<br>
make: *** [install-recursive] Error 1<br>
<br>
How I compiling and run bluez-pin-0.26? Can you explain me please?<br>
Thanks<br>
<br>

------=_Part_10330_31848239.1128468630740--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
