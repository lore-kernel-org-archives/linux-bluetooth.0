Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] configure.in question
From: Marcel Holtmann <marcel@holtmann.org>
To: Armin Bauer <armin.bauer@desscon.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095586945.4389.11.camel@azrael>
References: <1095586945.4389.11.camel@azrael>
Content-Type: text/plain
Message-Id: <1095589888.24448.14.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 19 Sep 2004 12:31:28 +0200

Hi Armin,

> im one of the multisync devs. as you probably know, we are using your
> bluetooth libraries in our application.
> 
> Up until now we used this in a configure.in to detect the bluetooth
> libraries:
> 
> AC_CHECK_LIB(bluetooth,baswap,BLUETOOTH=1,BLUETOOTH=0)
> SDP=0
> AC_CHECK_LIB(sdp,sdp_list_free,SDP=1,BLUETOOTH=0)
> AC_MSG_CHECKING(for correct SDP lib version)
> AC_TRY_COMPILE([
> #include <bluetooth/sdp.h>
> #include <bluetooth/sdp_lib.h>
> ],[sdp_record_t t;],AC_MSG_RESULT(yes),BLUETOOTH=0;AC_MSG_RESULT(no))
> AM_CONDITIONAL(BLUETOOTH,test "${BLUETOOTH}" = "1")
> if test "x${BLUETOOTH}" = "x0"; then
>   echo "Bluetooth is DISABLED. You must have bluez-libs and bluez-kernel
> >= 2.3 and bluez-sdp >= 1.0-pre1."
> fi
> AC_DEFINE_UNQUOTED(HAVE_BLUETOOTH, ${BLUETOOTH},Defined if Bluetooth is
> enabled.)
> 
> and src/Makefile.am
> 
> libirmc_bluetooth_la_LIBADD = -lbluetooth -lsdp -lpthread
> 
> some time ago, the sdp library merged into the libbluetooth. Therefore
> this check will not detect this correctly anymore.
> 
> So i was wondering what would be the correct approach to detect if the
> -lsdp is needed? Which version was the first version of libbluetooth
> that got rid of the libsdp?

from the ChangeLog file of bluez-libs you will see that the SDP library
was merged into the Bluetooth library with version 2.6. I kept a dummy
(empty) libsdp until 2.8, so that using -lsdp was still working. For
version 2.9 and 2.10 you must only link against -lbluetooth.

The bluez-utils contains a simple test in acinclude.m4 that will do this
right if needed. Testing only for a structure is wrong. You must check
in which library the SDP function are included if you want support older
versions where the Bluetooth library and SDP library were seperated. Our
test works like this:

	AC_CHECK_HEADER(bluetooth/bluetooth.h, ...)
		==> pass: activate Bluetooth
		==> fail: no Bluetooth
	AC_CHECK_LIB(bluetooth, hci_open_dev, ...)
		==> pass: add -lbluetooth
		==> fail: deactivate Bluetooth
	AC_CHECK_LIB(sdp, sdp_connect, ...)
		==> pass: add -lsdp
		==> fail: do nothing

I already wrote this on the MultiSync mailing list. Please correct the
help text, because you don't need a bluez-kernel package. You only need
a kernel with RFCOMM support and even this is not needed for compilation
of the source. It is a runtime requirement. Even the requirement of the
bluez-sdp package will confuse the people, because I deprecated it over
5 month ago.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
