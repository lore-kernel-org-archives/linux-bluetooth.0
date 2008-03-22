Return-Path: <cyrus@holtmann.org>
Message-ID: <b5c34db00803220246y5941f4d7p14bfa6af06c5b9b1@mail.gmail.com>
Date: Sat, 22 Mar 2008 15:16:44 +0530
From: umeshyv <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth compilation regarded
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1316812867=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1316812867==
Content-Type: multipart/alternative;
	boundary="----=_Part_5490_13064989.1206179204073"

------=_Part_5490_13064989.1206179204073
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all
I am trying to compile bluez-libs-3.27 & bluez-utils-3.27 for mips32 and I
use buildroot's toolchain and i get following errors

Compilation Steps:

export PATH=/home/newbuild/buildroot/build_mipsel/staging_dir/bin:$PATH
<toolchain path>

Libs:
>./configure --host=mipsel-linux --prefix=/usr --enable-shared=no
--enable-static=yes
>make
>make install DESTDIR=/home/newbuild/bluez/bluez-libs-3.27/install

Utils:
>./configure --build=mipsel-linux --with-bluez=/home/newbuild/bluez/bluez-
libs-3.27/install/usr CPPFLAGS="-D__KERNEL__ "
>make

and following is the error

make  all-recursive
make[1]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27'
Making all in sbc
make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/sbc'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/sbc'
Making all in eglib
make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/eglib'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/eglib'
Making all in common
make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/common'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/common'
Making all in sdpd
make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/sdpd'
gcc -DHAVE_CONFIG_H -I. -I.. -I../common  -D__KERNEL__  -I../eglib -Wall -O2
-D_FORTIFY_SOURCE=2 -MT service.o -MD -MP -MF .deps/service.Tpo -c -o
service.o service.c
service.c: In function 'update_svclass_list':
service.c:87: error: 'sdp_record_t' has no member named 'svclass'
service.c:90: error: 'sdp_record_t' has no member named 'svclass'
service.c: In function 'create_ext_inquiry_response':
service.c:188: error: 'sdp_record_t' has no member named 'svclass'
service.c:191: error: 'sdp_record_t' has no member named 'svclass'
service.c:200: error: 'sdp_record_t' has no member named 'svclass'
service.c:206: error: 'sdp_record_t' has no member named 'svclass'
make[2]: *** [service.o] Error 1
make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/sdpd'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27'
make: *** [all] Error 2

Does anyone has solution for this.waiting for your valuable responses.

Regards
Umesh

------=_Part_5490_13064989.1206179204073
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all<br>I am trying to compile bluez-libs-3.27 &amp; bluez-utils-3.27 for mips32 and I use buildroot&#39;s toolchain and i get following errors<br><br>Compilation Steps:<br><br>export PATH=/home/newbuild/buildroot/build_mipsel/staging_dir/bin:$PATH &lt;toolchain path&gt;<br>
<br>Libs:<br>&gt;./configure --host=mipsel-linux --prefix=/usr --enable-shared=no --enable-static=yes<br>&gt;make<br>&gt;make install DESTDIR=/home/newbuild/bluez/bluez-libs-3.27/install<br><br>Utils:<br>&gt;./configure --build=mipsel-linux --with-bluez=/home/newbuild/bluez/bluez-libs-3.27/install/usr CPPFLAGS=&quot;-D__KERNEL__ &quot;<br>
&gt;make<br><br>and following is the error<br><br>make&nbsp; all-recursive<br>make[1]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27&#39;<br>Making all in sbc<br>make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/sbc&#39;<br>
make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/sbc&#39;<br>Making all in eglib<br>make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/eglib&#39;<br>
make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/eglib&#39;<br>Making all in common<br>make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/common&#39;<br>
make[2]: Nothing to be done for `all&#39;.<br>make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/common&#39;<br>Making all in sdpd<br>make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/sdpd&#39;<br>
gcc -DHAVE_CONFIG_H -I. -I.. -I../common&nbsp; -D__KERNEL__&nbsp; -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2 -MT service.o -MD -MP -MF .deps/service.Tpo -c -o service.o service.c<br>service.c: In function 'update_svclass_list':<br>service.c:87: error: 'sdp_record_t' has no member named 'svclass'<br>
service.c:90: error: 'sdp_record_t' has no member named 'svclass'<br>service.c: In function 'create_ext_inquiry_response':<br>service.c:188: error: 'sdp_record_t' has no member named 'svclass'<br>service.c:191: error: 'sdp_record_t' has no member named 'svclass'<br>
service.c:200: error: 'sdp_record_t' has no member named 'svclass'<br>service.c:206: error: 'sdp_record_t' has no member named 'svclass'<br>make[2]: *** [service.o] Error 1<br>make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/sdpd&#39;<br>
make[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27&#39;<br>make: *** [all] Error 2<br><br>Does anyone has solution for this.waiting for your valuable responses.<br><br>
Regards<br>Umesh<br><br><br>

------=_Part_5490_13064989.1206179204073--


--===============1316812867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1316812867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1316812867==--
