Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <8ff9e38c0605230928k7764a4afo211a6db8de91f77c@mail.gmail.com>
From: "touya kouyo" <touya.kouyo@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_27334_31185587.1148401729890"
Subject: [Bluez-users] Cross-compiling BlueZ utils for uClinux
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 May 2006 12:28:49 -0400

------=_Part_27334_31185587.1148401729890
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I was trying to cross-compile the bluez utils for uClinux using ./configure
CC=3Dnios2-linux-uclibc-gcc LDFLAGS=3D-elf2flt to set up the makefile but i=
t
requires --host to be specified.  Since I'm running this on a Nios II
soft-core processor with uClinux as the OS, I'm not sure what other options
I need to specify as parameters on the ./configure commandline to set up a
correct makefile.

Thanks,
Ricky

------=_Part_27334_31185587.1148401729890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I was trying to cross-compile the bluez utils for uClinux using =
./configure CC=3Dnios2-linux-uclibc-gcc LDFLAGS=3D-elf2flt to set up the ma=
kefile but it requires --host to be specified.&nbsp; Since I'm running this=
 on a Nios II soft-core processor with uClinux as the OS, I'm not sure what=
 other options I need to specify as parameters on the ./configure commandli=
ne to set up a correct makefile.
<br><br>Thanks,<br>Ricky<br>

------=_Part_27334_31185587.1148401729890--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
