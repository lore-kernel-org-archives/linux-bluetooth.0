Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 10 Aug 2006 08:53:40 +0100
Message-ID: <056BF200E9632F4285220E570FEED673DBCA31@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673DBC1DC@GBMDDMH202AMSX.gb001.siemens.net>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pd btsco
	won'tcompile	(FIX)	plus	xmmserror(trials and tribulations)
	howcool is	this!!!	new patch
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

Hi  Fr=E9d=E9ric,

First good news your patch does fix the lock extensive testing (sit and wai=
t) and no locks.

Then the not so good avrcp seems very flaky now =


Symptoms

Start a2dpd =


read_config_string: [a2dpd] 'address'=3D'00:0D:44:2A:5C:12'
read_config_string: [a2dpd] 'cmdplay'=3D'xmms --play'
read_config_string: [a2dpd] 'cmdpause'=3D'xmms --pause'
read_config_string: [a2dpd] 'cmdprev'=3D'xmms --rew'
read_config_string: [a2dpd] 'cmdnext'=3D'xmms --fwd'
read_config_string: [a2dpd] 'cmdnew'=3D'xmms --play'
read_config_string: [a2dpd] 'logfile'=3D'/tmp/a2dpd.log'
a2dpd [Aug  9 2006 18:10:25] starting .../usr/bin/a2dpd
addr=3D00:0D:44:2A:5C:12 timer=3D4000 us [Aug  9 2006 18:10:25]
setscheduler returns 0 (errno=3D0:Success)
Accepting incoming tcp stream connection
New connection to bluetooth
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection

Press play nothing happens at all it as if the laptops not listening at all=
 for connections from headphone

Ok the resart a2dpd and the xmms the headphones =


Music plays....

Skip forward and back both OK
Pause < 10 secs OK
Pause > 10 secs 1 in 3 works (seems strange that as I'd have thought it'd w=
ork or not work).

avrcp: socket 9: Connection from 12:5C:2A:44:0D:00, mtu=3D672
[pause] xmms --pause
Forked xmms --pause
[1] Receiving failed on socket 0.6 error (-1/4 bytes) errno=3D11:Resource
temporarily unavailable
Client thread 0.6 ending: timeout
Destroying lpA2dp, destroy_count is 2001
DEBUG: a2dp_destroy: Begin
DEBUG: a2dp_free: Begin
DEBUG: a2dp_destroy: a2dp_destroy(0x8055fe8) OK
avrcp: socket 9: timed out

Pressing play now does nothing (sometimes)


This is a regression from your previous patch where pause always worked and=
 pressing play on the headphones started xmms if it wasn't running.

Andy


---------------------------------------------------------------------------=
------- =





-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Waldram, Andrew (SBS UK)
Sent: 09 August 2006 08:42
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won'tcompile (FIX) plus xmmserror(tri=
als and tribulations) howcool is this!!! new patch

 Hi,

I'll have to try the new patch tonight I missed you yesterday by 30 minutes

Didn't think to check my work mail from home as didn't expect you to come u=
p with something to test so quick.

I tested multiple kernels =


2.6.14 - stock =

2.6.15 - Ubuntu
2.6.16 - Custom -> modded to allow non standard dtv card to function.

All showed the same symtoms 30 minutes locked
I ran top and when locked the cpu was showing 6.6% might've been top to slo=
w to react
The laptop wasn't warm to touch so it looks to me that if it is the overflo=
w then my Machines dyes ;-) as soon as resources vanish. =




---------------------------------------------------------------------------=
------- =





-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 08 August 2006 17:37
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmmserror(tr=
ials and tribulations) how cool is this!!! new patch


Hi, I put the patch online as I have no time to test it tonight but it =

should be ok if you wana try.
Will post a real one tomorrow when tested..

http://fdalleau.free.fr/patch_to_try

>Sounds like you've got a handle on the issue though.
>
>It's not patience but gratitude for all your hard work ;-)
>  =

>
Don't worry too much, I get paid for that!

Fr=E9d=E9ric.

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
