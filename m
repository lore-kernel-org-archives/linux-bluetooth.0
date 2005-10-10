Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Michael Renner <michael.renner@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510102149.11567.michael.renner@gmx.de>
Subject: [Bluez-devel] compiling btsco (a2play.o)
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
Date: Mon, 10 Oct 2005 21:49:11 +0200

Moin,

I just tried to compile the CVS version from yesterday. My machine is a debian 
stable installation (gcc 3.3.5) running a self compiled vanilla 2.6.13 kernel 
with its sources in /usr/src/linux.

As far as I see, every necessary package is installed in a current version.

Running configure gives one error:
./configure: line 4182: XIPH_PATH_AO: command not found

Trying to compile the package ends with an error:
make[2]: Entering directory `/usr/src/btsco'
gcc  -Wall -O2   -o a2play  a2play.o -lbluetooth -lbluetooth sbc/libsbc.a 
-lbluetooth
a2play.o(.text+0x189b): In function `main':
: undefined reference to `pthread_create'
a2play.o(.text+0x19e8): In function `main':
: undefined reference to `pthread_join'
collect2: ld returned 1 exit status

Whats wrong?

Thanks
-- 
|Michael Renner      E-mail: michael.renner@gmx.de  |
|D-72072 Tuebingen   Germany        ICQ: #112280325 |
|Germany             Don't drink as root!      ESC:wq


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
