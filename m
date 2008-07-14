Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jul 2008 16:20:56 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <20306.69710.qm@web8401.mail.in.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1975598879=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1975598879==
Content-Type: multipart/alternative; boundary="0-1525143822-1216032656=:69710"

--0-1525143822-1216032656=:69710
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Umesh =0Aconfigure has failed.=0ACross compile dbus first and its depend=
ancies(libxml only)=0Aprovide path to it also. bluez depends in dbus thorou=
ghly. and dbus on libxml.=0A=0Aplease compile them and again try bluez.=0A=
=0A Thanks and Best regards=0A=0A=0APramod=0A=0A=0A=0A----- Original Messag=
e ----=0AFrom: umeshyv <umeshyv@gmail.com>=0ATo: BlueZ users <bluez-users@l=
ists.sourceforge.net>=0ASent: Monday, 14 July, 2008 4:12:51 PM=0ASubject: [=
Bluez-users] bluetooth compilation version3.36 -regarding=0A=0AHi to all,=
=0AI started compiling bluetooth libs and utils version 3.36 ,I followed th=
e earlier methods but following are the errors,please rectify me where I am=
 going wrong and for version 3.32 I submitted the compilation errors and I =
am stuck up with it.=0A=0ACompiling Bluetooth libraries=0A=0A>Apply Buildro=
ot or Toolchain Path=0A>./configure --host=3Dmipsel-linux --prefix=3D/usr -=
-enable-shared=3Dno --enable-static=3Dyes=0A>make=0A>make install DESTDIR=
=3D/home/newbuild/blue/bluez-libs-3.36/install=0A=0ACompiling Bluetooth Uti=
ls=0A=0Alinux:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_CFLAGS=3D=
-I /home/newbuild/blue/bluez-libs-3.32/install/usr/include=0Alinux:/home/ne=
wbuild/blue/bluez-utils-3.36 # export BLUEZ_LIBS=3D"-L/home/newbuild/blue/b=
luez-libs-3.32/install/usr/lib -lbluetooth"=0Alinux:/home/newbuild/blue/blu=
ez-utils-3.36 # ./configure --host=3Dmipsel-linux --with-bluez=3D/home/newb=
uild/blue/bluez-libs-3.36/install/usr/ CPPFLAGS=3D"-D__KERNEL__"=0AAfter co=
nfiguration =0Aconfigure: WARNING: If you wanted to set the --build type, d=
on't use --host.=0A    If a cross compiler is detected then cross compile m=
ode will be used.=0Achecking for a BSD-compatible install... /usr/bin/insta=
ll -c=0Achecking whether build environment is sane... yes=0Achecking for a =
thread-safe mkdir -p... /bin/mkdir -p=0Achecking for gawk... gawk=0Acheckin=
g whether make sets $(MAKE)... yes=0Achecking for mipsel-linux-strip... mip=
sel-linux-strip=0Achecking whether to enable maintainer-specific portions o=
f Makefiles... no=0Achecking for mipsel-linux-gcc... mipsel-linux-gcc=0Ache=
cking for C compiler default output file name... a.out=0Achecking whether t=
he C compiler works... yes=0Achecking whether we are cross compiling... yes=
=0Achecking for suffix of executables...=0Achecking for suffix of object fi=
les... o=0Achecking whether we are using the GNU C compiler... yes=0Achecki=
ng whether mipsel-linux-gcc accepts -g... yes=0Achecking for mipsel-linux-g=
cc option to accept ISO C89... none needed=0Achecking for style of include =
used by make... GNU=0Achecking dependency style of mipsel-linux-gcc... gcc3=
=0Achecking whether mipsel-linux-gcc accepts -fPIE... yes=0Achecking for a =
BSD-compatible install... /usr/bin/install -c=0Achecking for bison... bison=
 -y=0Achecking for flex... flex=0Achecking lex output file root... lex.yy=
=0Achecking lex library... none needed=0Achecking whether yytext is a point=
er... no=0Achecking build system type... i686-pc-linux-gnu=0Achecking host =
system type... mipsel-unknown-linux-gnu=0Achecking for a sed that does not =
truncate output... /usr/bin/sed=0Achecking for grep that handles long lines=
 and -e... /usr/bin/grep=0Achecking for egrep... /usr/bin/grep -E=0Acheckin=
g for ld used by mipsel-linux-gcc... /home/newbuild/buildroot/build_mipsel/=
staging_dir/mipsel-linux-uclibc/bin/ld=0Achecking if the linker (/home/newb=
uild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) is GNU =
ld... yes=0Achecking for /home/newbuild/buildroot/build_mipsel/staging_dir/=
mipsel-linux-uclibc/bin/ld option to reload object files... -r=0Achecking f=
or BSD-compatible nm... /home/newbuild/buildroot/build_mipsel/staging_dir/b=
in/mipsel-linux-nm -B=0Achecking whether ln -s works... yes=0Achecking how =
to recognize dependent libraries... pass_all=0Achecking how to run the C pr=
eprocessor... mipsel-linux-gcc -E=0Achecking for ANSI C header files... yes=
=0Achecking for sys/types.h... yes=0Achecking for sys/stat.h... yes=0Acheck=
ing for stdlib.h... yes=0Achecking for string.h... yes=0Achecking for memor=
y.h... yes=0Achecking for strings.h... yes=0Achecking for inttypes.h... yes=
=0Achecking for stdint.h... yes=0Achecking for unistd.h... yes=0Achecking d=
lfcn.h usability... yes=0Achecking dlfcn.h presence... yes=0Achecking for d=
lfcn.h... yes=0Achecking the maximum length of command line arguments... 98=
304=0Achecking command to parse /home/newbuild/buildroot/build_mipsel/stagi=
ng_dir/bin/mipsel-linux-nm -B output from mipsel-linux-gcc object... ok=0Ac=
hecking for objdir... .libs=0Achecking for mipsel-linux-ar... mipsel-linux-=
ar=0Achecking for mipsel-linux-ranlib... mipsel-linux-ranlib=0Achecking for=
 mipsel-linux-strip... (cached) mipsel-linux-strip=0Achecking if mipsel-lin=
ux-gcc supports -fno-rtti -fno-exceptions... no=0Achecking for mipsel-linux=
-gcc option to produce PIC... -fPIC=0Achecking if mipsel-linux-gcc PIC flag=
 -fPIC works... yes=0Achecking if mipsel-linux-gcc static flag -static work=
s... yes=0Achecking if mipsel-linux-gcc supports -c -o file.o... yes=0Achec=
king whether the mipsel-linux-gcc linker (/home/newbuild/buildroot/build_mi=
psel/staging_dir/mipsel-linux-uclibc/bin/ld) supports shared libraries... y=
es=0Achecking whether -lc should be explicitly linked in... no=0Achecking d=
ynamic linker characteristics... GNU/Linux ld.so=0Achecking how to hardcode=
 library paths into programs... immediate=0Achecking whether stripping libr=
aries is possible... yes=0Achecking if libtool supports shared libraries...=
 yes=0Achecking whether to build shared libraries... yes=0Achecking whether=
 to build static libraries... no=0Aconfigure: creating libtool=0Achecking f=
or ppoll... yes=0Achecking for mipsel-linux-pkg-config... no=0Achecking for=
 pkg-config... /usr/bin/pkg-config=0Aconfigure: WARNING: In the future, Aut=
oconf will not detect cross-tools=0Awhose name does not start with the host=
 triplet.  If you think this=0Aconfiguration is useful to you, please write=
 to autoconf@gnu.org.=0Achecking pkg-config is at least version 0.9.0... ye=
s=0Achecking for BLUEZ... yes=0Achecking for GLIB... no=0Achecking for GMOD=
ULE... no=0Achecking for dlopen in -ldl... yes=0Achecking for DBUS... no=0A=
configure: error: D-Bus library is required=0A=0Alinux:/home/newbuild/blue/=
bluez-utils-3.32 # make=0A=0Alinux:/home/newbuild/blue/bluez-utils-3.36 # m=
ake=0Amake: *** No targets specified and no makefile found.  Stop.=0A=0AWai=
ting for valuable suggestions=0A=0AThanks & Regards=0AUmesh=0A=0A=0A=0A    =
  From Chandigarh to Chennai - find friends all over India. Go to http://in=
.promos.yahoo.com/groups/citygroups/
--0-1525143822-1216032656=:69710
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">Hi Umesh <br>configure has failed.<br>Cross compile dbus fi=
rst and its dependancies(libxml only)<br>provide path to it also. bluez dep=
ends in dbus thoroughly. and dbus on libxml.<br><br>please compile them and=
 again try bluez.<br><div>&nbsp;</div>Thanks and Best regards<br><br><div>P=
ramod<div><br></div><div style=3D"font-family: times new roman,new york,tim=
es,serif; font-size: 12pt;"><br><div style=3D"font-family: times new roman,=
new york,times,serif; font-size: 12pt;">----- Original Message ----<br>From=
: umeshyv &lt;umeshyv@gmail.com&gt;<br>To: BlueZ users &lt;bluez-users@list=
s.sourceforge.net&gt;<br>Sent: Monday, 14 July, 2008 4:12:51 PM<br>Subject:=
 [Bluez-users] bluetooth compilation version3.36 -regarding<br><br>Hi to al=
l,<br>I started compiling bluetooth libs and utils version 3.36 ,I followed
 the earlier methods but following are the errors,please rectify me where I=
 am going wrong and for version 3.32 I submitted the compilation errors and=
 I am stuck up with it.<br>=0A<br>Compiling Bluetooth libraries<br><br>&gt;=
Apply Buildroot or Toolchain Path<br>&gt;./configure --host=3Dmipsel-linux =
--prefix=3D/usr --enable-shared=3Dno --enable-static=3Dyes<br>&gt;make<br>&=
gt;make install DESTDIR=3D/home/newbuild/blue/bluez-libs-3.36/install<br>=
=0A<br>Compiling Bluetooth Utils<br><br>linux:/home/newbuild/blue/bluez-uti=
ls-3.36 # export BLUEZ_CFLAGS=3D-I /home/newbuild/blue/bluez-libs-3.32/inst=
all/usr/include<br>linux:/home/newbuild/blue/bluez-utils-3.36 # export BLUE=
Z_LIBS=3D"-L/home/newbuild/blue/bluez-libs-3.32/install/usr/lib -lbluetooth=
"<br>=0Alinux:/home/newbuild/blue/bluez-utils-3.36 # ./configure --host=3Dm=
ipsel-linux --with-bluez=3D/home/newbuild/blue/bluez-libs-3.36/install/usr/=
 CPPFLAGS=3D"-D__KERNEL__"<br>After configuration <br>configure: WARNING: I=
f you wanted to set the --build type, don't use --host.<br>=0A&nbsp;&nbsp;&=
nbsp; If a cross compiler is detected then cross compile mode will be used.=
<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checkin=
g whether build environment is sane... yes<br>checking for a thread-safe mk=
dir -p... /bin/mkdir -p<br>=0Achecking for gawk... gawk<br>checking whether=
 make sets $(MAKE)... yes<br>checking for mipsel-linux-strip... mipsel-linu=
x-strip<br>checking whether to enable maintainer-specific portions of Makef=
iles... no<br>checking for mipsel-linux-gcc... mipsel-linux-gcc<br>=0Acheck=
ing for C compiler default output file name... a.out<br>checking whether th=
e C compiler works... yes<br>checking whether we are cross compiling... yes=
<br>checking for suffix of executables...<br>checking for suffix of object =
files... o<br>=0Achecking whether we are using the GNU C compiler... yes<br=
>checking whether mipsel-linux-gcc accepts -g... yes<br>checking for mipsel=
-linux-gcc option to accept ISO C89... none needed<br>checking for style of=
 include used by make... GNU<br>=0Achecking dependency style of mipsel-linu=
x-gcc... gcc3<br>checking whether mipsel-linux-gcc accepts -fPIE... yes<br>=
checking for a BSD-compatible install... /usr/bin/install -c<br>checking fo=
r bison... bison -y<br>checking for flex... flex<br>=0Achecking lex output =
file root... lex.yy<br>checking lex library... none needed<br>checking whet=
her yytext is a pointer... no<br>checking build system type... i686-pc-linu=
x-gnu<br>checking host system type... mipsel-unknown-linux-gnu<br>=0Achecki=
ng for a sed that does not truncate output... /usr/bin/sed<br>checking for =
grep that handles long lines and -e... /usr/bin/grep<br>checking for egrep.=
.. /usr/bin/grep -E<br>checking for ld used by mipsel-linux-gcc... /home/ne=
wbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld<br>=0A=
checking if the linker (/home/newbuild/buildroot/build_mipsel/staging_dir/m=
ipsel-linux-uclibc/bin/ld) is GNU ld... yes<br>checking for /home/newbuild/=
buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld option to rel=
oad object files... -r<br>=0Achecking for BSD-compatible nm... /home/newbui=
ld/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B<br>checking wh=
ether ln -s works... yes<br>checking how to recognize dependent libraries..=
. pass_all<br>checking how to run the C preprocessor... mipsel-linux-gcc -E=
<br>=0Achecking for ANSI C header files... yes<br>checking for sys/types.h.=
.. yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br=
>checking for string.h... yes<br>checking for memory.h... yes<br>checking f=
or strings.h... yes<br>=0Achecking for inttypes.h... yes<br>checking for st=
dint.h... yes<br>checking for unistd.h... yes<br>checking dlfcn.h usability=
... yes<br>checking dlfcn.h presence... yes<br>checking for dlfcn.h... yes<=
br>checking the maximum length of command line arguments... 98304<br>=0Ache=
cking command to parse /home/newbuild/buildroot/build_mipsel/staging_dir/bi=
n/mipsel-linux-nm -B output from mipsel-linux-gcc object... ok<br>checking =
for objdir... .libs<br>checking for mipsel-linux-ar... mipsel-linux-ar<br>=
=0Achecking for mipsel-linux-ranlib... mipsel-linux-ranlib<br>checking for =
mipsel-linux-strip... (cached) mipsel-linux-strip<br>checking if mipsel-lin=
ux-gcc supports -fno-rtti -fno-exceptions... no<br>checking for mipsel-linu=
x-gcc option to produce PIC... -fPIC<br>=0Achecking if mipsel-linux-gcc PIC=
 flag -fPIC works... yes<br>checking if mipsel-linux-gcc static flag -stati=
c works... yes<br>checking if mipsel-linux-gcc supports -c -o file.o... yes=
<br>checking whether the mipsel-linux-gcc linker (/home/newbuild/buildroot/=
build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) supports shared librar=
ies... yes<br>=0Achecking whether -lc should be explicitly linked in... no<=
br>checking dynamic linker characteristics... GNU/Linux ld.so<br>checking h=
ow to hardcode library paths into programs... immediate<br>checking whether=
 stripping libraries is possible... yes<br>=0Achecking if libtool supports =
shared libraries... yes<br>checking whether to build shared libraries... ye=
s<br>checking whether to build static libraries... no<br>configure: creatin=
g libtool<br>checking for ppoll... yes<br>=0Achecking for mipsel-linux-pkg-=
config... no<br>checking for pkg-config... /usr/bin/pkg-config<br>configure=
: WARNING: In the future, Autoconf will not detect cross-tools<br>whose nam=
e does not start with the host triplet.&nbsp; If you think this<br>=0Aconfi=
guration is useful to you, please write to <a rel=3D"nofollow" ymailto=3D"m=
ailto:autoconf@gnu.org" target=3D"_blank" href=3D"mailto:autoconf@gnu.org">=
autoconf@gnu.org</a>.<br>checking pkg-config is at least version <a rel=3D"=
nofollow" target=3D"_blank"  href=3D"http://0.9.0.">0.9.0.</a>.. yes<br>che=
cking for BLUEZ... yes<br>checking for GLIB... no<br>=0Achecking for GMODUL=
E... no<br>checking for dlopen in -ldl... yes<br>checking for DBUS... no<br=
>configure: error: D-Bus library is required<br><br>linux:/home/newbuild/bl=
ue/bluez-utils-3.32 # make<br><br>linux:/home/newbuild/blue/bluez-utils-3.3=
6 # make<br>=0Amake: *** No targets specified and no makefile found.&nbsp; =
Stop.<br><br>Waiting for valuable suggestions<br><br>Thanks &amp; Regards<b=
r>Umesh<br>=0A</div></div></div></div><br>=0A=0A=0A      <!--6--><hr size=
=3D1></hr> Explore your hobbies and interests. <a href=3D"http://in.rd.yaho=
o.com/tagline_groups_6/*http://in.promos.yahoo.com/groups/">Click here to b=
egin.</a></body></html>
--0-1525143822-1216032656=:69710--


--===============1975598879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1975598879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1975598879==--
