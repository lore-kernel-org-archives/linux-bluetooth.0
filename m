Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <453296A6.5030505@xmission.com>
Date: Sun, 15 Oct 2006 14:14:30 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] pskey gone, but bccmd won't build
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

Marcel

I noticed pskey disappear from utils/tools in cvs. Is bccmd preferred
for setting pskey values? bccmd won't build from the current utils.

bmidgley@med:~/src/bluez/utils/tools$ make bccmd
/bin/sh ../libtool --mode=link gcc -I/usr/local/include
-I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2  -o bccmd
gcc -I/usr/local/include -I/usr/local/include -Wall -O2
-D_FORTIFY_SOURCE=2 -o bccmd
gcc: no input files
make: *** [bccmd] Error 1

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
