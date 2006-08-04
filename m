Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 4 Aug 2006 09:46:31 +0100
Message-ID: <056BF200E9632F4285220E570FEED673D3B631@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44D2FF72.6050309@palmsource.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error
	(trials and tribulations) how cool is this!!!
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

Hi,

Glad it worked for you =


Thought it was something along those lines as the button press did cause a =
response.

I followed you up until

 "I will try today reject the frame and system(xmms --play)."

Don't understand are your saying you'll handle the call by issuing xmms -- =
play so the links recreated from the PC end ??

Or try and handle the call and create the link from a2dp headset initiated =
conextion??

Must admit you guys rock I tried this stuff 6-8 months ago and nothing work=
ed now it all works (a bit of spit and polish required) but definitely work=
s.

Watch out UWB ;-)

When you say you integrated it into a2dpd do you mean all the a2recv stuff,=
 if so doean't that make the deamon a xmms dependant tool?

It'd be real cool if it'd parse a config file so something like the followi=
ng could be done

/etc/a2dpd.conf

Device 00:0D:44:2A:5C:12
Play xmms -p
Pause xmms -p
........etc

This way any app could be catered for

Please ignore the capitals Outlook being an arse !!!


---------------------------------------------------------------------------=
------- =


SIEMENS =

Andrew Waldram
Technical Implementations Group =

Server Specialist - South =


*  Tel: +44 (0) 1344 396619
*  Mob: +44 (0) 7808 827469
*   Fax: +44 (0) 1344 358056 =

* Email:  Andrew.waldram@siemens.com =


This e-mail contains confidential information and is for the exclusive use =
of the addressee/s. If you are not the addressee, then any distribution, co=
pying or use of this e-mail is prohibited. If received in error, please adv=
ise the sender and delete it immediately. We accept no liability for any lo=
ss or damage suffered by any person arising from use of this e-mail. =


Siemens Business Services Limited =


Registered No: 1203466 England =

Registered Office: Siemens House, Oldbury, Bracknell, Berkshire, RG12 8FZ =



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces=
@lists.sourceforge.net] On Behalf Of Fr=E9d=E9ric DALLEAU
Sent: 04 August 2006 09:04
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error (=
trials and tribulations) how cool is this!!!

Hi,
Until today I've not even tried anything avrcp related.
I then executed your script and for my pleasure, it worked.
I patched a bit and integrated everything in a2dpd.

Now, the 10 seconds delay correspond to the delay used by a2dpd to close =

the bluetooth stream. No sound will disconnect bluetooth.

When after that you press the play button, you create an a2dp headset =

initiated connexion.
For now, it is not yet handled but you see the daemon receive a frame of =

the form 0x00 0x01 (AVDTP_DISCOVER).
I will try today reject the frame and system(xmms --play).

Fr=E9d=E9ric.


Waldram, Andrew (SBS UK) a =E9crit :

>Just thought I'd let you know of my success's and problems with my HP
>blutooth headphones (a2dpd & avrcp) and broadcom bcm2045 dongle
>
>Modified acrecv.c replacing the printk's with appropiate system("xmms
>-s") comands recompiled
>
>Ran this script
>
> #!/bin/sh -e
>#
># BTXMMS
>#
>
>sdptool add AVRTG
>
>
>if [ -x /usr/bin/a2dpd ]; then
>	/home/andy/blueheadphones/avrecv &
>	vlc &
>	xmms &
>	/usr/bin/a2dpd 00:0D:44:2A:5C:12 =

>fi
># fi
>			=

>
>exit 0
>
>Pressed play on the screen and sound in all it's beauty came from my
>speakers (this wasn't new) then press next on the headphones and viola
>the track jumped forward same for back and pause.
>
>Then the fly in the ointment
>
>If you press pause (either on xmms or headphones) wait 10 secs then
>press play again on headphones it appears the heaphones recreate a avrcp
>connection but no a2dpd (bugger bugger bugger) the only way out of this
>is switch off the headphones and restart.
>
>This is the log output
>
>PCM thread 0.5 started after
>DEBUG: a2dp_params: (errno=3D0:Success)a2dp 0x821d4e8
>DEBUG: a2dp_params: (errno=3D0:Success)format S16_LE rate 44100 channels 2
>DEBUG: a2dp_params: (errno=3D0:Success)frame_bytes 4 period_bytes 8192
>period_size 2048 buffer_size 4096
>DEBUG: a2dp_prepare: (errno=3D0:Success)a2dp 0x821d4e8
>Accepting incoming stream connection
>DEBUG: a2dp_prepare: (errno=3D4:Interrupted system call)a2dp 0x821d4e8
><--------------- PAUSE Pressed
>[1] Receiving failed on socket 0.5 error (-1/4 bytes) errno=3D11:Resource
>temporarily unavailable
>Client thread 0.5 ending: timeout
>Destroying lpA2dp, destroy_count is 5001
>DEBUG: a2dp_destroy: Begin
>DEBUG: a2dp_free: Begin
>DEBUG: a2dp_destroy: a2dp_destroy(0x8053090) OK
>Connectedreceived 0 bytes:
>
>transaction_label =3D 0
>packet_type =3D 0
>cr =3D 1
>ipid =3D 0
>pid =3D e11
>zeroes =3D 0
>ctype =3D 9
>subunit_type =3D 9
>subunit_id =3D 0
>opcode =3D 7c
>operand0 =3D 4b
>operand1 =3D 0
>accepting next connection
>DEBUG: a2dp_wait_connection: Begin
>DEBUG: a2dp_wait_connection: Connected [imtu 672, omtu 0, flush_to
>65535]
>
>socket 5: Connection from 12:5C:2A:44:0D:00, mtu=3D672
><----------------- Play Pressed on headphones
>socket 5: Received 2 bytes
>00000: 00 01
>
>
>This is with a  Broadcom BCM2045 usb dongle standars Ubuntu 6.06 kernel
>(checked looks like the patch is applied).
>HP fa303 headset =

> =

>
>------------------------------------------------------------------------
>---------- =

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
