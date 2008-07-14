Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jul 2008 16:31:55 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <352954.54848.qm@web8402.mail.in.yahoo.com>
Subject: Re: [Bluez-users] bluetooth compilation version3.36 -regarding
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0303530787=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0303530787==
Content-Type: multipart/alternative; boundary="0-2144259811-1216033315=:54848"

--0-2144259811-1216033315=:54848
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Umesh=0Alook all the checking for ....=0Athey should be all YES.=0Ahere =
gmodule , glib, dbus are not found ..=0A=0Acompile them and  export their p=
aths to environment.=0A =0A=0AThanks and Best regards=0A=0A=0APramod=0A=0A=
=0A=0A----- Original Message ----=0AFrom: umeshyv <umeshyv@gmail.com>=0ATo:=
 BlueZ users <bluez-users@lists.sourceforge.net>=0ASent: Monday, 14 July, 2=
008 4:12:51 PM=0ASubject: [Bluez-users] bluetooth compilation version3.36 -=
regarding=0A=0AHi to all,=0AI started compiling bluetooth libs and utils ve=
rsion 3.36 ,I followed the earlier methods but following are the errors,ple=
ase rectify me where I am going wrong and for version 3.32 I submitted the =
compilation errors and I am stuck up with it.=0A=0ACompiling Bluetooth libr=
aries=0A=0A>Apply Buildroot or Toolchain Path=0A>./configure --host=3Dmipse=
l-linux --prefix=3D/usr --enable-shared=3Dno --enable-static=3Dyes=0A>make=
=0A>make install DESTDIR=3D/home/newbuild/blue/bluez-libs-3.36/install=0A=
=0ACompiling Bluetooth Utils=0A=0Alinux:/home/newbuild/blue/bluez-utils-3.3=
6 # export BLUEZ_CFLAGS=3D-I /home/newbuild/blue/bluez-libs-3.32/install/us=
r/include=0Alinux:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_LIBS=
=3D"-L/home/newbuild/blue/bluez-libs-3.32/install/usr/lib -lbluetooth"=0Ali=
nux:/home/newbuild/blue/bluez-utils-3.36 # ./configure --host=3Dmipsel-linu=
x --with-bluez=3D/home/newbuild/blue/bluez-libs-3.36/install/usr/ CPPFLAGS=
=3D"-D__KERNEL__"=0AAfter configuration =0Aconfigure: WARNING: If you wante=
d to set the --build type, don't use --host.=0A    If a cross compiler is d=
etected then cross compile mode will be used.=0Achecking for a BSD-compatib=
le install... /usr/bin/install -c=0Achecking whether build environment is s=
ane... yes=0Achecking for a thread-safe mkdir -p... /bin/mkdir -p=0Acheckin=
g for gawk... gawk=0Achecking whether make sets $(MAKE)... yes=0Achecking f=
or mipsel-linux-strip... mipsel-linux-strip=0Achecking whether to enable ma=
intainer-specific portions of Makefiles... no=0Achecking for mipsel-linux-g=
cc... mipsel-linux-gcc=0Achecking for C compiler default output file name..=
. a.out=0Achecking whether the C compiler works... yes=0Achecking whether w=
e are cross compiling... yes=0Achecking for suffix of executables...=0Achec=
king for suffix of object files... o=0Achecking whether we are using the GN=
U C compiler... yes=0Achecking whether mipsel-linux-gcc accepts -g... yes=
=0Achecking for mipsel-linux-gcc option to accept ISO C89... none needed=0A=
checking for style of include used by make... GNU=0Achecking dependency sty=
le of mipsel-linux-gcc... gcc3=0Achecking whether mipsel-linux-gcc accepts =
-fPIE... yes=0Achecking for a BSD-compatible install... /usr/bin/install -c=
=0Achecking for bison... bison -y=0Achecking for flex... flex=0Achecking le=
x output file root... lex.yy=0Achecking lex library... none needed=0Achecki=
ng whether yytext is a pointer... no=0Achecking build system type... i686-p=
c-linux-gnu=0Achecking host system type... mipsel-unknown-linux-gnu=0Acheck=
ing for a sed that does not truncate output... /usr/bin/sed=0Achecking for =
grep that handles long lines and -e... /usr/bin/grep=0Achecking for egrep..=
. /usr/bin/grep -E=0Achecking for ld used by mipsel-linux-gcc... /home/newb=
uild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld=0Achecki=
ng if the linker (/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-=
linux-uclibc/bin/ld) is GNU ld... yes=0Achecking for /home/newbuild/buildro=
ot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld option to reload obj=
ect files... -r=0Achecking for BSD-compatible nm... /home/newbuild/buildroo=
t/build_mipsel/staging_dir/bin/mipsel-linux-nm -B=0Achecking whether ln -s =
works... yes=0Achecking how to recognize dependent libraries... pass_all=0A=
checking how to run the C preprocessor... mipsel-linux-gcc -E=0Achecking fo=
r ANSI C header files... yes=0Achecking for sys/types.h... yes=0Achecking f=
or sys/stat.h... yes=0Achecking for stdlib.h... yes=0Achecking for string.h=
... yes=0Achecking for memory.h... yes=0Achecking for strings.h... yes=0Ach=
ecking for inttypes.h... yes=0Achecking for stdint.h... yes=0Achecking for =
unistd.h... yes=0Achecking dlfcn.h usability... yes=0Achecking dlfcn.h pres=
ence... yes=0Achecking for dlfcn.h... yes=0Achecking the maximum length of =
command line arguments... 98304=0Achecking command to parse /home/newbuild/=
buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B output from mipse=
l-linux-gcc object... ok=0Achecking for objdir... .libs=0Achecking for mips=
el-linux-ar... mipsel-linux-ar=0Achecking for mipsel-linux-ranlib... mipsel=
-linux-ranlib=0Achecking for mipsel-linux-strip... (cached) mipsel-linux-st=
rip=0Achecking if mipsel-linux-gcc supports -fno-rtti -fno-exceptions... no=
=0Achecking for mipsel-linux-gcc option to produce PIC... -fPIC=0Achecking =
if mipsel-linux-gcc PIC flag -fPIC works... yes=0Achecking if mipsel-linux-=
gcc static flag -static works... yes=0Achecking if mipsel-linux-gcc support=
s -c -o file.o... yes=0Achecking whether the mipsel-linux-gcc linker (/home=
/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) su=
pports shared libraries... yes=0Achecking whether -lc should be explicitly =
linked in... no=0Achecking dynamic linker characteristics... GNU/Linux ld.s=
o=0Achecking how to hardcode library paths into programs... immediate=0Ache=
cking whether stripping libraries is possible... yes=0Achecking if libtool =
supports shared libraries... yes=0Achecking whether to build shared librari=
es... yes=0Achecking whether to build static libraries... no=0Aconfigure: c=
reating libtool=0Achecking for ppoll... yes=0Achecking for mipsel-linux-pkg=
-config... no=0Achecking for pkg-config... /usr/bin/pkg-config=0Aconfigure:=
 WARNING: In the future, Autoconf will not detect cross-tools=0Awhose name =
does not start with the host triplet.  If you think this=0Aconfiguration is=
 useful to you, please write to autoconf@gnu.org.=0Achecking pkg-config is =
at least version 0.9.0... yes=0Achecking for BLUEZ... yes=0Achecking for GL=
IB... no=0Achecking for GMODULE... no=0Achecking for dlopen in -ldl... yes=
=0Achecking for DBUS... no=0Aconfigure: error: D-Bus library is required=0A=
=0Alinux:/home/newbuild/blue/bluez-utils-3.32 # make=0A=0Alinux:/home/newbu=
ild/blue/bluez-utils-3.36 # make=0Amake: *** No targets specified and no ma=
kefile found.  Stop.=0A=0AWaiting for valuable suggestions=0A=0AThanks & Re=
gards=0AUmesh=0A=0A=0A=0A      Bollywood, fun, friendship, sports and more.=
 You name it, we have it on http://in.promos.yahoo.com/groups/bestofyahoo/
--0-2144259811-1216033315=:54848
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Hi Umesh<br>look all the checking for ....<br>they should b=
e all YES.<br>here gmodule , glib, dbus are not found ..<br><div>compile th=
em and&nbsp; export their paths to environment.<br>&nbsp;<br><br></div>Than=
ks and Best regards<br><br><div>Pramod<div><br></div><div style=3D"font-fam=
ily: times new roman,new york,times,serif; font-size: 12pt;"><br><div style=
=3D"font-family: times new roman,new york,times,serif; font-size: 12pt;">--=
--- Original Message ----<br>From: umeshyv &lt;umeshyv@gmail.com&gt;<br>To:=
 BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent: Monday, 14 =
July, 2008 4:12:51 PM<br>Subject: [Bluez-users] bluetooth compilation versi=
on3.36 -regarding<br><br>Hi to all,<br>I started compiling bluetooth libs a=
nd utils version 3.36 ,I followed the earlier methods but following are the
 errors,please rectify me where I am going wrong and for version 3.32 I sub=
mitted the compilation errors and I am stuck up with it.<br>=0A<br>Compilin=
g Bluetooth libraries<br><br>&gt;Apply Buildroot or Toolchain Path<br>&gt;.=
/configure --host=3Dmipsel-linux --prefix=3D/usr --enable-shared=3Dno --ena=
ble-static=3Dyes<br>&gt;make<br>&gt;make install DESTDIR=3D/home/newbuild/b=
lue/bluez-libs-3.36/install<br>=0A<br>Compiling Bluetooth Utils<br><br>linu=
x:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_CFLAGS=3D-I /home/new=
build/blue/bluez-libs-3.32/install/usr/include<br>linux:/home/newbuild/blue=
/bluez-utils-3.36 # export BLUEZ_LIBS=3D"-L/home/newbuild/blue/bluez-libs-3=
.32/install/usr/lib -lbluetooth"<br>=0Alinux:/home/newbuild/blue/bluez-util=
s-3.36 # ./configure --host=3Dmipsel-linux --with-bluez=3D/home/newbuild/bl=
ue/bluez-libs-3.36/install/usr/ CPPFLAGS=3D"-D__KERNEL__"<br>After configur=
ation <br>configure: WARNING: If you wanted to set the --build type, don't =
use --host.<br>=0A&nbsp;&nbsp;&nbsp; If a cross compiler is detected then c=
ross compile mode will be used.<br>checking for a BSD-compatible install...=
 /usr/bin/install -c<br>checking whether build environment is sane... yes<b=
r>checking for a thread-safe mkdir -p... /bin/mkdir -p<br>=0Achecking for g=
awk... gawk<br>checking whether make sets $(MAKE)... yes<br>checking for mi=
psel-linux-strip... mipsel-linux-strip<br>checking whether to enable mainta=
iner-specific portions of Makefiles... no<br>checking for mipsel-linux-gcc.=
.. mipsel-linux-gcc<br>=0Achecking for C compiler default output file name.=
.. a.out<br>checking whether the C compiler works... yes<br>checking whethe=
r we are cross compiling... yes<br>checking for suffix of executables...<br=
>checking for suffix of object files... o<br>=0Achecking whether we are usi=
ng the GNU C compiler... yes<br>checking whether mipsel-linux-gcc accepts -=
g... yes<br>checking for mipsel-linux-gcc option to accept ISO C89... none =
needed<br>checking for style of include used by make... GNU<br>=0Achecking =
dependency style of mipsel-linux-gcc... gcc3<br>checking whether mipsel-lin=
ux-gcc accepts -fPIE... yes<br>checking for a BSD-compatible install... /us=
r/bin/install -c<br>checking for bison... bison -y<br>checking for flex... =
flex<br>=0Achecking lex output file root... lex.yy<br>checking lex library.=
.. none needed<br>checking whether yytext is a pointer... no<br>checking bu=
ild system type... i686-pc-linux-gnu<br>checking host system type... mipsel=
-unknown-linux-gnu<br>=0Achecking for a sed that does not truncate output..=
. /usr/bin/sed<br>checking for grep that handles long lines and -e... /usr/=
bin/grep<br>checking for egrep... /usr/bin/grep -E<br>checking for ld used =
by mipsel-linux-gcc... /home/newbuild/buildroot/build_mipsel/staging_dir/mi=
psel-linux-uclibc/bin/ld<br>=0Achecking if the linker (/home/newbuild/build=
root/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) is GNU ld... yes<=
br>checking for /home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-li=
nux-uclibc/bin/ld option to reload object files... -r<br>=0Achecking for BS=
D-compatible nm... /home/newbuild/buildroot/build_mipsel/staging_dir/bin/mi=
psel-linux-nm -B<br>checking whether ln -s works... yes<br>checking how to =
recognize dependent libraries... pass_all<br>checking how to run the C prep=
rocessor... mipsel-linux-gcc -E<br>=0Achecking for ANSI C header files... y=
es<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>=
checking for stdlib.h... yes<br>checking for string.h... yes<br>checking fo=
r memory.h... yes<br>checking for strings.h... yes<br>=0Achecking for intty=
pes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h... ye=
s<br>checking dlfcn.h usability... yes<br>checking dlfcn.h presence... yes<=
br>checking for dlfcn.h... yes<br>checking the maximum length of command li=
ne arguments... 98304<br>=0Achecking command to parse /home/newbuild/buildr=
oot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B output from mipsel-linu=
x-gcc object... ok<br>checking for objdir... .libs<br>checking for mipsel-l=
inux-ar... mipsel-linux-ar<br>=0Achecking for mipsel-linux-ranlib... mipsel=
-linux-ranlib<br>checking for mipsel-linux-strip... (cached) mipsel-linux-s=
trip<br>checking if mipsel-linux-gcc supports -fno-rtti -fno-exceptions... =
no<br>checking for mipsel-linux-gcc option to produce PIC... -fPIC<br>=0Ach=
ecking if mipsel-linux-gcc PIC flag -fPIC works... yes<br>checking if mipse=
l-linux-gcc static flag -static works... yes<br>checking if mipsel-linux-gc=
c supports -c -o file.o... yes<br>checking whether the mipsel-linux-gcc lin=
ker (/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/=
bin/ld) supports shared libraries... yes<br>=0Achecking whether -lc should =
be explicitly linked in... no<br>checking dynamic linker characteristics...=
 GNU/Linux ld.so<br>checking how to hardcode library paths into programs...=
 immediate<br>checking whether stripping libraries is possible... yes<br>=
=0Achecking if libtool supports shared libraries... yes<br>checking whether=
 to build shared libraries... yes<br>checking whether to build static libra=
ries... no<br>configure: creating libtool<br>checking for ppoll... yes<br>=
=0Achecking for mipsel-linux-pkg-config... no<br>checking for pkg-config...=
 /usr/bin/pkg-config<br>configure: WARNING: In the future, Autoconf will no=
t detect cross-tools<br>whose name does not start with the host triplet.&nb=
sp; If you think this<br>=0Aconfiguration is useful to you, please write to=
 <a rel=3D"nofollow" ymailto=3D"mailto:autoconf@gnu.org" target=3D"_blank" =
href=3D"mailto:autoconf@gnu.org">autoconf@gnu.org</a>.<br>checking pkg-conf=
ig is at least version <a rel=3D"nofollow" target=3D"_blank"  href=3D"http:=
//0.9.0.">0.9.0.</a>.. yes<br>checking for BLUEZ... yes<br>checking for GLI=
B... no<br>=0Achecking for GMODULE... no<br>checking for dlopen in -ldl... =
yes<br>checking for DBUS... no<br>configure: error: D-Bus library is requir=
ed<br><br>linux:/home/newbuild/blue/bluez-utils-3.32 # make<br><br>linux:/h=
ome/newbuild/blue/bluez-utils-3.36 # make<br>=0Amake: *** No targets specif=
ied and no makefile found.&nbsp; Stop.<br><br>Waiting for valuable suggesti=
ons<br><br>Thanks &amp; Regards<br>Umesh<br>=0A</div></div></div></div><br>=
=0A=0A=0A      <!--7--><hr size=3D1></hr> Meet people who discuss and share=
 your passions. <a href=3D"http://in.rd.yahoo.com/tagline_groups_7/*http://=
in.promos.yahoo.com/groups/bestofyahoo/"> Join them now.</a></body></html>
--0-2144259811-1216033315=:54848--


--===============0303530787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0303530787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0303530787==--
