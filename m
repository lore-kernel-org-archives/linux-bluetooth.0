Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1487341004.9572.7.camel@thorstenknbl1.mgm-edv.de>
Subject: "Bluetooth: Unexpected continuation frame (len 0)" - sound spikes
 and dmesg flooded with those messages
From: Torsten Krah <krah.tm@gmail.com>
Reply-To: Torsten Krah <krah.tm@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2017 15:16:44 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

http://www.bluez.org/development/lists/ does only list this list coming
from the user list link http://www.bluez.org/contact/ there - so
hopefully i am right here, if not please suggest otherwise.

Currently i am using kernel 4.9.6 and bluez userland tools in version
4.101-0ubuntu13.1 to pair this adapter:

Feb 13 10:42:50 thorstenknbl1 kernel: [    5.370712] usb 2-1.8.6.4.3:
new full-speed USB device number 10 using ehci-pci
Feb 13 10:42:50 thorstenknbl1 kernel: [    5.483812] usb 2-1.8.6.4.3:
New USB device found, idVendor=050d, idProduct=0017
Feb 13 10:42:50 thorstenknbl1 kernel: [    5.483816] usb 2-1.8.6.4.3:
New USB device strings: Mfr=1, Product=2, SerialNumber=3
Feb 13 10:42:50 thorstenknbl1 kernel: [    5.483819] usb 2-1.8.6.4.3:
Product: BLUETOOTH USB +EDR ADAPTER Class 1 v2.1 UHE
Feb 13 10:42:50 thorstenknbl1 kernel: [    5.483821] usb 2-1.8.6.4.3:
Manufacturer: Broadcom Corp
Feb 13 10:42:50 thorstenknbl1 kernel: [    5.483823] usb 2-1.8.6.4.3:
SerialNumber: 00190E0F9BA4


with a remote sound receiver (about 2 meters away, just air) to play
music there via A2DP profile.

[14:47:26][tkrah@thorstenknbl1:~]  $ hcitool con
Connections:
	< ACL 0C:A6:94:85:48:AC handle 11 state 1 lm SLAVE AUTH ENCRYPT 


[14:47:22][tkrah@thorstenknbl1:~]  $ hcitool info 0C:A6:94:85:48:AC
Requesting information ...
	BD Address:  0C:A6:94:85:48:AC
	Device Name: Philips AEA2700
	LMP Version: 3.0 (0x5) LMP Subversion: 0x2578
	Manufacturer: Cambridge Silicon Radio (10)
	Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
		<power control> <transparent SCO> <broadcast encrypt> 
		<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
		<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
		<sniff subrating> <pause encryption> <AFH cap. master> 
		<AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps> 
		<3-slot EDR eSCO> <extended inquiry> <simple pairing> 
		<encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power> 
		<EPC> <extended features> 
	Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00


If i am going to increase the range by 1 or 2 meters sound gets much
more spikes or drops completely.
In general my dmesg log buffer if flooded with those (even if it seems
to playing "normally"):

[ 3410.740435] Bluetooth: Unexpected continuation frame (len 0)

Sometimes it happens that in a few seconds more than 4k of them are
logged - seems to happen more often or more likely the farer away the
transmitter is to the receiver and getting more spikes too in that case.

The only report i've found so far via google which is similar is that:

https://bugzilla.redhat.com/show_bug.cgi?id=1296378

but there was not response there and is closed because of EOL.

Nevertheless - what does the above kernel message mean?

Can i do something to get rid of it in terms of eliminating the root
cause - which means i need to get an idea what might cause it?
Can there be a rate limit or something to omit those massive log amount?

And as it still happens with those 2 meter air that i've got spikes
while playing music - how to get to the root cause of that?
Maybe its signal strength related because increasing distance seems to make it worse,
how to increase the strength or check if its related to that?

The receiver at least and also the sending device are able todo spike
free sound - at least they are when running and observing them on a win32 platform.
So either there must be some problem in front of the computer (me) doing
something wrong or there's some problem in the drivers / kernel or bluez tools - don't
know.

Any help is appreciated to improve this situation (e.g. suggestions of
what to try, provide logs, configurations, traces ... whatever might
needed to help me or to dig into that kind of problem).

thanks and kind regards

Torsten


