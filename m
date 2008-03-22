Return-Path: <cyrus@holtmann.org>
Message-Id: <402D92F0-24B2-4FF8-AFC4-85765D09296B@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c34db00803220246y5941f4d7p14bfa6af06c5b9b1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 22 Mar 2008 14:43:07 +0100
References: <b5c34db00803220246y5941f4d7p14bfa6af06c5b9b1@mail.gmail.com>
Subject: Re: [Bluez-users] bluetooth compilation regarded
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I am trying to compile bluez-libs-3.27 & bluez-utils-3.27 for mips32  
> and I use buildroot's toolchain and i get following errors
>
> Compilation Steps:
>
> export PATH=/home/newbuild/buildroot/build_mipsel/staging_dir/bin: 
> $PATH <toolchain path>
>
> Libs:
> >./configure --host=mipsel-linux --prefix=/usr --enable-shared=no -- 
> enable-static=yes
> >make
> >make install DESTDIR=/home/newbuild/bluez/bluez-libs-3.27/install
>
> Utils:
> >./configure --build=mipsel-linux --with-bluez=/home/newbuild/bluez/ 
> bluez-libs-3.27/install/usr CPPFLAGS="-D__KERNEL__ "
> >make
>
> and following is the error
>
> make  all-recursive
> make[1]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27'
> Making all in sbc
> make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> sbc'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/sbc'
> Making all in eglib
> make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> eglib'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> eglib'
> Making all in common
> make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> common'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> common'
> Making all in sdpd
> make[2]: Entering directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> sdpd'
> gcc -DHAVE_CONFIG_H -I. -I.. -I../common  -D__KERNEL__  -I../eglib - 
> Wall -O2 -D_FORTIFY_SOURCE=2 -MT service.o -MD -MP -MF .deps/ 
> service.Tpo -c -o service.o service.c
> service.c: In function 'update_svclass_list':
> service.c:87: error: 'sdp_record_t' has no member named 'svclass'
> service.c:90: error: 'sdp_record_t' has no member named 'svclass'
> service.c: In function 'create_ext_inquiry_response':
> service.c:188: error: 'sdp_record_t' has no member named 'svclass'
> service.c:191: error: 'sdp_record_t' has no member named 'svclass'
> service.c:200: error: 'sdp_record_t' has no member named 'svclass'
> service.c:206: error: 'sdp_record_t' has no member named 'svclass'
> make[2]: *** [service.o] Error 1
> make[2]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27/ 
> sdpd'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/newbuild/bluez/bluez-utils-3.27'
> make: *** [all] Error 2

it tries to compile against an old version of libbluetooth. Make sure  
you really compile against bluez-libs-3.27.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
