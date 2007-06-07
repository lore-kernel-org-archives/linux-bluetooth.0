Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 7 Jun 2007 16:12:26 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <568785.88635.qm@web58011.mail.re3.yahoo.com>
Subject: [Bluez-users] integrated bluez libs and utilities
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

List,

Previous e-mail talks about to integrate bluez libs
and utilities into kernel tree should be source file
tree including kernel. Because my system is embedded,
I need to integrate bluez-libs-3.11 and
bluez-utils-3.11 with current source tree and then do
"make menuconfig" and then run "make" to compile.

I know how to run confirgure, make and make install in
fedora 5.

Should I run configure first in fedora 5 and copy
Makefile, .configure and subdirectories include and
src into embedded source file tree?

----henry 


 
____________________________________________________________________________________
8:00? 8:25? 8:40? Find a flick in no time 
with the Yahoo! Search movie showtime shortcut.
http://tools.search.yahoo.com/shortcuts/#news

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
