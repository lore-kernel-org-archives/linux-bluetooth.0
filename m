Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 18 Aug 2006 09:33:19 +0100
Message-ID: <056BF200E9632F4285220E570FEED673E7FA81@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44E477EB.4060000@xmission.com>
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

 =

Fr=E9d=E9ric

Tried everything you sugested still the same play from start will not start=
 xmms (mormaly see below) and pressing pause wait 15 sec then play results =
in nothing. I would say it was my headphones but it did work from avrcp and=
 your first patch.

Hcidump does show the press's but a2dpd does not show anything at all just =
sits waiting incomming connection.

After repeated tries I did get it once to start xmms (output follows) so I'=
m confident my configuration is correct (could it be timming/parsing blueto=
oth response)

The logs look a little  strange and it doesn't work 99.9% of the time =


I've put markers where I think something may be wrong can you think of anyt=
hing else I can tru to pin this down (so close yet so far).

On a plus note your latest patches seem to have reduced the latency for ski=
p forward and back .

 Accepting incoming tcp stream connection
New connection to bluetooth [44100 hz]
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection
avdtp: socket 7: Connection from 12:5C:2A:44:0D:00, mtu=3D672
avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
temporarily unavailable)<--------------------------------------------------=
-----
avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
temporarily unavailable)<--------------------------------------------------=
-----
socket 7: Received 2 bytes
00000: 00 01
DEBUG: a2dp_handle_avdtp_message: (errno=3D11:Resource temporarily
unavailable)Unexpected headset directive 1  <------------------------------=
-------------------------
DEBUG: a2dp_handle_avdtp_message: Answering command packet
(msgtype=3DMESSAGE_TYPE_REJECT,signal=3D1)
avdtp: socket 7: Received frame, start xmms --play
avdtp: socket 7: timed out
Forked xmms --play
Message: device: pcm.a2dpd
immsd: version 3.0.1 ready...
DEBUG: _snd_pcm_a2dpd_open: (errno=3D0:Success)name pcm.a2dpd mode 1
DEBUG: a2dp_alloc: (errno=3D0:Success)Init
DEBUG: a2dp_alloc: (errno=3D0:Success)OK
DEBUG: a2dp_params: (errno=3D0:Success)a2dp 0x8295e18
DEBUG: a2dp_params: (errno=3D0:Success)format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: (errno=3D0:Success)frame_bytes 4 period_bytes 8192
period_size 2048 buffer_size 4096
DEBUG: a2dp_prepare: (errno=3D0:Success)a2dp 0x8295e18
Accepted 7
PCM thread 0.7 started
Accepting incoming tcp stream connection
DEBUG: a2dp_new: Begin
DEBUG: a2dp_new: bdaddr/dest is 00:0D:44:2A:5C:12
DEBUG: a2dp_alloc: Begin
DEBUG: a2dp_connect: a2dp 0x8057810
DEBUG: connect_stream: Begin
DEBUG: connect_stream: Using address: 12:5C:2A:44:0D:00
DEBUG: detect_a2dp: Begin

---------------------------------------------------------------------------=
------- =


-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Brad Midgley
Sent: 17 August 2006 15:07
To: BlueZ development
Subject: Re: [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus xmmserror(tria=
ls andtribulations) howcool is this!!! new patch

Fr=E9d=E9ric

> Try to use the latest patch http://fdalleau.free.fr/patch_to_try
> Minor changes has been done. It worked all night long!

FYI I just applied this.

Brad

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
