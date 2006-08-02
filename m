Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D0BCA5.5000906@palmsource.com>
Date: Wed, 02 Aug 2006 16:54:29 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
	<44D0B1F7.2@xmission.com>
In-Reply-To: <44D0B1F7.2@xmission.com>
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

HI brad,

>Is the memory footprint acceptable when introducing the alsa dependency
>on your embedded platform? In my experience lib-alsa itself builds to
>about 800KB on arm. The difference in cpu load is probably negligible.
>
>  =

>
Depends on what you need, at first I wanted to see how small it could be.
I had similar result by dropping alsa link from the daemon saved me a =

bit less than 1Mb ram usage as opposed to 2.6 with alsa or something =

like that.
-rwxr-xr-x    1   100   100       1188601 Jul 26  2006 =

/usr/lib/libasound.so.2.0.0

Do you min memory or disk footprint? As the daemon did not need alsa at =

all, it was one free megabit! But this may change one day ...

Is it related to the build problem Andrew had? If so I think the linking =

can be put back for now. I will do it manually if I really need it...

Fr=E9d=E9ric


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
