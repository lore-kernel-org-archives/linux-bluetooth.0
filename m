Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F28B10D34C6CA29EC4D37E9C1A70@phx.gbl>
In-Reply-To: <4dfd570904122402134ec2fd32@mail.gmail.com>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] Error when compiling bluez-utils
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
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
Date: Sat, 25 Dec 2004 11:19:32 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hello!</P>
<P>Have you compiled Bluez-Libs first?</P>
<P>Have you modified the source code?</P>
<P>Regards!<BR><BR></P></DIV>
<DIV></DIV>&gt;From: CoCozZ geek &lt;cocozz@gmail.com&gt;
<DIV></DIV>&gt;Reply-To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;Subject: [Bluez-users] Error when compiling bluez-utils
<DIV></DIV>&gt;Date: Fri, 24 Dec 2004 11:13:47 +0100
<DIV></DIV>&gt;
<DIV></DIV>&gt;I get those errors when I compile bluez-utils ... using
<DIV></DIV>&gt;2.6.8-gentoo-r10 and gcc (GCC) 3.3.4 20040623.
<DIV></DIV>&gt;
<DIV></DIV>&gt;Thanks :)
<DIV></DIV>&gt;
<DIV></DIV>&gt;gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp;&nbsp;-I/usr/include&nbsp;&nbsp;-I/usr/include
<DIV></DIV>&gt;-march=pentium4 -O3 -pipe -fomit-frame-pointer -c `test -f
<DIV></DIV>&gt;'hcisecfilter.c' || echo './'`hcisecfilter.c
<DIV></DIV>&gt;sdptool.c: In function `add_handsfree':
<DIV></DIV>&gt;sdptool.c:1130: error: `HANDSFREE_SVCLASS_ID' undeclared (first use in
<DIV></DIV>&gt;this function)
<DIV></DIV>&gt;sdptool.c:1130: error: (Each undeclared identifier is reported only once
<DIV></DIV>&gt;sdptool.c:1130: error: for each function it appears in.)
<DIV></DIV>&gt;sdptool.c:1136: error: `HANDSFREE_PROFILE_ID' undeclared (first use in
<DIV></DIV>&gt;this function)
<DIV></DIV>&gt;sdptool.c:1152: error: `SDP_SUPPORTED_FEATURES' undeclared (first use
<DIV></DIV>&gt;in this function)
<DIV></DIV>&gt;sdptool.c: In function `add_audio_source':
<DIV></DIV>&gt;sdptool.c:1583: error: `AUDIO_SOURCE_SVCLASS_ID' undeclared (first use
<DIV></DIV>&gt;in this function)
<DIV></DIV>&gt;sdptool.c:1587: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
<DIV></DIV>&gt;use in this function)sdptool.c:1598: error: `AVDTP_UUID' undeclared
<DIV></DIV>&gt;(first use in this function)
<DIV></DIV>&gt;sdptool.c: In function `add_audio_sink':
<DIV></DIV>&gt;sdptool.c:1642: error: `AUDIO_SINK_SVCLASS_ID' undeclared (first use
<DIV></DIV>&gt;in this function)
<DIV></DIV>&gt;sdptool.c:1646: error: `ADVANCED_AUDIO_PROFILE_ID' undeclared (first
<DIV></DIV>&gt;use in this function)sdptool.c:1657: error: `AVDTP_UUID' undeclared
<DIV></DIV>&gt;(first use in this function)
<DIV></DIV>&gt;sdptool.c: At top level:
<DIV></DIV>&gt;sdptool.c:1697: error: `HANDSFREE_SVCLASS_ID' undeclared here (not in
<DIV></DIV>&gt;a function)
<DIV></DIV>&gt;sdptool.c:1697: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1697: error: (near initialization for `service[7].class')
<DIV></DIV>&gt;sdptool.c:1697: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1697: error: (near initialization for `service[7]')
<DIV></DIV>&gt;sdptool.c:1699: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1699: error: (near initialization for `service[8]')
<DIV></DIV>&gt;sdptool.c:1700: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1700: error: (near initialization for `service[9]')
<DIV></DIV>&gt;sdptool.c:1702: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1702: error: (near initialization for `service[10]')
<DIV></DIV>&gt;sdptool.c:1703: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1703: error: (near initialization for `service[11]')
<DIV></DIV>&gt;sdptool.c:1704: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1704: error: (near initialization for `service[12]')
<DIV></DIV>&gt;sdptool.c:1706: error: `AUDIO_SOURCE_SVCLASS_ID' undeclared here (not
<DIV></DIV>&gt;in a function)gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp;&nbsp;-I/usr/include
<DIV></DIV>&gt;-I/usr/include -march=pentium4 -O3 -pipe -fomit-frame-pointer -c `test
<DIV></DIV>&gt;-f 'hciattach.c' || echo './'`hciattach.c
<DIV></DIV>&gt;sdptool.c:1706: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1706: error: (near initialization for `service[13].class')
<DIV></DIV>&gt;sdptool.c:1706: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1706: error: (near initialization for `service[13]')
<DIV></DIV>&gt;sdptool.c:1707: error: `AUDIO_SINK_SVCLASS_ID' undeclared here (not in
<DIV></DIV>&gt;a function)
<DIV></DIV>&gt;sdptool.c:1707: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1707: error: (near initialization for `service[14].class')
<DIV></DIV>&gt;sdptool.c:1707: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1707: error: (near initialization for `service[14]')
<DIV></DIV>&gt;sdptool.c:1709: error: initializer element is not constant
<DIV></DIV>&gt;sdptool.c:1709: error: (near initialization for `service[15]')
<DIV></DIV>&gt;make[2]: *** [sdptool.o] Error 1
<DIV></DIV>&gt;make[2]: *** Waiting for unfinished jobs....
<DIV></DIV>&gt;make[2]: Leaving directory
<DIV></DIV>&gt;`/var/tmp/portage/bluez-utils-2.10-r1/work/bluez-utils-2.10/tools'make[1]:
<DIV></DIV>&gt;*** [all-recursive] Error 1
<DIV></DIV>&gt;make[1]: Leaving directory
<DIV></DIV>&gt;`/var/tmp/portage/bluez-utils-2.10-r1/work/bluez-utils-2.10'
<DIV></DIV>&gt;make: *** [all] Error 2
<DIV></DIV>&gt;
<DIV></DIV>&gt;!!! ERROR: net-wireless/bluez-utils-2.10-r1 failed.
<DIV></DIV>&gt;!!! Function src_compile, Line 53, Exitcode 2
<DIV></DIV>&gt;!!! (no error message)
<DIV></DIV>&gt;!!! If you need support, post the topmost build error, NOT this status message.
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;-------------------------------------------------------
<DIV></DIV>&gt;SF email is sponsored by - The IT Product Guide
<DIV></DIV>&gt;Read honest &amp; candid reviews on hundreds of IT Products from real users.
<DIV></DIV>&gt;Discover which products truly live up to the hype. Start reading now.
<DIV></DIV>&gt;http://productguide.itmanagersjournal.com/
<DIV></DIV>&gt;_______________________________________________
<DIV></DIV>&gt;Bluez-users mailing list
<DIV></DIV>&gt;Bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users
<DIV></DIV></div></html>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
