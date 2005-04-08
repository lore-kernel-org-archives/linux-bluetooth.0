Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Jan Rychter <jan@rychter.com>
Message-ID: <m24qehv3n1.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Motorola HS-850 and btsco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 08 Apr 2005 14:45:06 +0200

Hi,

I've been trying to get my Motorola HS-850 headset to work with btsco,
using two different USB adapters.

It seems I'm getting quite far: I can pair the devices, btsco can
connect, and it can detect button presses:

# btsco -v 00:07:A4:5C:39:F7 1
btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
recieved AT+CKPD=200

The headset reports as:

# hcitool info 00:07:A4:5C:39:F7
Requesting information ...
        BD Address:  00:07:A4:5C:39:F7
        Device Name: Motorola HS850
        LMP Version: 1.2 (0x2) LMP Subversion: 0x5dd
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x8b 0xf8 0x18 0x18 0x00 0x80
                <encryption> <slot offset> <timing accuracy> <role switch> 
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality> 
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <paging scheme> <transparent SCO> <broadcast encrypt> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <extended SCO> <AFH cap. slave> 
                <AFH class. slave> <AFH cap. master> <AFH class. master> 
                <extended features> 

The problem is that I don't get audio. When I try audio playback or
recording, I do get a static hiss in the headset and lots of SCO packets
appear on the link (checked with hcidump).

I also checked that the volumes are set to max using "alsamixer -c1 -V
all". Tried aplay/arecord, sox, xmms with output to plughw:Headset, all
produce exactly the same effect.

Kernel 2.6.11, two different USB dongles (one BCM2033-based, one an
IOGear GBU-311 (thanks, Marcel!)). Same results.

What else there is to try?

--J.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
