Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Pierre Savary" <pierre.savary@kerlink.fr>
To: <bluez-devel-bounces@lists.sourceforge.net>,
        <bluez-users@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 16:03:43 +0200
Message-ID: <008801c8118f$b2615d60$17241820$@savary@kerlink.fr>
MIME-Version: 1.0
Subject: [Bluez-users] compile audio in bluez-utils-3.20
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

Hi,

I am a beginner with bluez and I hope that you will be able to inform me and
to help itself. I wish that my PC be the headset of my phone.
I wish that it embed audio profiles HFP and A2DP so that it can be used as
headset/handsfree for a telephone or a walkman.

To begin I try to compile audio/ package bluez-utils-3.20 but it doesn't
work ... I make ./configure --enable-all and obtain this config.h :
/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.in by autoheader.  */
/* Directory for the configuration files */
#define CONFIGDIR "/etc/bluetooth"
/* Define to 1 if you have D-Bus GLib bindings. */
/* #undef HAVE_DBUS_GLIB */
/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1
/* Define to 1 if you have the <expat.h> header file. */
/* #undef HAVE_EXPAT_H */
/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1
/* Define to 1 if you have USB library. */
#define HAVE_LIBUSB 1
/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1
/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1
/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1
/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1
/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1
/* Define to 1 if you have the <sys/inotify.h> header file. */
/* #undef HAVE_SYS_INOTIFY_H */
/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1
/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1
/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1
/* Define to 1 if you need the dbus_watch_get_unix_fd() function. */
#define NEED_DBUS_WATCH_GET_UNIX_FD 1
/* Define to 1 if you need the ppoll() function. */
#define NEED_PPOLL 1
/* Define to 1 if you need the usb_get_busses() function. */
/* #undef NEED_USB_GET_BUSSES */
/* Define to 1 if you need the usb_interrupt_read() function. */
/* #undef NEED_USB_INTERRUPT_READ */
/* Name of package */
#define PACKAGE "bluez-utils"
/* Define to the address where bug reports for this package should be sent.
*/
#define PACKAGE_BUGREPORT ""
/* Define to the full name of this package. */
#define PACKAGE_NAME ""
/* Define to the full name and version of this package. */
#define PACKAGE_STRING ""
/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME ""
/* Define to the version of this package. */
#define PACKAGE_VERSION ""
/* Directory for the service programs */
#define SERVICEDIR "/usr/local/lib/bluetooth"
/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1
/* Directory for the storage files */
#define STORAGEDIR "/var/lib/bluetooth"
/* Version number of package */
#define VERSION "3.20"
/* Define to 1 if `lex' declares `yytext' as a `char *' by default, not a
   `char[]'. */
/* #undef YYTEXT_POINTER */
Then I make a make ... and I don't see *.o file in the audio directory
???!!! What can I do?

Also, does it exist an opensource project for handsfree profile with bluez?
Could you help me to compile and to use a HFP profile please?

Big thanks in advance
Regards

Pierre



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
