Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7ff566830701151639u5d62348dx4042e23361f028b1@mail.gmail.com>
Date: Mon, 15 Jan 2007 19:39:18 -0500
From: "Kelly Price" <strredwolf@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Build problem with plugz
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I'm having a problem compiling plugz:

gcc -DHAVE_CONFIG_H -I. -I../..     -Wall -O2 -MT states.o -MD -MP -MF
.deps/states.Tpo -c -o states.o states.c
states.c: In function 'headsetIdleHandleApplConnReq':
states.c:300: error: 'SDP_NON_BLOCKING' undeclared (first use in this function)
states.c:300: error: (Each undeclared identifier is reported only once
states.c:300: error: for each function it appears in.)
make[3]: *** [states.o] Error 1

This was after the CVS pull.  I'm building on Gentoo, kernel 2.6.19.2.

-- 
Kelly "STrRedWolf" Price
http://strredwolf.furrynet.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
