Return-Path: <massimiliano_cuccia@yahoo.com>
Message-ID: <20040929102923.24388.qmail@web53206.mail.yahoo.com>
Date: Wed, 29 Sep 2004 03:29:23 -0700 (PDT)
From: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Subject: Re: [Bluez-users] compiling bluez/obex (btobex)
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040928225548.79491.qmail@web53204.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

> 3 - for utils, I need yacc ... so I will report
> later 
I installed bison from my distribution, so these are
the results of make command:

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

... where are the problems?
I only compiled libs, sdp and hcidump
the others (pan, utils, obex, bluefw and hciemu) are
giving errors


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
