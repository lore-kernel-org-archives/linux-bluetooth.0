Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ca39c8ec1001112017w3111e85ck3525b28fdaf4397e@mail.gmail.com>
References: <ca39c8ec1001112017w3111e85ck3525b28fdaf4397e@mail.gmail.com>
Date: Tue, 12 Jan 2010 18:10:41 +0900
Message-ID: <ca39c8ec1001120110p63ff6536x307568dfd9e87693@mail.gmail.com>
Subject: Re Unable to connect to Movon MS500 Bluetooth headset
From: Asutosh Das <das.asutosh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am using a Movon MS500 BT headset. I have compiled bluez 3.36 for arm and
am able to play music with a 590plantronics headset. But I am unable to
play with the Movon headset.

Chip - BCM4325
Headset - movon & 590plantronics
Processor - ARM

I have done the following:
1. I have changed the /etc/asound.conf to movon bdaddr
2. I have created a new audio device for movon using the dbus command
line. The following log shows the two audio devices created:

   # dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/blue
z/audio org.bluez.audio.Manager.ListDevices
method return sender=:1.15 -> dest=:1.48 reply_serial=2
  array [
     string "/org/bluez/audio/device0"
     string "/org/bluez/audio/device1"
  ]

Now device0 -> movon & device1 -> plantronics


3. The following command works fine and I am able to hear the music in
plantronics.
  dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/blue
z/audio/device1 org.bluez.audio.Sink.Connect

./mplayer -ao alsa:device=bluetooth /Music/AKJS.mp3


4.  The following command doesn't work and gives me an error .

dbus-send --system --print-reply --type=method_call --dest=org.bluez /org/blue
z/audio/device0 org.bluez.audio.Sink.Connect
hcid[1061]: avdtp_ref(0x70f20): ref=2
called: send_request
called: send_req
This func l2cap_connect
l2cap_connect
L2CAP TRANSPORT

This func l2cap_connect
hcid[1061]: stream creation in progress
hcid[1061]: link_key_request (sba=43:25:D1:00:00:00, dba=00:13:7B:40:1E:8E)
hcid[1061]: kernel auth requirements = 0x00
called: l2cap_connect_cb
hcid[1061]: connect(): Connection refused (111)
This error l2cap_connect_cb
hcid[1061]: avdtp_unref(0x70f20): ref=1
hcid[1061]: connect:connect XCASE detected
hcid[1061]: avdtp_unref(0x70f20): ref=0
hcid[1061]: avdtp_unref(0x70f20): freeing session and removing from list


hcid[1061]: Stream setup failed, after XCASE connect:connect
Error org.bluez.Error.Failed: Stream setup failed

I found that the connection refused is due to an error in getsocketopt
call in glib-helper.c . The 'ret'  value is not equal to 0. Thus the
rest is screwed. Now its a system call, so I guess something is going
wrong in the kernel itself ...


5. My default device is device0 i.e. movon
# dbus-send --system --print-reply --type=method_call --dest=org.bluez /org/blue
z/audio org.bluez.audio.Manager.DefaultDevice
method return sender=:1.15 -> dest=:1.49 reply_serial=2
  string "/org/bluez/audio/device0"



The following is the hcidump log :

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
   bdaddr 00:13:7B:40:1E:8E ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
   Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
   Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
   status 0x00 handle 12 bdaddr 00:13:7B:40:1E:8E type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
   handle 12
> HCI Event: Command Status (0x0f) plen 4
   Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
   status 0x00 handle 12
   Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
   bdaddr 00:13:7B:40:1E:8E mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x02 dlen 10
   L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
   Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   bdaddr 00:13:7B:40:1E:8E mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
   handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 16
   L2CAP(s): Info rsp: type 2 result 0
     Extended feature mask 0x0000
< ACL data: handle 12 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 25 scid 0x0040
> HCI Event: Remote Name Req Complete (0x07) plen 255
   status 0x00 bdaddr 00:13:7B:40:1E:8E name 'Movon MS500'
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
   handle 12
> HCI Event: Number of Completed Packets (0x13) plen 5
   handle 12 packets 2
> HCI Event: Command Status (0x0f) plen 4
   Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
   status 0x00 handle 12
   LMP Version: 2.0 (0x3) LMP Subversion: 0xcdf
   Manufacturer: Cambridge Silicon Radio (10)
> ACL data: handle 12 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
     Connection pending - Authorization pending
> HCI Event: Link Key Request (0x17) plen 6
   bdaddr 00:13:7B:40:1E:8E
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
   bdaddr 00:13:7B:40:1E:8E
> HCI Event: Command Complete (0x0e) plen 10
   Link Key Request Negative Reply (0x01|0x000c) ncmd 1
   status 0x00 bdaddr 00:13:7B:40:1E:8E
> HCI Event: PIN Code Request (0x16) plen 6
   bdaddr 00:13:7B:40:1E:8E
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
   bdaddr 00:13:7B:40:1E:8E len 4 pin '0000'
> HCI Event: Command Complete (0x0e) plen 10
   PIN Code Request Reply (0x01|0x000d) ncmd 1
   status 0x00 bdaddr 00:13:7B:40:1E:8E
> HCI Event: Link Key Notification (0x18) plen 23
   bdaddr 00:13:7B:40:1E:8E key 89B740C1D99C159782CCD83F8E41350B type 0
   Type: Combination Key
< HCI Command: Disconnect (0x01|0x0006) plen 3
<------------------------- My board is sending the disconnect signal
???
   handle 12 reason 0x14
   Reason: Remote Device Terminated Connection due to Low Resources
 <-------------------------------------- What does this mean ?
> HCI Event: Command Status (0x0f) plen 4
   Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
   status 0x00 handle 12 reason 0x16
   Reason: Connection Terminated by Local Host


I put the movon headset in discoverable mode and the alternate red &
blue blinking changes to blue alone but stream setup fails !!! ...
Please can you let me know what I am missing here ... Please give me
anything or any thought that you might have and I shall take it up
from there ...

--
Thank you,
Warm Regards,
Das


While working further I created a device for my plantronics headset in
command line using dbus-send. Then I tried to connect to the headset
over command line using dbus-send and org.bluez.audio.Sink.Connect

The following log shows the hcidump log ... I have marked the same
sequence of events as that occur in Movon headset. But somehow the
plantronics headset just ignores it ...

# /usr/sbin/hcidump -XV
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:19:7F:6F:6E:83 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:19:7F:6F:6E:83
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:19:7F:6F:6E:83
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:19:7F:6F:6E:83
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:19:7F:6F:6E:83
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:19:7F:6F:6E:83 len 4 pin '0000'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:19:7F:6F:6E:83
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:19:7F:6F:6E:83 key 43BA67EC6BCAAAFFD5692C9C6EC0504F type 0
    Type: Combination Key
< HCI Command: Disconnect (0x01|0x0006) plen 3   <---- My board is
issuing a disconnect command ???
    handle 0 reason 0x14
    Reason: Remote Device Terminated Connection due to Low Resources
<-- when do this error code come ?
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters         <---- Somehow
plantronics doesn't recognize it ... !!!
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:19:7F:6F:6E:83 type ACL encrypt 0x01
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xec 0x01 0x00 0x18 0x18 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:7F:6F:6E:83 mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:7F:6F:6E:83 name '590Plantronics'
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
    status 0x00 handle 12
    LMP Version: 2.0 (0x3) LMP Subversion: 0x9a2
    Manufacturer: Cambridge Silicon Radio (10)
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful

Please can you let me know
1. When do this error "Remote Device Terminated Connection due to Low
Resources" come ?
2. Am I missing something here ? Is there a patch available ?

Anything that you might have on this problem would help ...

-- 
Thank you,
Warm Regards,
das
