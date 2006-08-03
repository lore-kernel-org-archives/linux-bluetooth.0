Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 3 Aug 2006 08:49:20 +0100
Message-ID: <056BF200E9632F4285220E570FEED673D3ADC9@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673D035B8@GBMDDMH202AMSX.gb001.siemens.net>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Just thought I'd let you know of my success's and problems with my HP
blutooth headphones (a2dpd & avrcp) and broadcom bcm2045 dongle

Modified acrecv.c replacing the printk's with appropiate system("xmms
-s") comands recompiled

Ran this script

 #!/bin/sh -e
#
# BTXMMS
#

sdptool add AVRTG


if [ -x /usr/bin/a2dpd ]; then
	/home/andy/blueheadphones/avrecv &
	vlc &
	xmms &
	/usr/bin/a2dpd 00:0D:44:2A:5C:12 
fi
# fi
			

exit 0

Pressed play on the screen and sound in all it's beauty came from my
speakers (this wasn't new) then press next on the headphones and viola
the track jumped forward same for back and pause.

Then the fly in the ointment

If you press pause (either on xmms or headphones) wait 10 secs then
press play again on headphones it appears the heaphones recreate a avrcp
connection but no a2dpd (bugger bugger bugger) the only way out of this
is switch off the headphones and restart.

This is the log output

PCM thread 0.5 started
DEBUG: a2dp_params: (errno=0:Success)a2dp 0x821d4e8
DEBUG: a2dp_params: (errno=0:Success)format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: (errno=0:Success)frame_bytes 4 period_bytes 8192
period_size 2048 buffer_size 4096
DEBUG: a2dp_prepare: (errno=0:Success)a2dp 0x821d4e8
Accepting incoming stream connection
DEBUG: a2dp_prepare: (errno=4:Interrupted system call)a2dp 0x821d4e8
<--------------- PAUSE Pressed
[1] Receiving failed on socket 0.5 error (-1/4 bytes) errno=11:Resource
temporarily unavailable
Client thread 0.5 ending: timeout
Destroying lpA2dp, destroy_count is 5001
DEBUG: a2dp_destroy: Begin
DEBUG: a2dp_free: Begin
DEBUG: a2dp_destroy: a2dp_destroy(0x8053090) OK
Connectedreceived 0 bytes:

transaction_label = 0
packet_type = 0
cr = 1
ipid = 0
pid = e11
zeroes = 0
ctype = 9
subunit_type = 9
subunit_id = 0
opcode = 7c
operand0 = 4b
operand1 = 0
accepting next connection
DEBUG: a2dp_wait_connection: Begin
DEBUG: a2dp_wait_connection: Connected [imtu 672, omtu 0, flush_to
65535]

socket 5: Connection from 12:5C:2A:44:0D:00, mtu=672
<----------------- Play Pressed on headphones
socket 5: Received 2 bytes
00000: 00 01


This is with a  Broadcom BCM2045 usb dongle standars Ubuntu 6.06 kernel
(checked looks like the patch is applied).
HP fa303 headset 
 

------------------------------------------------------------------------
---------- 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
