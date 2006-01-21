Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D1ED1A.1090400@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] cross-compiling btsco
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
Date: Sat, 21 Jan 2006 01:13:14 -0700

Marcel,

I'm trying to straightening out fixed-point using a gumstix board to
test stuff. I used to be able to cross-compile btsco for gumstix but
something changed. Now during the link libtool translates "-lbluetooth"
into /usr/lib/libbluetooth.so instead of the arm libbluetooth.so inside
the cross-compile tree. I've tried overriding this in the configure and
make statements with just about everything I can think of.

Is there something our sources are missing for enabling a cross-compile?

Brad

make[3]: Entering directory
`/home/bmidgley/buildroot-2.6.14/build_arm_nofpu/btsco/sbc'
/bin/sh ../libtool --mode=link
/home/bmidgley/buildroot-2.6.14/build_arm_nofpu/staging_dir/bin/arm-linux-uclibc-gcc
 -DUSE_FIXED
-I/home/bmidgley/buildroot-2.6.14/build_arm_nofpu/staging_dir/include
-DFORCE_LITTLE -Os -march=armv5te -mtune=xscale -Wa,-mcpu=xscale    -o
sbcinfo  sbcinfo.o  -lbluetooth
/home/bmidgley/buildroot-2.6.14/build_arm_nofpu/staging_dir/bin/arm-linux-uclibc-gcc
-DUSE_FIXED
-I/home/bmidgley/buildroot-2.6.14/build_arm_nofpu/staging_dir/include
-DFORCE_LITTLE -Os -march=armv5te -mtune=xscale -Wa,-mcpu=xscale -o
sbcinfo sbcinfo.o  /usr/lib/libbluetooth.so
/usr/lib/libbluetooth.so: could not read symbols: File in wrong format
collect2: ld returned 1 exit status


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
