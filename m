Return-Path: <the-flash@web.de>
Date: Fri, 21 May 2004 18:17:54 +0200
From: the-flash@web.de
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unresolved Symbols
Message-ID: <20040521161754.GB17561@mcmabrruq.sirius.net>
References: <20040520090502.GA4352@mcmabrruq.sirius.net> <1085044940.4327.135.camel@pegasus> <20040520114752.GA3125@mcmabrruq.sirius.net> <1085056072.4327.166.camel@pegasus> <20040521161644.GA17561@mcmabrruq.sirius.net>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
In-Reply-To: <20040521161644.GA17561@mcmabrruq.sirius.net> (from florian.beyer@aei.mpg.de on Fre, Mai 21, 2004 at 18:16:44 +0200)
List-ID: <bluez-users.lists.sourceforge.net>

Hello,

> And so what? Run "hciconfig hci0 up" or start "hcid".

Ok, this was the missing key :-) ... now that works.

I am even able to mount my Nokia6600 with p3nfs via bluetooth  
now ... :-)

But, now the problem is that gnokii does not seem to be able to find my  
bluetooth libraries/include files. I have installed bluez-libs-2.7 with  
the --prefix=/usr option. Doing a 'configure --prefix=/usr' in the  
gnokii-0.6.1 source directory gives

checking for the bluetooth support...
checking for the struct sockaddr_rc in <bluetooth/rfcomm.h>... no
checking for the MacOS X bluetooth support...
checking CoreFoundation/CoreFoundation.h usability... no
checking CoreFoundation/CoreFoundation.h presence... no
checking for CoreFoundation/CoreFoundation.h... no
checking IOBluetooth/Bluetooth.h usability... no
checking IOBluetooth/Bluetooth.h presence... no
checking for IOBluetooth/Bluetooth.h... no
checking IOBluetooth/IOBluetoothUserLib.h usability... no
checking IOBluetooth/IOBluetoothUserLib.h presence... no
checking for IOBluetooth/IOBluetoothUserLib.h... no



and config.log says

configure:27343: checking for the bluetooth support
configure:27346: checking for the struct sockaddr_rc in <bluetooth/ 
rfcomm.h>
configure:27369: gcc -c -g -O2  conftest.c >&5
conftest.c: In function `main':
conftest.c:105: storage size of `rc' isn't known
configure:27375: $? = 1
configure: failed program was:
| /* confdefs.h.  */
|
| #define PACKAGE_NAME ""
| #define PACKAGE_TARNAME ""
| #define PACKAGE_VERSION ""
| #define PACKAGE_STRING ""
| #define PACKAGE_BUGREPORT ""
| #define YYTEXT_POINTER 1
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_DLFCN_H 1
| #ifdef __cplusplus
| extern "C" void std::exit (int) throw (); using std::exit;
| #endif
| #define HAVE_ICONV 1
| #define ICONV_CONST
| #define HAVE_LIBINTL_H 1
| #define HAVE_LONG_LONG 1
| #define HAVE_LONG_DOUBLE 1
| #define HAVE_WCHAR_T 1
| #define HAVE_WINT_T 1
| #define HAVE_INTTYPES_H_WITH_UINTMAX 1
| #define HAVE_STDINT_H_WITH_UINTMAX 1
| #define HAVE_INTMAX_T 1
| #define HAVE_POSIX_PRINTF 1
| #define HAVE_ALLOCA_H 1
| #define HAVE_ALLOCA 1
| #define HAVE_STDLIB_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_GETPAGESIZE 1
| #define HAVE_MMAP 1
| #define INTDIV0_RAISES_SIGFPE 1
| #define HAVE_UNSIGNED_LONG_LONG 1
| #define HAVE_UINTMAX_T 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_ARGZ_H 1
| #define HAVE_LIMITS_H 1
| #define HAVE_LOCALE_H 1
| #define HAVE_NL_TYPES_H 1
| #define HAVE_MALLOC_H 1
| #define HAVE_STDDEF_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_SYS_PARAM_H 1
| #define HAVE_ASPRINTF 1
| #define HAVE_FWPRINTF 1
| #define HAVE_GETCWD 1
| #define HAVE_GETEGID 1
| #define HAVE_GETEUID 1
| #define HAVE_GETGID 1
| #define HAVE_GETUID 1
| #define HAVE_MEMPCPY 1
| #define HAVE_MUNMAP 1
| #define HAVE_PUTENV 1
| #define HAVE_SETENV 1
| #define HAVE_SETLOCALE 1
| #define HAVE_SNPRINTF 1
| #define HAVE_STPCPY 1
| #define HAVE_STRCASECMP 1
| #define HAVE_STRDUP 1
| #define HAVE_STRTOUL 1
| #define HAVE_TSEARCH 1
| #define HAVE_WCSLEN 1
| #define HAVE___ARGZ_COUNT 1
| #define HAVE___ARGZ_STRINGIFY 1
| #define HAVE___ARGZ_NEXT 1
| #define HAVE___FSETLOCKING 1
| #define HAVE_DECL__SNPRINTF 0
| #define HAVE_DECL__SNWPRINTF 0
| #define HAVE_DECL_FEOF_UNLOCKED 1
| #define HAVE_DECL_FGETS_UNLOCKED 0
| #define HAVE_DECL_GETC_UNLOCKED 1
| #define HAVE_ICONV 1
| #define ICONV_CONST
| #define HAVE_LANGINFO_CODESET 1
| #define HAVE_LC_MESSAGES 1
| #define ENABLE_NLS 1
| #define HAVE_GETTEXT 1
| #define HAVE_DCGETTEXT 1
| #define DEBUG 1
| #define XDEBUG 1
| #define RLP_DEBUG 1
| #define HAVE_TM_GMTON 1
| #define HAVE_TIMEOPS 1
| #define HAVE_CFSETSPEED 1
| #define HAVE_IRDA 1
| /* end confdefs.h.  */
| #include <sys/socket.h>
| 			#include <bluetooth/bluetooth.h>
| 			#include <bluetooth/rfcomm.h>
| int
| main ()
| {
| struct sockaddr_rc rc;
|   ;
|   return 0;
| }




What's wrong now?

Thanks again for your help!

Best,
Florian
