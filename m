Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rolf S. Dubitzky " <Dubitzky@physi.uni-heidelberg.de>
To: bluez-users@lists.sourceforge.net
References: <200511141452.23951.Dubitzky@physi.uni-heidelberg.de>
In-Reply-To: <200511141452.23951.Dubitzky@physi.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511141705.51539.Dubitzky@physi.uni-heidelberg.de>
Subject: [Bluez-users] Re: hcid crashing on pin_code_request
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
Date: Mon, 14 Nov 2005 17:05:50 +0100

Ok,

I guess the standard answer is to compile the latest version ;-)  Which 
actualy helps.  I gues I have paired the devices now, but still no cigar.
When starting btsco it complains: 

 # /usr/local/bin/btsco -v -r -s 00:07:A4:03:97:24
 btsco v0.4c
 Device is 1:0
 Error: Failed to connect to SDP server: Connection timed out
 Assuming channel 2

 Voice setting: 0x0060
 Can't connect RFCOMM channel: Resource temporarily unavailable

sdpd is running. 

 # ps -C sdpd
   PID TTY          TIME CMD
 27407 ?        00:00:00 sdpd

what to do?  I follow the HOWTO on http://bluetooth-alsa.sourceforge.net/ 
which doesn't mention RFCOMM. 

The hcidump from starting btsco is below. Do I need to add something 
in /etc/bluetooth/rfcomm ??

output of hcitool info, aplay -l, various sdptool calls are below.

Cheers, Rolf



# cat /var/lib/bluetooth/00\:09\:DD\:10\:53\:4E/features
00:07:A4:03:97:24 FCFF0B0000000000

# /usr/local/bin/hcitool info 00:07:A4:03:97:24
Requesting information ...

        BD Address:  00:07:A4:03:97:24
        Device Name: JABRA BT200
        LMP Version: 1.1 (0x1) LMP Subversion: 0x3f9
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <transparent SCO>
# /usr/local/bin/sdptool records 00:07:A4:03:97:24
Failed to connect to SDP server on 00:07:A4:03:97:24: Connection timed out
# /usr/local/bin/sdptool browse 00:07:A4:03:97:24
Failed to connect to SDP server on 00:07:A4:03:97:24: Connection timed out

# /usr/local/bin/sdptool search hs
Inquiring ...
# /usr/local/bin/sdptool search hf
Inquiring ...
# 

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371 DAC2/ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: AudioPCI [Ensoniq AudioPCI], device 1: ES1371/2 [ES1371 DAC1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Headset [BT Headset], device 0: Bluetooth SCO PCM [BT SCO PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0



--------  hcidump -X -V
(.. the part after btsco startup 



< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:03:97:24 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:07:A4:03:97:24
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:07:A4:03:97:24 key 42892CA9762A764B1AAAD26AA3A31453
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:07:A4:03:97:24
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:07:A4:03:97:24 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:07:A4:03:97:24 mode 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
