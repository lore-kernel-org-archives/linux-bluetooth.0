Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Armin Bauer <armin.bauer@desscon.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1095586945.4389.11.camel@azrael>
Mime-Version: 1.0
Subject: [Bluez-devel] configure.in question
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 19 Sep 2004 11:42:25 +0200

Hi,

im one of the multisync devs. as you probably know, we are using your
bluetooth libraries in our application.

Up until now we used this in a configure.in to detect the bluetooth
libraries:

AC_CHECK_LIB(bluetooth,baswap,BLUETOOTH=1,BLUETOOTH=0)
SDP=0
AC_CHECK_LIB(sdp,sdp_list_free,SDP=1,BLUETOOTH=0)
AC_MSG_CHECKING(for correct SDP lib version)
AC_TRY_COMPILE([
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
],[sdp_record_t t;],AC_MSG_RESULT(yes),BLUETOOTH=0;AC_MSG_RESULT(no))
AM_CONDITIONAL(BLUETOOTH,test "${BLUETOOTH}" = "1")
if test "x${BLUETOOTH}" = "x0"; then
  echo "Bluetooth is DISABLED. You must have bluez-libs and bluez-kernel
>= 2.3 and bluez-sdp >= 1.0-pre1."
fi
AC_DEFINE_UNQUOTED(HAVE_BLUETOOTH, ${BLUETOOTH},Defined if Bluetooth is
enabled.)

and src/Makefile.am

libirmc_bluetooth_la_LIBADD = -lbluetooth -lsdp -lpthread

some time ago, the sdp library merged into the libbluetooth. Therefore
this check will not detect this correctly anymore.

So i was wondering what would be the correct approach to detect if the
-lsdp is needed? Which version was the first version of libbluetooth
that got rid of the libsdp?

Armin



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
