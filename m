Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Gustavo Michels <gustavo.michels@ig.com.br>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504020231.12721.gustavo.michels@ig.com.br>
Subject: [Bluez-devel] ISSC dongle and snd-bt-sco
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 2 Apr 2005 02:31:12 -0300

Hi all

***Please CC me as I am not being able to subscribe to the list! 
Thanks!***

I just got a generic ISSC dongle and I am trying to get it working with 
a Jabra BT250 headset, using snd-bt-sco.

So far, I can tell I can hear *part* of any wave file I send to the 
headset. It never completes the entire audio file, though (i.e. aplay 
hangs forever).

I tried using both headset and hands-free profiles (channels 1 & 2 
respectively). Both give the same results on the played audio file. 
Also, it won't work all the times I try. On a lucky day, I was able to 
send the wave file to the headset for 3 or 4 times in a row. I am still 
trying to find a pattern in this. All my tests were done using only 
aplay, as I never got anything using xmms or any other.

I will try to provide as much information as possible, but I am new to 
this bluetooth stuff. I tried searching the archives but couldn't find 
anything very useful apart from testing with a well-known working 
dongle, which is not possible for me.

Here's some information as requested on the bluetooth-alsa page (btw I 
use Gentoo):

# uname -a
Linux gustavo 2.6.11-nitro2 #1 Wed Mar 23 18:28:43 BRT 2005 i686 mobile 
AMD Athlon(tm) XP2400+ AuthenticAMD GNU/Linux

# epm -qa |grep bluez
bluez-libs-2.15
bluez-hcidump-1.18
bluez-utils-2.15

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:02:D7:34 ACL MTU: 678:8 SCO MTU: 48:5
        UP RUNNING PSCAN ISCAN
        RX bytes:440 acl:0 sco:0 events:21 errors:0
        TX bytes:324 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Pavilion'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1a4 LMP Ver: 1.1 (0x1) LMP Subver: 
0x1a4
        Manufacturer: Integrated System Solution Corp. (57)

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:11:67:02:D7:34 ACL MTU: 678:8 SCO MTU: 48:5
        Unsupported manufacturer

# hcitool info 00:07:A4:0B:07:23
Requesting information ...
        BD Address:  00:07:A4:0B:07:23
        Device Name: JABRA 250
        LMP Version: 1.1 (0x1) LMP Subversion: 0x3f9
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role 
switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel 
quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> 
<A-law log>
                <CVSD> <paging scheme> <transparent SCO>

Output of btsco using channel 1 (autodetected if I don't specify the 
channel):
$ btsco -v 00:07:A4:0B:07:23
btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200		#pressed button on headset
speaker volume: 8 mic volume: 9	#started aplay
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=08
Sending up speaker change 8
speaker volume: 8 mic volume: 9
driver is not in use			#killed hung aplay
disconnected SCO channel

Output of btsco using channel 2:
$ btsco -v 00:07:A4:0B:07:23 2
btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 2 connected
recieved AT+CIND=?
speaker volume: 11 mic volume: 1	#started aplay
driver is in use
connected SCO channel
Done setting sco fd
speaker volume: 11 mic volume: 1
driver is not in use			#killed aplay
disconnected SCO channel

Output (striped) of hcidump -X can be found at 
http://www.colortechdp.com.br/pessoal/hcidump.txt

Also, my kernel logs get filled with lines like this:

hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

Please ask for any additional information you may find useful. Thanks 
for any help.

Gustavo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
