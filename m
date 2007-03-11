Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 11 Mar 2007 13:32:23 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070311203223.GP8187@alcor.net>
MIME-Version: 1.0
Subject: [Bluez-users] Plantronics 510 headset: playback partially works,
	but not recording
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I'm attempting to get my Plantronics 510 headset talking to my desktop PC.
I'm using:

- Ubuntu Feisty
- bluez 3.9
- Linux 2.6.20 + sco-flowcontrol-v3.0.diff
- This USB dongle: Bus 003 Device 009: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter

and the example .asoundrc from CVS, modified to set the MAC address for my headset.

Playback seems to be mostly working.  I can play short sounds to the headset
using aplay.  I tried playing a song (resampled to 8kHz mono) as a test, but
it cuts out periodically, approximately once per second.  I hear about 0.25
seconds of audio followed by 0.75 seconds of silence, etc.  I'm not sure
whether this is due to aplay or a problem with the bluetooth setup; is this
expected to work?

Recording with arecord doesn't work at all.  When I try, I get this from hcidump:

< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 1 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Command Status (0x0f) plen 4
    Add SCO Connection (0x01|0x0007) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 2 bdaddr 00:03:89:97:13:9E type SCO encrypt 0x01
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:03:89:97:13:9E mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 0]
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 0]
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:03:89:97:13:9E name 'PLT  510'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 0]
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 0]
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1

and this from headsetd:

Mar 11 13:27:45 localhost headsetd[779]: Changing state: Connected-->Ready
Mar 11 13:27:45 localhost headsetd[779]: Changing state: Ready-->Opening
Mar 11 13:27:46 localhost headsetd[779]: SCO channel opened handle=0x0002 mtu=48
Mar 11 13:27:46 localhost headsetd[779]: Changing state: Opening-->Streaming

The headset beeps and its LED flashes more quickly to tell me that it's
recording (as expected; it does both with my phone), but no data is received
by arecord.

Has anyone else seen behaviour like this?  How can I diagnose the problem?

-- 
 - mdz

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
