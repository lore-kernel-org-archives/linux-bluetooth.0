Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <463151D2.1040805@jlab.org>
Date: Thu, 26 Apr 2007 21:28:50 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Plugz, a2dpd, and a2dpd2 strangeness
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

With the amount of experimentation I've done in the past couple of days 
it's hard to figure out what information is relevant. I'll try to boil 
it down:

I couldn't get btsco to work, though a2play did.

With pcm_a2dpd I get occasional (~one every two minutes) chirps out of 
the headphones, mainly when interrupting ogg123 (aplay, whatever). 
hcidump -X -V shows no traffic except briefly when those chirps occur. 
Sound is fine through the alsa redirect.

With pcm_a2dpd2 I have jumpy, very sped up sound from the headphones and 
plenty of traffic through hcidump. Alsa redirect sounds about the same 
as the headphones, but the daemon gives the following errors:

A2DPD[21:11:15.563]: alsa_transfer_raw: (errno=32:Broken pipe)EPIPE(-32)
A2DPD[21:11:15.983]: append_to_ring_buffer: Ring buffer is full
A2DPD[21:11:15.983]: append_to_ring_buffer: Ring buffer is full
A2DPD[21:11:15.986]: append_to_ring_buffer: Ring buffer is full

and on, filling the screen with the full buffer messages.


I suppose that basically describes the situation. The rest is 
background. I'm willing to do whatever I can to help, but as my C is 
rusty I figure it's time to ask the devs.

~Chris



Background:
I followed the build instructions and troubleshooting for Plugz at 
bluetooth-alsa.sf.net. Everything went without a hitch as far as I can see.

I have a pair of Creative CB2530 headphones. I've tried them with four 
different bluetooth dongles including both Broadcom and CSR (currently a 
DLink DBT-120). There were no differences between dongles. Connecting is 
never problematic at all.

This is Gentoo with Bluez 3.9 and kernel 2.6.20 with the sco patches.

carlin1 ~ # hciconfig -a
hci0:   Type: USB
         BD Address: 00:17:9A:2B:73:53 ACL MTU: 384:8 SCO MTU: 64:8
         UP RUNNING PSCAN
         RX bytes:989913 acl:63621 sco:0 events:13344 errors:0
         TX bytes:7630626 acl:24367 sco:0 commands:67 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
         Device Class: Computer, Uncategorized
         HCI Ver: 2.0 (0x3) HCI Rev: 0x77b LMP Ver: 2.0 (0x3) LMP 
Subver: 0x77b
         Manufacturer: Cambridge Silicon Radio (10)

carlin1 ~ # hcitool info 00:0D:E8:01:BB:A3
Requesting information ...
         BD Address:  00:0D:E8:01:BB:A3
         Device Name: CB2530
         LMP Version: 1.2 (0x2) LMP Subversion: 0x3d
         Manufacturer: Zeevo, Inc. (18)
         Features: 0xff 0xff 0x05 0x78 0x18 0x18 0x00 0x80
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <power 
control>
                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                 <AFH cap. master> <AFH class. master> <extended features>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
