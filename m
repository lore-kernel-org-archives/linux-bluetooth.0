Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040930111009.21569.qmail@web53208.mail.yahoo.com>
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1096496461.6380.6.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Compiling Bluez into suse 9.1 pro
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
Date: Thu, 30 Sep 2004 04:10:09 -0700 (PDT)

I downloaded from cvs the source of bluez
I can compile only libs, sdp and hcidump
the others (pan, utils, obex, bluefw and hciemu) are
giving errors


1 --------------------- running bootstrap give an
error
"bad interpreter: no such file or directory"
So I proceded running the contents of the file itself
(copy-paste in the command line, excluding
"#!/bin/sh") for every bootstrap file.

doing so I obtain a configure file, so I can proceeds
running configure, than make and after make install.

These are the problems encountered during configure or
make phase of compilation.

2 --------------------- for pan and for hciemu, 
running configure I obtains "configure: error: cannot
run /bin/sh ./config.sub"
3 --------------------- for utils, 
make fails, this is the output:
make  all-recursive
make[1]: Entering directory `/home/maxc/prj/4/utils'
Making all in hcid
make[2]: Entering directory
`/home/maxc/prj/4/utils/hcid'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory
`/home/maxc/prj/4/utils/hcid'
Making all in tools
make[2]: Entering directory
`/home/maxc/prj/4/utils/tools'
gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include 
-I/usr/include -Wall -O2 -c sdptool.c
sdptool.c: In function `add_audio_source':
sdptool.c:1583: error: `AUDIO_SOURCE_SVCLASS_ID'
undeclared (first use in this function)
sdptool.c:1583: error: (Each undeclared identifier is
reported only once
sdptool.c:1583: error: for each function it appears
in.)
sdptool.c:1587: error: `ADVANCED_AUDIO_PROFILE_ID'
undeclared (first use in this function)
sdptool.c:1598: error: `AVDTP_UUID' undeclared (first
use in this function)
sdptool.c: In function `add_audio_sink':
sdptool.c:1642: error: `AUDIO_SINK_SVCLASS_ID'
undeclared (first use in this function)
sdptool.c:1646: error: `ADVANCED_AUDIO_PROFILE_ID'
undeclared (first use in this function)
sdptool.c:1657: error: `AVDTP_UUID' undeclared (first
use in this function)
sdptool.c: At top level:
sdptool.c:1706: error: `AUDIO_SOURCE_SVCLASS_ID'
undeclared here (not in a function)
sdptool.c:1706: error: initializer element is not
constant
sdptool.c:1706: error: (near initialization for
`service[13].class')
sdptool.c:1706: error: initializer element is not
constant
sdptool.c:1706: error: (near initialization for
`service[13]')
sdptool.c:1707: error: `AUDIO_SINK_SVCLASS_ID'
undeclared here (not in a function)
sdptool.c:1707: error: initializer element is not
constant
sdptool.c:1707: error: (near initialization for
`service[14].class')
sdptool.c:1707: error: initializer element is not
constant
sdptool.c:1707: error: (near initialization for
`service[14]')
sdptool.c:1709: error: initializer element is not
constant
sdptool.c:1709: error: (near initialization for
`service[15]')
make[2]: *** [sdptool.o] Error 1
make[2]: Leaving directory
`/home/maxc/prj/4/utils/tools'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/maxc/prj/4/utils'
make: *** [all] Error 2

4 --------------------- for bluefw, 
doing make I obtain this output:
"/usr/src/linux/include/linux/usbdevice_fs.h:49
variable or field '__user' declared void"
5 --------------------- for obex,
during make, the "gcc ... -o btobex ..."
say: "./obex.c: undefined reference to
'OBEX_SetTransportMTU'"

How to solve these problems?
Can you help me?

thanks for your time

(sorry for cross posting, similar mails was sent to
bluez-users list, maybe this is a better place for
these problems)


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
