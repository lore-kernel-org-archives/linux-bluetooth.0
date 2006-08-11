Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 11 Aug 2006 08:53:01 +0100
Message-ID: <056BF200E9632F4285220E570FEED673DF3B3B@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44DB5935.6050608@palmsource.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pd
	btsco	won'tcompile	(FIX)	plus	xmmserror(trials and
	tribulations)	howcool is	this!!!	new patch
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
