Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a72d33330702180733jc643ec1v857be8c144ab25a7@mail.gmail.com>
Date: Sun, 18 Feb 2007 16:33:54 +0100
From: "Ma Begaj" <derliebegott@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Plugz: compile errors with latest CVS
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I am trying to compile latest plugz for bluetooth-alsa without success. I
have bluez-libs and -utils 3.9. sbc is latest CVS checkout. gcc 3.4.6.
kernel 2.6.20

these are the errors. am I missing something?

---------------------------------------------------

creating liba2dpdcommon.la
(cd .libs && rm -f liba2dpdcommon.la && ln -s ../liba2dpdcommon.la
liba2dpdcommon.la)
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I/usr/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -pthread -I/usr/include/dbus-1.0
-I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -march=i686 -O3 -pipe -fomit-frame-pointer
-MT a2dpd-a2dpd.o -MD -MP -MF ".deps/a2dpd-a2dpd.Tpo" -c -o a2dpd-a2dpd.o
`test -f 'a2dpd.c' || echo './'`a2dpd.c; \
then mv -f ".deps/a2dpd-a2dpd.Tpo" ".deps/a2dpd-a2dpd.Po"; else rm
-f ".deps/a2dpd-a2dpd.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I/usr/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -pthread -I/usr/include/dbus-1.0
-I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -march=i686 -O3 -pipe -fomit-frame-pointer
-MT a2dpd-a2dpd_sdp.o -MD -MP -MF ".deps/a2dpd-a2dpd_sdp.Tpo" -c -o
a2dpd-a2dpd_sdp.o `test -f 'a2dpd_sdp.c' || echo './'`a2dpd_sdp.c; \
then mv -f ".deps/a2dpd-a2dpd_sdp.Tpo" ".deps/a2dpd-a2dpd_sdp.Po";
else rm -f ".deps/a2dpd-a2dpd_sdp.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I/usr/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -pthread -I/usr/include/dbus-1.0
-I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -march=i686 -O3 -pipe -fomit-frame-pointer
-MT a2dpd-a2dpd_uinput.o -MD -MP -MF ".deps/a2dpd-a2dpd_uinput.Tpo" -c -o
a2dpd-a2dpd_uinput.o `test -f 'a2dpd_uinput.c' || echo './'`a2dpd_uinput.c;
\
then mv -f ".deps/a2dpd-a2dpd_uinput.Tpo"
".deps/a2dpd-a2dpd_uinput.Po"; else rm -f ".deps/a2dpd-a2dpd_uinput.Tpo";
exit 1; fi
a2dpd_uinput.c: In function `init_uinput':
a2dpd_uinput.c:58: error: unknown field `id' specified in initializer
a2dpd_uinput.c:59: error: field name not in record or union initializer
a2dpd_uinput.c:59: error: (near initialization for `dev.name')
a2dpd_uinput.c:60: error: field name not in record or union initializer
a2dpd_uinput.c:60: error: (near initialization for `dev.name')
make[3]: *** [a2dpd-a2dpd_uinput.o] Error 1
make[3]: Leaving directory
`/home/Desktop/Download/plugz/alsa-plugins/a2dpd'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/Desktop/Download/plugz/alsa-plugins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/Desktop/Download/plugz'
make: *** [all] Error 2

------------------------------------------

Thanks.

M.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
