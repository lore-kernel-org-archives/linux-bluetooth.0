Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 1 Aug 2006 13:39:14 +0100
Message-ID: <056BF200E9632F4285220E570FEED673D03062@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44CF1714.2070300@palmsource.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error
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

 Thanks for the advice really appreciate it.

As stated if I add =


a2dpd_CFLAGS =3D $(AM_CFLAGS)

That clears the issue for me (.bootstrap was failing at the errors so .conf=
igure never ran so bust (ubuntu 6.06 (mildly modded kernel))

Your right the a2dpd does not appear to suffer in xmms (thankyou)

Am I right in assuming there is more development work going on with this pl=
uggin than the other ??

Maybe the build doc in the plugin directory needs updating ???

As this is set as the default plugin can I just change the name in .asoundr=
c  and then select it in the app I choose to use ???
This would allow all other apps to use the default device (soundcard)


---------------------------------------------------------------------------=
------- =





-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 01 August 2006 09:56
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error


Andrew, I must add that you have to use the latest cvs. But of course =

you do!

Brad, are you scheduling a release soon?

Fr=E9d=E9ric.


Fr=E9d=E9ric DALLEAU a =E9crit :

>Hi,
>
>I use xmms everyday. Have a look at a2dpd. It's an alternative a2dp =

>plugin and a daemon. You'll easily set it up and you can find =

>documentation here :
>    =

>http://sourceforge.net/mailarchive/forum.php?thread_id=3D20199009&forum_id=
=3D1881
>
>For your compilation problem,  I used to get a warning about
>    `LIBS' previously defined here
>and one with
>    alsa-plugins/Makefile.am: object `a2dp_timer.$(OBJEXT)' created both =

>with libtool and without
>    alsa-plugins/Makefile.am: object `a2dp_ipc.$(OBJEXT)' created both =

>with libtool and without
>
>I added
>    a2dpd_CFLAGS =3D -pthread
>which removed the second warning...
>
>But these are only warnings which should not break compilation. As I =

>cannot reproduce your problem (ubuntu 5.1), could you please give us =

>full compiler output. This will allow for easier debbuging.
>
>Let us know about your success,
>Fr=E9d=E9ric.
>
>
>
>Andrew Waldram a =E9crit :
>
>  =

>
>>Hi guys ,
>>
>>Sorry this is a bit noddy but I'm not a developer
>>
>>the latest changes to a2pd plugin stop btsco compiling as your trying to
>>re-use variables.
>>
>>Adding
>>
>>bin_PROGRAMS =3D a2dpd
>>a2dpd_SOURCES =3D a2dpd.c a2dplib.c a2dp_timer.c a2dp_ipc.c
>>----->>>>> a2dpd_CFLAGS =3D $(AM_CFLAGS)
>>
>>to the makefile.am in the pluggin filder will fix it by renaming the
>>variable timer and icp during compile time, =

>>
>>it almost a no-op just fixes the compiler dont know if thats the right
>>way to do it though.
>>
>>Also when I use XMMS with my HP bluetooth headphones then every time a
>>track finishes the the headphones stop (next also does this), but
>>alsaplayer is fine.
>>
>>here is whats happening during skip
>>
>>SBC Bandwidth =3D 26 kbps [26703 bps]
>>SBC Bandwidth =3D 26 kbps [27324 bps]
>>SBC Bandwidth =3D 26 kbps [27324 bps]
>>Awaiting command
>>SBC Bandwidth =3D 26 kbps [27324 bps]
>>SBC Bandwidth =3D 26 kbps [27324 bps]
>>DEBUG: a2dp_stop: a2dp 0x82668d8
>>DEBUG: a2dp_stop: Listen thread terminating
>>Thread in signal handler 14
>>Error while receiving -1 (errno=3D4:Interrupted system call)
>>listen_thread: ending perfeclty
>>DEBUG: a2dp_stop: Listen thread terminated
>>DEBUG: a2dp_stop: OK
>>DEBUG: a2dp_stop: a2dp 0x82668d8
>>DEBUG: a2dp_stop: Listen thread terminating
>>DEBUG: a2dp_stop: Listen thread terminated
>>DEBUG: a2dp_stop: OK
>>DEBUG: a2dp_close: a2dp Destroying 0x82668d8
>>DEBUG: a2dp_close: OK
>>DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 1
>>DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:2A:5C:12
>>DEBUG: a2dp_constraint: TEST a2dp 0x82668d8
>>DEBUG: a2dp_params: a2dp 0x82668d8
>>DEBUG: a2dp_params: format S16_LE rate 44100 channels 2
>>DEBUG: a2dp_params: frame_bytes 4 period_bytes 8192 period_size 2048
>>buffer_size 4096
>>DEBUG: a2dp_prepare: a2dp 0x82668d8
>>SBC Bandwidth =3D 19 kbps [19872 bps]
>>SBC Bandwidth =3D 26 kbps [26703 bps]
>>SBC Bandwidth =3D 26 kbps [26703 bps]
>>
>>Yet it doesn't start playing again , but restarting xmms start sound
>>again
>>
>>
>>-------------------------------------------------------------------------
>>Take Surveys. Earn Cash. Influence the Future of IT
>>Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
>>opinions on IT & business topics through brief surveys -- and earn cash
>>http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>> =

>>
>>    =

>>
>
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share yo=
ur
>opinions on IT & business topics through brief surveys -- and earn cash
>http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DD=
EVDEV
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  =

>


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
