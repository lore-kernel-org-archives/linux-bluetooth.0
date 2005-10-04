Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: neoclust <neoclust@mandriva.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200510042118.53657.neoclust@mandriva.org>
Subject: [Bluez-users] can't build bluez-utils 2.21
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
Date: Tue, 4 Oct 2005 21:18:52 +0200

hi, 

i can't build bluez-utils 2.21, i obtain this error:


In file included from csrinit.c:40:
csr.h:76: error: syntax error before 'id'
csr.h:77: error: syntax error before 'ver'
csr.h:78: error: syntax error before 'pskey'
csr.h:80: error: syntax error before 'uint16_t'
csr.h:81: error: syntax error before 'uint16_t'
csr.h:82: error: syntax error before 'uint16_t'
csr.h:83: error: syntax error before 'uint16_t'
csr.h:84: error: syntax error before 'uint16_t'
csr.h:85: error: syntax error before 'uint16_t'
csr.h:86: error: syntax error before 'uint16_t'
ICECREAM[16465]: Compiled on 192.168.2.53
make[2]: *** [csrinit.o] Error 1
make[2]: *** Waiting for unfinished jobs....
mkdir .libs
gcc -I/usr/include -I/usr/include -O2 -pipe -Wp,-D_FORTIFY_SOURCE=2 
-fomit-frame-pointer -march=i586 -mtune=pentiumpro -fpic -o hcitool hcitool.o 
oui.o  -L/usr/lib /lib/libbluetooth.so ../common/libtextfile.a
make[2]: Leaving directory `/home/neoclust/rpm/BUILD/bluez-utils-2.21/tools'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/neoclust/rpm/BUILD/bluez-utils-2.21'
make: *** [all] Error 2


I have bluez-lib 2.21



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
