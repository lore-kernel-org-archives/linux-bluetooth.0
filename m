Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203105034.93588.qmail@web60908.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050203052237.GE9259@snoopy.src.ricoh.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Thu, 3 Feb 2005 18:50:34 +0800 (CST)

Hi all users!
    I first give a thank to Alain Volmat that points
out my fault and confusion about rctest.c. Then I put
the parts do_listen and recv_mode in my main porgram.
But when I compile, strange things occur.....
    As my program is MySQL C API, I have to compile
with "gcc -c -I/usr/include/mysql XX.c", and it is no
problem. But when I type "gcc -o XX XX.o
-L/usr/lib/mysql -lmysqlclient", following occurs:
bic_midterm.o(.text+0x1c0a): In function `do_listen':
: undefined reference to `ba2str'
collect2: ld returned 1 exit status
I checked with rctest.c, but there is not a function
for ba2str. On the other hand, tv2fl can be accepted
as there is a function in rctest.c. Here are the
include files in my main program. 
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif
                                                      
                         
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <string.h>
#include <termios.h>
#include <syslog.h>
#include <errno.h>
#include <ctype.h>
#include <signal.h>
                                                      
                         
#include <modeminit.h>
include <modeminit.c>
#include <logging.c>
#include <logging.h>
#include <extras.h>
#include <extras.c>
#include <locking.c>
#include <locking.h>
#include <alarm.h>
#include <alarm.c>

#include <sys/file.h>
                                                      
                         
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
                                                      
                         
#include <mysql/mysql.h>
Let's see if there is any function that is missing. If
there is no function missing, where can I find the
ba2str function? I believe that if ba2str function can
be found declared, the program can be run. Thank you
very much for your kindness.
Michael

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
