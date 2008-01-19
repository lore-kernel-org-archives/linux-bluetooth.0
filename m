Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jan 2008 16:32:09 -0800 (PST)
From: Andy Jakab <ajjakab@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <290338.40624.qm@web58715.mail.re1.yahoo.com>
Subject: [Bluez-users] VMWare BlueZ Utils and Lib Compile for uClinux target
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

I have searcher through the archives and haven't been able to find a
solution. Hopefully someone can provide an answer for me.

In compiling the bluez lib and utils, I am having some issues with the
proper toolchain and target with the ./configuration parameters. I am
clearly missing something as the make is trying to put the libraries
into the root folder, instead of the uClinux-dsit folder. The target
processor in the LPC2468.

I am trying to build from:
user@eadevenv:~uClinux-dist/user/bluez/bluez-libs-3.24$ ./configure
--host=arm-v4l-linux --libdir=/home/user/uClinux-dist/linux-2.6.x/lib
--includedir=/home/user/uClinux-dist/linux-2.6.x/include
--with-kernel=/home/user/uClinux-dist/linux-2.6.x/

the result of 'make' ends with:

FATAL: can't create .libs/bluetooth.o: Permission denied

I'm missing something because if I run the make as su, it puts the
library into wrong folder (.user/lib).

Any help would be greatly appreciated.

Thanks!


      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
