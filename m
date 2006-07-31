Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: thermal@o2.pl
To: bluez-devel@lists.sourceforge.net
Date: Mon, 31 Jul 2006 22:32:58 +0200
MIME-Version: 1.0
Message-Id: <200607312232.58278.thermal@o2.pl>
Subject: [Bluez-devel] [PATCH] inline keyword & ansi-C compilers
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi

Recently when I`ve tried to compile KDE (ktnef to be exact) I came upon 
an error in your include files:

configure:34044: result: /usr/bin/doxygen
configure:34133: checking bluetooth/bluetooth.h usability
configure:34145: 
i686-pc-linux-gnu-gcc -c -std=iso9899:1990 -W -Wall -Wchar-subscripts -Wshadow -Wpointer-arith -Wmissing-prototypes
 -Wwrite-strings -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -DNDEBUG -O2  -O2 -march=k6 -mtune=athlon-xp -pipe -Wformat-security -Wmissing-fo
rmat-attribute  -DQT_THREAD_SUPPORT  -D_REENTRANT conftest.c >&5
In file included from conftest.c:101:
/usr/include/bluetooth/bluetooth.h:113: error: 
expected '=', ',', ';', 'asm' or '__attribute__' before 'int'
/usr/include/bluetooth/bluetooth.h:117: error: 
expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
configure:34151: $? = 1

After checking the header file it became clear that the 'inline' keyword 
is responsible for the mess. As you can see ./configure is executing 
gcc with -std=iso9899:1990 flag which sets the language dialect to pure 
C89. Unfortunately this dialect doesn`t support the 'inline' keyword. 
To reproduce this bug try:

thermal@newhope ~ $ cat > a.c
#include <bluetooth.h>
thermal@newhope ~ $ gcc -std=iso9899:1990 -c -I ~/bluez-libs-3.2/include 
a.c
In file included from a.c:1:
/home/thermal/bluez-libs-3.2/include/bluetooth.h:113: error: 
expected '=', ',', ';', 'asm' or '__attribute__' before 'int'
/home/thermal/bluez-libs-3.2/include/bluetooth.h:117: error: 
expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
thermal@newhope ~ $

So I wrote a tiny patch to fix this:

--- bluez-libs-3.2/include/bluetooth.h  2006-07-31 20:57:08.000000000 
+0200
+++ /usr/include/bluetooth/bluetooth.h  2006-07-31 20:55:55.000000000 
+0200
@@ -109,12 +109,19 @@
 #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 
0xff}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})

+/* No inline keyword in the iso8988:1990 standard */
+#ifdef __STRICT_ANSI__
+    #define __INLINE
+#else
+    #define __INLINE inline
+#endif
+
 /* Copy, swap, convert BD Address */
-static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
+static __INLINE int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 {
        return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
-static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
+static __INLINE void bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
        memcpy(dst, src, sizeof(bdaddr_t));
 }

After applying it all compiles nicely:

thermal@newhope ~ $ cat > a.c
#include <bluetooth/bluetooth.h>
thermal@newhope ~ $ gcc -std=iso9899:1990 -c a.c
thermal@newhope ~ $

(Note: my patched header file lives in /usr/inlude/bluetooth). It would 
be nice if the patch was included in the main source.

-- 
|   ******* Maciek Grela RV409b *********
|        JID: thermal@jabber.wroc.pl
| Linux user #319794 ++ There is no spoon ...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
