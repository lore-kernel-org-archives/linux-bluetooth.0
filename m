Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <82721080501190249144cfac0@mail.gmail.com>
From: tcalexander <tcalexander@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] bluez-utils-2.14 compile error: make returns "cannot find -lbluetooth"
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
Date: Wed, 19 Jan 2005 12:49:52 +0200

Hello everyone!
I'm using Yoper with a 2.6.8.1-3 kernel. I downloaded bluez-libs and
bluez-utils, both 2.14. Did the following:
(in /home/blabla/bluez-libs-2.14)
./configure --prefix=/usr/local/bluez
make
(did a su)
make install 
(so far so good)
(now to /home/blabla/bluez-utils-2.14)
./configure --prefix=/usr/local/bluez
make
(now things go crappy, read below the final lines of the output)

gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/local/bluez/include 
-I/usr/local/bluez/include -Wall -O2 -c `test -f 'hcisecfilter.c' ||
echo './'`hcisecfilter.c
gcc -I/usr/local/bluez/include  -I/usr/local/bluez/include -Wall -O2  
-o hcisecfilter  hcisecfilter.o  -lbluetooth
/usr/lib/gcc/i686-pc-linux-gnu/3.4.1/../../../../i686-pc-linux-gnu/bin/ld:
cannot find -lbluetooth
collect2: ld returned 1 exit status
make[2]: *** [hcisecfilter] Error 1
make[2]: Leaving directory `/home/blabla/bluez-utils-2.14/tools'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/blabla/bluez-utils-2.14'
make: *** [all] Error 2

*blabla stands for a long and awkward branch of the directory tree; I
found it to be annoying, so I replaced it;

Couldn't find any hints anywhere. :( I saw another topic on compile
errors, but it wasn't quite what I needed, so I came up with this one.
If it's been discussed earlier, please point it out. 10x in advance.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
