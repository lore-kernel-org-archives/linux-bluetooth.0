Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1100995285.7250.17.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] BlueZ and the ALSA support
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
Date: Sun, 21 Nov 2004 01:01:24 +0100

Hi Folks,

I spent some hours to clean up the btsco CVS repository from the ALSA
Bluetooth project and also changed the code a little bit for easier use
by non technical people. It should now compile and work without the need
of reinstalling or changing any ALSA stuff. Here is a quick walktrough.

First the CVS repository must be checked out:

	cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa login
	cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco

After that is must be compiled:

	./bootstrap
	./configure
	make
	make install
	make maintainer-clean

And you need the kernel module:

	cd kernel
	make
	make install
	make clean

Now go ahead and use it like before.

As you may now realized the snd-bt-sco kernel driver is also inside this
repository and with a recent 2.6 kernel there are no problems with
compiling a kernel module outside the kernel source directory. However
if you haven't installed the running kernel by yourself you may need to
install the kernel source package from your distribution.

Every crappy header file is now removed and the needed IOCTL and the
HWDEP definition is added to the source directly in a compatible way.

The A2DP related programs are integrated into the Makefile and they are
also compiled, but for now they are not installed.

This should make the development a lot more easier :)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
