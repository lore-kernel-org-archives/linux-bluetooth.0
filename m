Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D84DD2.7020102@palmsource.com>
Date: Tue, 08 Aug 2006 10:39:46 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673D7AC4E@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673D7AC4E@GBMDDMH202AMSX.gb001.siemens.net>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX)
 plus	xmmserror(trials and tribulations) how cool is this!!! new patch
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

Hi Andrew,

By lock solid do you mean system freeze or a 100% cpu time? Does your =

mouse move? Do capslock & numlock still light on/off?
When you start it as a daemon, how do you do it? Is it from a =

shell/rootshell/startup script/sysinit?
Are you sure that you have not attempted to use headset, it is not your =

default alsa plugin, and you have not started xmms. If it is default, =

another application could have started sound.


Since we only work in user mode, we should not lock solid the system!  I =

used to consider this assumption valid when I was a Windows programmer =

so it should be under linux :D ...

This reminds me the lock problem that was signaled last week, Look at =

this thread:
http://sourceforge.net/mailarchive/forum.php?thread_id=3D29109531&forum_id=
=3D1881

It said :

 After upgrading I discovered that my machine freezes after being left
 idle for approximately 30 min.

...
this looks like a problem with the kthread API. We converted BNEP, CMTP

 and HIDP to it with 2.6.17-mh3. So a 2.6.17-mh2 kernel should work
 without any problems.

If you have unbuntu, you will certainly have multiple kernel to boot, =

can you try an older one to see if it is the same.


Moreover, I confirm that the log file is filed while in daemon mode. =

Maybe the daemon is started before /tmp is mounted. Try another =

location, simply add

logfile=3D/what_you_want_but_you_need_write_permission

to the config file before startup.


Fr=E9d=E9ric



Waldram, Andrew (SBS UK) a =E9crit :

> =

>Still have the issue were if I start it as a deamon (a2dpd -d +v) then aft=
er about 30 minutes my system just locks solid
>
>This only happenes if you have no connection i.e the deamon is started but=
 you have not attempted to use headset.
>
>I thought initialy it was loging but after you've added the logging code g=
uess not.
>
>Got no idea how to debug this as nothing  appears in any log it just locks=
 solid.
>
>
>--------------------------------------------------------------------------=
-------- =

>
>
>-----Original Message-----
>From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounce=
s@lists.sourceforge.net] On Behalf Of Waldram, Andrew (SBS UK)
>Sent: 05 August 2006 16:03
>To: BlueZ development
>Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmmserror(t=
rials and tribulations) how cool is this!!! new patch
>
>Hi again =

>
>It's permissions needed to start a2dp as sudo -u andy -H a2dpd =

>Else xmms and the controls didn't synchronise (had extra xmms sesions appe=
aring )
>
>Now seems pretty slick =

>
>Will continue to play and report back later after day to day use..
>--------------------------------------------------------------------------=
-------- =

>
>-----Original Message-----
>From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounce=
s@lists.sourceforge.net] On Behalf Of Waldram, Andrew (SBS UK)
>Sent: 05 August 2006 14:55
>To: BlueZ development
>Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error(=
trials and tribulations) how cool is this!!! new patch
>
> Hi
>
>Don't know if its my headphones but pressing play does not start xmms.
>
>If I manuly start Xmms then fwd rev play pause work
>
>But still once 10 secs has done then pressinf play on the headphones does =
nothing and if I press play on xmms it still just doesn't work
>
>Accepting incoming tcp stream connection
>[pause] xmms --pause
>Forked xmms --pause         <----------------------Pause press ;-)
>[1] Receiving failed on socket 0.6 error (-1/4 bytes) errno=3D11:Resource
>temporarily unavailable  <---------------------  press play repeatedly on =
head phones nothing happens
>Client thread 0.6 ending: timeout =

>Destroying lpA2dp, destroy_count is 2001
>DEBUG: a2dp_destroy: Begin
>DEBUG: a2dp_free: Begin
>DEBUG: a2dp_destroy: a2dp_destroy(0x80561f0) OK
>avrcp: socket 9: timed out
>Accepted 6
>PCM thread 0.6 started  < ------------------------------ press play on xmm=
s =

>DEBUG: a2dp_new: Begin
>DEBUG: a2dp_new: bdaddr/dest is 00:0D:44:2A:5C:12
>DEBUG: a2dp_alloc: Begin
>DEBUG: a2dp_connect: a2dp 0x8076d58
>DEBUG: connect_stream: Begin
>DEBUG: connect_stream: Using address: 12:5C:2A:44:0D:00
>DEBUG: detect_a2dp: Begin
>Accepting incoming tcp stream connection
>DEBUG: detect_a2dp: Found A2DP Sink
>DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=3D25)
>DEBUG: do_connect: Begin
>DEBUG: do_connect: Connecting to bluetooth
>DEBUG: do_connect: (errno=3D111:Connection refused)Can't connect to
>12:5C:2A:44:0D:00 on psm 25. Connection refused(111)
>DEBUG: do_connect: (errno=3D77:File descriptor in bad state)Can't connect =
to
>12:5C:2A:44:0D:00 on psm 25. File descriptor in bad state(77)
>DEBUG: do_connect: (errno=3D77:File descriptor in bad state)Can't connect =
to
>12:5C:2A:44:0D:00 on psm 25. File descriptor in bad state(77)
>DEBUG: connect_stream: cannot open psm_cmd =3D 25
>
>Any ideas
>
>
>--------------------------------------------------------------------------=
-------- =

>
>
>-----Original Message-----
>From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounce=
s@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
>Sent: 04 August 2006 16:09
>To: BlueZ development
>Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error =
(trials and tribulations) how cool is this!!! new patch
>
>Hi all,
>
>Now the a2dpd handles avrcp too. Only play / pause / next / prev but =

>other commands if any should go straight away.
>
>Waldram, Andrew (SBS UK) a =E9crit :
>
>  =

>
>>When you say you integrated it into a2dpd do you mean all the a2recv stuf=
f, if so doean't that make the deamon a xmms dependant tool?
>> =

>>
>>    =

>>
>No thanks to the config file
>
>  =

>
>>It'd be real cool if it'd parse a config file so something like the follo=
wing could be done
>>
>>/etc/a2dpd.conf
>> =

>>
>>    =

>>
>done, see attachment
>$HOME/.a2dprc for now
>
>  =

>
>>For now, it is not yet handled but you see the daemon receive a frame of =

>>the form 0x00 0x01 (AVDTP_DISCOVER).
>>I will try today reject the frame and system(xmms --play).
>> =

>>
>>    =

>>
>done, see patch
>
>Two commands line options appeared:
>-d forks (+d no fork) on startup
>-v redirect output to stdout (+v to logfile specified in rc def : =

>/tmp/a2dpd.log)
>
>If your headset is avrcp, what can you do :
>start a2dpd
>press play on the headset, and it will start up xmms. You should hear music
>press play again, it will pause xmms.
>press play again, music restart.
>press next or prev to switch song.
>
>you can also try alsamixer -D ctl.a2dpd
>
>Fr=E9d=E9ric
>
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
>
>-------------------------------------------------------------------------
>Using Tomcat but need to do more? Need to support web services, security?
>Get stuff done quickly with pre-integrated technology to make your job eas=
ier
>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  =

>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
