Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Dietmar Segbert <trebges@web.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <9lVn5TEuSyB@trebges.web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] a2play question
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
Date: 08 Jan 2006 11:13:00 +0100

Hello,

since a week i am owner of the following bluetooth-devices:

ovislink bt-201usb (dongle)
ovislink stereo receiver bt-120ar
ovislink transmitter bt-120aj
I use slackware linux with a 2.4.26 kernel. All the modules for the
bluetooth where compiled.


I have installed the latest bluez-libs and -utils. Also is installed the
latest alsa-libs.
I start the bluetooth-system by a sehll-script:

#!/bin/bash
modprobe hci_usb
hcid
modprobe l2cap
modprobe bnep
modprobe sco
sdpd
hciconfig -a

The commands hcitool dev and hcitool scan detectt the dongle and the
stereo-receiver.

The output of

hcitools info 00:4F:62:05:53:8A

looks like this:

Requesting information ...	BD Address:  00:4F:62:05:53:8A	Device Name:
Stereo Receiver	LMP Version: 1.2 (0x2) LMP Subversion: 0x3d	Manufacturer:
Zeevo, Inc. (18)	Features: 0xff 0xff 0x05 0x78 0x18 0x18 0x00 0x80		<3- 
slot packets> <5-slot packets> <encryption> <slot offset> 		<timing
accuracy> <role switch> <hold mode> <sniff mode> 		<park state> <RSSI>
<channel quality> <SCO link> <HV2 packets> 		<HV3 packets> <u-law log> <A- 
law log> <CVSD> <power control> 		<enhanced iscan> <interlaced iscan>
<interlaced pscan>
		<inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
		<AFH cap. master> <AFH class. master> <extended features>


The command "sdptool browse" produces the following output:

Inquiring ...Browsing 00:4F:62:05:53:8A ...Service Name: Audio SinkService
RecHandle: 0x110bService Class ID List:  "Audio Sink" (0x110b)Protocol
Descriptor List:  "L2CAP" (0x0100)    PSM: 25  "AVDTP" (0x0019)    uint16:
0x100Language Base Attr List:  code_ISO639: 0x656e  encoding:    0x6a   
base_offset: 0x100Profile Descriptor List:  "Advanced Audio" (0x110d)     
Version: 0x0100Service Name: HeadsetService RecHandle: 0x1108Service Class
ID List:  "Headset" (0x1108)  "Generic Audio" (0x1203)Protocol Descriptor
List:  "L2CAP" (0x0100)  "RFCOMM" (0x0003)    Channel: 8Language Base Attr
List:  code_ISO639: 0x656e  encoding:    0x6a  base_offset: 0x100Profile
Descriptor List:  "Headset" (0x1108)    Version: 0x0100Service Name:
HandsfreeService RecHandle: 0x111eService Class ID List:  "Handsfree"
(0x111e)  "Generic Audio" (0x1203)Protocol Descriptor List:  "L2CAP"
(0x0100)  "RFCOMM" (0x0003)    Channel: 7Language Base Attr List:   
code_ISO639: 0x656e  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101


I have downloaded the btsco-0.4 package. The progs a2play, sbcenc rcfplay
compile correctly, also btsco and btsco2.
If i do a make in the /kernel directory, it appears a errormessage /lib/ 
modules/2.4.26/source cannot find such file. I can not find a kernelmodule
btsco.

The command

mpg123 --au - musik.mp3 | a2play 00:4F:62:05:53:8A -

produces no sound output only  error message.

The command

mpg123 --au - musik.mp3 | sbcenc - | a2play 00:4F:62:05:53:8A -

produces sound, but it plays to fast.

I will be happy, if you can help me.
another question ist: Can i send output of mplayer to the stereo-receiver?

Best regards.

Dietmar


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
