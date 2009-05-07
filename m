Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: bluez 4.x questions, SCO stops
Date: Thu, 7 May 2009 16:01:02 -0500
Message-ID: <79DD16001F75DB4EB7DE37CDD687BB2001B7238D@dalamsexb02.AMERICAS.ROOT.PRI>
From: "Brock Denson" <Brock.Denson@csr.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am having a problem with SCO stopping after 1 minute that I would
really appreciate some help with.  I can connect to the headset, query
responses, etc, but when I start sco either via a dbus-send command or
with the test-telephony play <> command then after 30 seconds I get a
dbus timeout and then 30 more seconds later the SCO will stop.  I have
air-traced the session and can see that the host is sending silence
while SCO is being transmitted, so it seems functional, but I am sure I
am missing something.  I have included just about everything I can think
of below in the hopes that someone has a few minutes to point out the
problem.  Distribution is FC10.

---- asoundrc file (from bluez source)
pcm.headset {
	type bluetooth
	device "00:0b:2e:85:1e:53"
	profile voice
}

ctl.headset {
	type bluetooth
}

---- audio.conf -------------------
[General]
SCORouting=PCM
[Headset]
HFP=true
MaxConnections=1

---- Userland ---------------------
[brockd@demo3 bluez]$ test/test-telephony play 00:0b:2e:85:1e:53
Traceback (most recent call last):
  File "test/test-telephony", line 91, in <module>
    headset.Play()
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630,
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NoReply: Did
not receive a reply. Possible causes include: the remote application did
not send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken.


---- HCI land ---------------------
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Connect Complete (0x03) plen 11
> ACL data: handle 38 flags 0x02 dlen 17
> ACL data: handle 38 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 0]
< ACL data: handle 38 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Connect Complete (0x03) plen 11
> ACL data: handle 38 flags 0x02 dlen 17
> ACL data: handle 38 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 0]
< ACL data: handle 38 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
< ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Disconn Complete (0x05) plen 4
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
> HCI Event: Remote Name Req Complete (0x07) plen 255
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 38 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 38 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 48 
< ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 38 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-32 0x111f (Handsfree AG)
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 38 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 132 
< ACL data: handle 38 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 132 
< ACL data: handle 38 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013 
> ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 0
< ACL data: handle 38 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Auth Complete (0x06) plen 3
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Encrypt Change (0x08) plen 4
< ACL data: handle 38 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c 
< HCI Command: Switch Role (0x02|0x000b) plen 7
< ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> ACL data: handle 38 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15
< ACL data: handle 38 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 38 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 38 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4 
< ACL data: handle 38 flags 0x02 dlen 22
    L2CAP(d): cid 0x0041 len 18 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e 
< ACL data: handle 38 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Disconn Complete (0x05) plen 4


---- Bluetoothd ------------------
[brockd@demo3 bluez]$ sudo bluetoothd -n -d
bluetoothd[25721]: Bluetooth daemon
bluetoothd[25721]: Enabling debug information
bluetoothd[25721]: parsing main.conf
bluetoothd[25721]: discovto=0
bluetoothd[25721]: pairto=0
bluetoothd[25721]: pageto=8192
bluetoothd[25721]: name=%h-%d
bluetoothd[25721]: class=0x000100
bluetoothd[25721]: inqmode=0
bluetoothd[25721]: Key file does not have key 'DeviceID'
bluetoothd[25721]: Starting SDP server
bluetoothd[25721]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[25721]: register_interface: path /org/bluez/25721/any
bluetoothd[25721]: Registered interface org.bluez.Service on path
/org/bluez/25721/any
bluetoothd[25721]: Parsing /etc/bluetooth/network.conf failed: No such
file or directory
bluetoothd[25721]: Config options: InterfacePrefix=bnep%d,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[25721]: bridge pan0 created
bluetoothd[25721]: Parsing /etc/bluetooth/input.conf failed: No such
file or directory
bluetoothd[25721]: Unix socket created: 13
bluetoothd[25721]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[25721]: Telephony plugin initialized
bluetoothd[25721]: HFP AG features: "Ability to reject a call" "Enhanced
call status" "Extended Error Result Codes" 
bluetoothd[25721]: HCI dev 0 registered
bluetoothd[25721]: child 25724 forked
bluetoothd[25721]: Agent registered for hci0 at
:1.32:/org/bluez/agent/hci0
bluetoothd[25721]: HCI dev 0 up
bluetoothd[25721]: Starting security manager 0
bluetoothd[25721]: register_interface: path /org/bluez/25721/hci0
bluetoothd[25721]: Registered interface org.bluez.Service on path
/org/bluez/25721/hci0
bluetoothd[25721]: network_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: Adding record with handle 0x10000
bluetoothd[25721]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[25721]: register_server_record: got record id 0x10000
bluetoothd[25721]: Registered interface org.bluez.NetworkPeer on path
/org/bluez/25721/hci0
bluetoothd[25721]: network_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: Adding record with handle 0x10001
bluetoothd[25721]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[25721]: register_server_record: got record id 0x10001
bluetoothd[25721]: Registered interface org.bluez.NetworkHub on path
/org/bluez/25721/hci0
bluetoothd[25721]: network_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: Adding record with handle 0x10002
bluetoothd[25721]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[25721]: register_server_record: got record id 0x10002
bluetoothd[25721]: Registered interface org.bluez.NetworkRouter on path
/org/bluez/25721/hci0
bluetoothd[25721]: proxy_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: Registered interface org.bluez.SerialProxyManager on
path /org/bluez/25721/hci0
bluetoothd[25721]: headset_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: audio.conf: Key file does not have key 'Master'
bluetoothd[25721]: Adding record with handle 0x10003
bluetoothd[25721]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[25721]: Adding record with handle 0x10004
bluetoothd[25721]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[25721]: a2dp_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: audio.conf: Key file does not have key 'Disable'
bluetoothd[25721]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[25721]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[25721]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[25721]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[25721]: audio.conf: Key file does not have key 'Master'
bluetoothd[25721]: SEP 0x179b5b0 registered: type:0 codec:0 seid:1
bluetoothd[25721]: Adding record with handle 0x10005
bluetoothd[25721]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[25721]: avrcp_server_probe: path /org/bluez/25721/hci0
bluetoothd[25721]: audio.conf: Key file does not have key 'Master'
bluetoothd[25721]: Adding record with handle 0x10006
bluetoothd[25721]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[25721]: Adding record with handle 0x10007
bluetoothd[25721]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[25721]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[25721]: Creating device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
00001108-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: Registered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111E-0000-1000-8000-00805F9B34FB
bluetoothd[25721]: headset_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Registered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Found Headset record
bluetoothd[25721]: Discovered Headset service on RFCOMM channel 2
bluetoothd[25721]: Registered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Adapter /org/bluez/25721/hci0 has been enabled
bluetoothd[25721]: child 25724 exited
bluetoothd[25721]: Computer is classified as laptop
bluetoothd[25721]: Current device class is 0x4a010c
bluetoothd[25721]: Setting 0x00010c for major/minor device class
bluetoothd[25721]: Removing device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: input_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: create_device(00:0b:2e:85:1e:53)
bluetoothd[25721]: adapter_create_device(00:0b:2e:85:1e:53)
bluetoothd[25721]: Creating device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: error
updating services: Host is down (112)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: pin_code_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
requesting agent authentication
bluetoothd[25721]: link_key_notify (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53, type=0)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: local auth 0x00 and remote auth 0xff
bluetoothd[25721]: storing link key of type 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: setting timer for reverse service discovery
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111E-0000-1000-8000-00805F9B34FB
bluetoothd[25721]: Registered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Registered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
00001108-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: headset_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Registered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Headset record
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: Received AT+CIND=?
bluetoothd[25721]: Received AT+CIND?
bluetoothd[25721]: Received AT+CMER=3, 0, 0, 1
bluetoothd[25721]: Event reporting (CMER): mode=3, ind=1
bluetoothd[25721]: HFP Service Level Connection established
bluetoothd[25721]: telephony-dummy: device 0x179c5e8 connected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: Received AT+VGS=08
bluetoothd[25721]: telephony-dummy: device 0x179c5e8 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_DISCONNECTED
bluetoothd[25721]: Disconnected from 00:0B:2E:85:1E:53,
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: stored link key type = 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: telephony-dummy: device 0x179c5e8 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: stored link key type = 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: Removing device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Headset unregistered while device was connected!
bluetoothd[25721]: telephony-dummy: device 0x179c5e8 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[25721]: Unregistered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: input_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: No matching connection found for handle 38
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_create_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Creating device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: pin_code_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
requesting agent authentication
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
canceling authentication request
bluetoothd[25721]: Removing temporary device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Removing device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_create_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Creating device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: pin_code_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
requesting agent authentication
bluetoothd[25721]: link_key_notify (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53, type=0)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: local auth 0x00 and remote auth 0xff
bluetoothd[25721]: storing link key of type 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: setting timer for reverse service discovery
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111E-0000-1000-8000-00805F9B34FB
bluetoothd[25721]: Registered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Registered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
00001108-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: headset_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Registered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Headset record
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: Received AT+CIND=?
bluetoothd[25721]: Received AT+CIND?
bluetoothd[25721]: Received AT+CMER=3, 0, 0, 1
bluetoothd[25721]: Event reporting (CMER): mode=3, ind=1
bluetoothd[25721]: HFP Service Level Connection established
bluetoothd[25721]: telephony-dummy: device 0x17960d0 connected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: Received AT+VGS=08
bluetoothd[25721]: telephony-dummy: device 0x17960d0 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_DISCONNECTED
bluetoothd[25721]: Removing device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: input_remove: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Unregistered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_create_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Creating device
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: pin_code_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
requesting agent authentication
bluetoothd[25721]: link_key_notify (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53, type=0)
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: local auth 0x00 and remote auth 0xff
bluetoothd[25721]: storing link key of type 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: setting timer for reverse service discovery
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111E-0000-1000-8000-00805F9B34FB
bluetoothd[25721]: Registered interface org.bluez.Serial on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Registered interface org.bluez.Headset on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Probe drivers for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: serial_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
00001108-0000-1000-8000-00805f9b34fb
bluetoothd[25721]: headset_probe: path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Registered interface org.bluez.Input on path
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Found Headset record
bluetoothd[25721]: Found Handsfree record
bluetoothd[25721]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: Received AT+CIND=?
bluetoothd[25721]: Received AT+CIND?
bluetoothd[25721]: Received AT+CMER=3, 0, 0, 1
bluetoothd[25721]: Event reporting (CMER): mode=3, ind=1
bluetoothd[25721]: HFP Service Level Connection established
bluetoothd[25721]: telephony-dummy: device 0x1794b48 connected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: Received AT+VGS=08
bluetoothd[25721]: Received AT+VGS=09
bluetoothd[25721]: Received AT+VGS=11
bluetoothd[25721]: Received AT+VGS=09
bluetoothd[25721]: Received AT+VGS=07
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[25721]: Received AT+VGS=07
bluetoothd[25721]: connect(): Connection timed out (110)
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: No matching connection found for handle 42
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[25721]: Received AT+VGS=07
bluetoothd[25721]: connect(): Connection timed out (110)
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: No matching connection found for handle 42
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[25721]: Received AT+VGS=07
bluetoothd[25721]: connect(): Connection timed out (110)
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[25721]: No matching connection found for handle 42
bluetoothd[25721]: telephony-dummy: device 0x1794b48 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_DISCONNECTED
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: link_key_request (sba=00:02:5B:00:F3:00,
dba=00:0B:2E:85:1E:53)
bluetoothd[25721]: kernel auth requirements = 0x00
bluetoothd[25721]: stored link key type = 0x00
bluetoothd[25721]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[25721]: adapter_get_device(00:0B:2E:85:1E:53)
bluetoothd[25721]: hcid_dbus_bonding_process_complete: no pending auth
request
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[25721]: authorize request was sent for
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Accepted headset connection from 00:0B:2E:85:1E:53
for /org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53
bluetoothd[25721]: Received AT+BRSF=26
bluetoothd[25721]: HFP HF features: "Call waiting and 3-way calling"
"Voice recognition activation" "Remote volume control" 
bluetoothd[25721]: telephony-dummy: device 0x1794b48 disconnected
bluetoothd[25721]: State changed
/org/bluez/25721/hci0/dev_00_0B_2E_85_1E_53:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED

