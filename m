Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4dfd570904122402134ec2fd32@mail.gmail.com>
From: CoCozZ geek <cocozz@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Error when compiling bluez-utils
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
Date: Fri, 24 Dec 2004 11:13:47 +0100

I get those errors when I compile bluez-utils ... using
2.6.8-gentoo-r10 and gcc (GCC) 3.3.4 20040623.

Thanks :)

gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include  -I/usr/include
-march=pentium4 -O3 -pipe -fomit-frame-pointer -c `test -f
'hcisecfilter.c' || echo './'`hcisecfilter.c
sdptool.c: In function `add_handsfree':
sdptool.c:1130: error: `HANDSFREE_SVCLASS_ID' undeclared (first use in
this function)
sdptool.c:1130: error: (Each undeclared identifier is reported only once
sdptool.c:1130: error: for each function it appears in.)
sdptool.c:1136: error: `HANDSFREE_PROFILE_ID' undeclared (first use in
this function)
sdptool.c:1152: error: `SDP_SUPPORTED_FEATURES' undeclared (first use
in this function)
sdptool.c: In function `add_audio_source':
sdptool.c:1583: error: `AUDIO_SOURCE_SVCLASS_ID' undeclared (first use
in this function)
sdptool.c:1587: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
use in this function)sdptool.c:1598: error: `AVDTP_UUID' undeclared
(first use in this function)
sdptool.c: In function `add_audio_sink':
sdptool.c:1642: error: `AUDIO_SINK_SVCLASS_ID' undeclared (first use
in this function)
sdptool.c:1646: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
use in this function)sdptool.c:1657: error: `AVDTP_UUID' undeclared
(first use in this function)
sdptool.c: At top level:
sdptool.c:1697: error: `HANDSFREE_SVCLASS_ID' undeclared here (not in
a function)
sdptool.c:1697: error: initializer element is not constant
sdptool.c:1697: error: (near initialization for `service[7].class')
sdptool.c:1697: error: initializer element is not constant
sdptool.c:1697: error: (near initialization for `service[7]')
sdptool.c:1699: error: initializer element is not constant
sdptool.c:1699: error: (near initialization for `service[8]')
sdptool.c:1700: error: initializer element is not constant
sdptool.c:1700: error: (near initialization for `service[9]')
sdptool.c:1702: error: initializer element is not constant
sdptool.c:1702: error: (near initialization for `service[10]')
sdptool.c:1703: error: initializer element is not constant
sdptool.c:1703: error: (near initialization for `service[11]')
sdptool.c:1704: error: initializer element is not constant
sdptool.c:1704: error: (near initialization for `service[12]')
sdptool.c:1706: error: `AUDIO_SOURCE_SVCLASS_ID' undeclared here (not
in a function)gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include 
-I/usr/include -march=pentium4 -O3 -pipe -fomit-frame-pointer -c `test
-f 'hciattach.c' || echo './'`hciattach.c
sdptool.c:1706: error: initializer element is not constant
sdptool.c:1706: error: (near initialization for `service[13].class')
sdptool.c:1706: error: initializer element is not constant
sdptool.c:1706: error: (near initialization for `service[13]')
sdptool.c:1707: error: `AUDIO_SINK_SVCLASS_ID' undeclared here (not in
a function)
sdptool.c:1707: error: initializer element is not constant
sdptool.c:1707: error: (near initialization for `service[14].class')
sdptool.c:1707: error: initializer element is not constant
sdptool.c:1707: error: (near initialization for `service[14]')
sdptool.c:1709: error: initializer element is not constant
sdptool.c:1709: error: (near initialization for `service[15]')
make[2]: *** [sdptool.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory
`/var/tmp/portage/bluez-utils-2.10-r1/work/bluez-utils-2.10/tools'make[1]:
*** [all-recursive] Error 1
make[1]: Leaving directory
`/var/tmp/portage/bluez-utils-2.10-r1/work/bluez-utils-2.10'
make: *** [all] Error 2

!!! ERROR: net-wireless/bluez-utils-2.10-r1 failed.
!!! Function src_compile, Line 53, Exitcode 2
!!! (no error message)
!!! If you need support, post the topmost build error, NOT this status message.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
