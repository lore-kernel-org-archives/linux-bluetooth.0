Return-Path: <cyrus@holtmann.org>
Message-ID: <72F4D51C1C4F4B6AAC97ED3B6C187991@swwprd2>
From: "Mario Premke" <mario.premke@web.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: Bluez 4.99 - Connection/Authentification keeps pending
Date: Tue, 4 Dec 2012 14:50:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I am running: Bluez-4.99 ; Kernel 3.6.8; connecting a mouse (Logitech V470) 
with simple-agent was no problem.
Trying (for hours) to connect a Keysonic ACK-595BT keyboard - to no avail.

The pin somehow gets exchanged, but then it gets stuck:

... simple-agent hci0 00:18:00:00:D0:88
RequestPinCode (/org/bluez/1644/hci0/dev_00_18_00_00_D0_88)
Enter PIN Code: 123456
Release exit: False <- this is my debug print "Release exit: %s" % 
self.exit_on_release in simple-agent
Creating device failed: org.freedesktop.DBus.Error.NoReply: Did not receive 
a reply. Possible causes include: the remote application did not send a 
reply, the message bus security policy blocked the reply, the reply timeout 
expired, or the network connection was broken.

and the connection/authentification keeps pending (snip from hcidump):

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:18:00:00:D0:88 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 37 bdaddr 00:18:00:00:D0:88 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 37
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:18:00:00:D0:88 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 37
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:00:00:D0:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:00:00:D0:88 name 'BTKB-D088'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 37
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:18:00:00:D0:88
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:18:00:00:D0:88
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:18:00:00:D0:88
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:18:00:00:D0:88
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:18:00:00:D0:88 len 6 pin '123456'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:18:00:00:D0:88
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:18:00:00:D0:88 key 86B9BE88F30AF1481F03C2D69894AD4C type 0
    Type: Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 37
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 37
< ACL data: handle 37 flags 0x00 dlen 10
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:18:00:00:D0:88
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:18:00:00:D0:88 key 86B9BE88F30AF1481F03C2D69894AD4C
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:18:00:00:D0:88
> ACL data: handle 37 flags 0x02 dlen 16
      Extended feature mask 0x0007
        Flow control mode
        Retransmission mode
        Bi-directional QoS
< ACL data: handle 37 flags 0x00 dlen 12
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 37
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 16
      Connection pending - Authorization pending
> ACL data: handle 37 flags 0x02 dlen 16
      Connection successful
< ACL data: handle 37 flags 0x00 dlen 12
> ACL data: handle 37 flags 0x02 dlen 12
< ACL data: handle 37 flags 0x00 dlen 18
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 14
      Success
< ACL data: handle 37 flags 0x00 dlen 24
        SDP SSA Req: tid 0x0 len 0xf
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Mode Change (0x14) plen 6
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    Mode: Sniff
< ACL data: handle 37 flags 0x00 dlen 12
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 37 reason 0x08
    Reason: Connection Timeout
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:18:00:00:D0:88 all 0
> HCI Event: Command Complete (0x0e) plen 6
    Delete Stored Link Key (0x03|0x0012) ncmd 1
    status 0x00 deleted 0

When I then struck a key at the BT keyboard hcidump shows the following:

> HCI Event: Mode Change (0x14) plen 6
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    Mode: Sniff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:18:00:00:D0:88 class 0x002540 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:18:00:00:D0:88 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:18:00:00:D0:88 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 37 bdaddr 00:18:00:00:D0:88 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 37
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:18:00:00:D0:88 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> ACL data: handle 37 flags 0x02 dlen 12
< ACL data: handle 37 flags 0x00 dlen 16
      Connection pending - No futher information available
< ACL data: handle 37 flags 0x00 dlen 10
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 37
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:00:00:D0:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 37 flags 0x02 dlen 16
      Extended feature mask 0x0007
        Flow control mode
        Retransmission mode
        Bi-directional QoS
< ACL data: handle 37 flags 0x00 dlen 16
      Connection successful
< ACL data: handle 37 flags 0x00 dlen 12
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 12
< ACL data: handle 37 flags 0x00 dlen 18
      MTU 672
> ACL data: handle 37 flags 0x02 dlen 14
      Success
< ACL data: handle 37 flags 0x00 dlen 5
      HIDP: Control: Virtual cable unplug
< ACL data: handle 37 flags 0x00 dlen 12
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:00:00:D0:88 name 'BTKB-D088'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> ACL data: handle 37 flags 0x02 dlen 12
> ACL data: handle 37 flags 0x02 dlen 12
< ACL data: handle 37 flags 0x00 dlen 16
      Connection pending - Authorization pending
< ACL data: handle 37 flags 0x00 dlen 16
      Connection refused - security block
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 37 reason 0x13
    Reason: Remote User Terminated Connection


This is what /var/log/messages says:

dbus[1631]: [system] Rejected send message, 1 matched rules; 
type="method_return", sender=":1.31" (uid=0 pid=3009 comm="/usr/bin/python2 
/usr/bin/simple-agent hci0 00:18:") interface="(unset)" member="(unset)" 
error name="(unset)" requested_reply="0" destination=":1.0" (uid=0 pid=1644 
comm="/usr/sbin/bluetoothd --udev ")

My policies at /etc/dbus-1/system.d/bluetooth.conf are:

<policy user="root">
<allow own="org.bluez"/>
<allow send_destination="org.bluez"/>
<allow send_interface="org.bluez.Agent"/>
<allow send_interface="org.bluez.HandsfreeAgent"/>
<allow send_interface="org.bluez.MediaEndpoint"/>
<allow send_interface="org.bluez.MediaPlayer"/>
<allow send_interface="org.bluez.Watcher"/>
<allow send_interface="org.bluez.ThermometerWatcher"/>

<allow send_type="method_call"/>
<allow send_type="method_return"/>
</policy>

I am fiddling around with the allowance for the send_types, but it always 
runs into the rejected message type as can be seen in the syslog, probably 
because of the "unset" interface (see syslog), since I have (not 
surprisingly) no rule for this interface.

So it seems to get stuck in the authentification process, but I have no clue 
why?
In Bluez-3.x there was a programm 'passkey-agent', is it obsolete that it's 
not included in Bluez-4.x any more?
I once connected the keyboard to another linux system, but that was with 
Bluez-3.x ...

Thanks in advance
Mario 

