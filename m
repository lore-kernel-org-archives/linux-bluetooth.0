Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sat, 12 Aug 2006 10:31:43 +0100
Message-ID: <056BF200E9632F4285220E570FEED673DF41C2@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673DF3B3B@GBMDDMH202AMSX.gb001.siemens.net>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pdbtsco	won'tcompile	(FIX)	plus	xmmserror(trials
	andtribulations)	howcool is	this!!!	new patch
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

Sorry for the length but I have snipped out the chaf??
 =

from starting a2dpd session 2 play press's

HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0x400
> AVDTP(s): Discover cmd: transaction 0
< AVDTP(s): Discover rej: transaction 0
    Error code 6
> AVDTP(s): Discover cmd: transaction 0
< AVDTP(s): Discover rej: transaction 0
    Error code 6


no Xmms no sound ;-(
start xmms manualy press play on xmms
play -> pause wait 15 secs play (repeatedly no response)


< AVDTP(m): ver 2 cc 0 pt 1 seqn 994 time 2430864 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 995 time 2433312 ssrc 1
< AVDTP(s): Close cmd: transaction 5
    ACP SEID 1
< AVDTP(m): ver 1 ext cc 0 pt 8 seqn 1251 time 2433312 ssrc 1
> AVDTP(s): Close rsp: transaction 5


play (repeatedly no response)
press stop on xmms the play on xmms


< AVDTP(m): ver 1 pad cc 0 pt 1 seqn 1536 time 1090519040 ssrc 65535
> AVDTP(s): Discover rsp: transaction 6
    ACP SEID 1 - Audio Sink
< AVDTP(m): ver 1 pad ext cc 0 pt 2 seqn 1032 time 1090519040 ssrc 65535
> AVDTP(s): Capabilities rsp: transaction 7
    Media Transport
    Media Codec - SBC
      32kHz 44.1kHz 48kHz
      Mono DualChannel Stereo JointStereo
      4 8 12 16 Blocks
      4 8 Subbands
      SNR Loudness
      Bitpool Range 2-250
< AVDTP(m): ver 2 cc 0 pt 3 seqn 1028 time 16779014 ssrc 8726
> AVDTP(s): Set config rsp: transaction 8
< AVDTP(m): ver 2 ext cc 0 pt 6 seqn 1028 time 16779014 ssrc 8726
> AVDTP(s): Open rsp: transaction 9
< AVDTP(m): ver 2 pad cc 0 pt 7 seqn 1024 time 1107313664 ssrc 0
> AVDTP(s): Start rsp: transaction 10


Strangley the streams I had before do not occur but music plays??
skip and pause<15 sec play work but nothing now gets added to the output (h=
ave
we changed thread ????
Press pause >15 =


< AVDTP(m): ver 2 pad ext cc 0 pt 8 seqn 1102 time 20869200 ssrc 1
> AVDTP(s): Close rsp: transaction 11

press play again

> AVDTP(s): Discover cmd: transaction 0
< AVDTP(s): Discover rej: transaction 0
    Error code 6
< AVDTP(s): Discover cmd: transaction 12
> AVDTP(s): Discover rsp: transaction 12
    ACP SEID 1 - Audio Sink
< AVDTP(s): Capabilities cmd: transaction 13
    ACP SEID 1
> AVDTP(s): Capabilities rsp: transaction 13
    Media Transport
    Media Codec - SBC
      32kHz 44.1kHz 48kHz
      Mono DualChannel Stereo JointStereo
      4 8 12 16 Blocks
      4 8 Subbands
      SNR Loudness
      Bitpool Range 2-250
< AVDTP(s): Set config cmd: transaction 14
    ACP SEID 1 - INT SEID 1
    Media Transport
    Media Codec - SBC
      44.1kHz
      Stereo
      16 Blocks
      8 Subbands
      SNR
      Bitpool Range 2-250
> AVDTP(s): Set config rsp: transaction 14
< AVDTP(s): Open cmd: transaction 15
    ACP SEID 1
> AVDTP(s): Open rsp: transaction 15
< AVDTP(s): Start cmd: transaction 0
    ACP SEID 1
> AVDTP(s): Start rsp: transaction 0
< AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 0 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 2 time 2448 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 3 time 4896 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 4 time 7344 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 5 time 9792 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 6 time 12240 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 7 time 14688 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 8 time 17136 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 9 time 19584 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 10 time 22032 ssrc 1
< AVDTP(m): ver 2 cc 0 pt 1 seqn 11 time 24480 ssrc 1

Whoo hoo worked this time !!!!!
Now it shows streams again ????? weird
well think thats got it

start play not working
pause > 15 sec failing
pause > 15 sec working



---------------------------------------------------------------------------=
------- =



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Waldram, Andrew (SBS UK)
Sent: 11 August 2006 08:53
To: BlueZ development
Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(tria=
ls andtribulations) howcool is this!!! new patch

I'll give it a spin this evenning =

'Are you sure the previous patch was so good ??? :D'
Nah the new ones better found it difilcult to play sound on locked machine =
;-)

---------------------------------------------------------------------------=
------- =





-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 10 August 2006 17:05
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won'tcompile (FIX) plus xmmserror(tri=
als and tribulations) howcool is this!!! new patch

Hi Andrew;

>First good news your patch does fix the lock extensive testing (sit and wa=
it) and no locks.
>  =

>
This patch correct an integer overflow, if it is not heat, maybe the =

overflow does something in the kernel?
In any case, it is better to have it corrected.

>Then the not so good avrcp seems very flaky now =

>  =

>
Looking to traces, it seems that I do not received any data.
hcidump could help us to see what happens at bluez level.
Try hcidump first to see if you receive a packet. Be very fast I only =

need a few first line, and you'll be flooded when sound start
use it like that : sudo hcidump AVDTP

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0x400
 > AVDTP(s): Discover cmd: transaction 0
< AVDTP(s): Discover rej: transaction 0

This is what the headset sends us :
 > AVDTP(s): Discover cmd: transaction 0

This is what we answer :
< AVDTP(s): Discover rej: transaction 0

Then music should start.

>This is a regression from your previous patch where pause always worked an=
d pressing play on the headphones started xmms if it wasn't running.
>  =

>
Are you sure the previous patch was so good ??? :D

Fr=E9d=E9ric


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
