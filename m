Return-Path: <cyrus@holtmann.org>
Message-ID: <48C25730.5040100@pook.es>
Date: Sat, 06 Sep 2008 12:10:56 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez 4.2 + linux 2.6.27-rc5 -> no audio interface
References: <48BC6CEC.8040602@pook.es> <48BD97A8.1010201@pook.es>
In-Reply-To: <48BD97A8.1010201@pook.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I'm still trying to get music out of my Jabra JX10 headset using bluez 4.2 on
my machine running linux 2.6.27-rc5 (with the new btusb module).
Has anyone had any success with this setup?

When I try to play a wav file, after a 40 second timeout, bluetoothd says
"connect(): Connection timed out (110)".
aplay then says "Unable to install hw params". During this time,
according to hcidump, 12943 SCO data packets are transmitted.

Bluez 4.2 and my headset work on a 2.6.23 kernel with the sco-flowcontrol patch.

I see that bluez-4.3 has just come out.
I suppose that I should try it to see if it helps.

Has anyone any ideas on what I could be doing wrong?

thanks
Stuart



When I run "aplay -D JX10 ~/lib/alarm.wav" I see:

Playing WAVE '/home/stuart/lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: set_params:979: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: [0 0]

"hcidump | uniq -c" gives

       1 HCI sniffer - Bluetooth packet analyzer ver 1.42
       1 device: hci0 snap_len: 1028 filter: 0xffffffff
       1 < HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
       1 > HCI Event: Command Status (0x0f) plen 4
       1 < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
       1 > HCI Event: Command Complete (0x0e) plen 12
       1 < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
       1 > HCI Event: Command Complete (0x0e) plen 12
       1 < HCI Command: Read Class of Device (0x03|0x0023) plen 0
       1 > HCI Event: Command Complete (0x0e) plen 7
       1 < HCI Command: Read Local Name (0x03|0x0014) plen 0
       1 > HCI Event: Command Complete (0x0e) plen 252
       1 < HCI Command: Set Event Mask (0x03|0x0001) plen 8
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Local Name (0x03|0x0013) plen 248
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Page Timeout (0x03|0x0018) plen 2
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
       1 > HCI Event: Command Complete (0x0e) plen 4
       1 < HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
       1 > HCI Event: Command Complete (0x0e) plen 8
       1 < HCI Command: Read Class of Device (0x03|0x0023) plen 0
       1 > HCI Event: Command Complete (0x0e) plen 7
       1 < HCI Command: Create Connection (0x01|0x0005) plen 13
       1 > HCI Event: Command Status (0x0f) plen 4
       1 > HCI Event: Connect Complete (0x03) plen 11
       1 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
       1 > HCI Event: Command Status (0x0f) plen 4
       1 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
       1 > HCI Event: Max Slots Change (0x1b) plen 3
       1 > HCI Event: Command Status (0x0f) plen 4
       1 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
       1 > HCI Event: Command Status (0x0f) plen 4
       1 > HCI Event: Read Remote Supported Features (0x0b) plen 11
       1 < ACL data: handle 41 flags 0x02 dlen 10
       1     L2CAP(s): Info req: type 2
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 16
       1     L2CAP(s): Info rsp: type 2 result 0
       1       Extended feature mask 0x0000
       1 < ACL data: handle 41 flags 0x02 dlen 12
       1     L2CAP(s): Connect req: psm 3 scid 0x0040
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 16
       1     L2CAP(s): Connect rsp: dcid 0x0064 scid 0x0040 result 1 status 2
       1       Connection pending - Authorization pending
       1 > HCI Event: Remote Name Req Complete (0x07) plen 255
       1 > HCI Event: Link Key Request (0x17) plen 6
       1 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
       1 > HCI Event: Command Complete (0x0e) plen 10
       1 > ACL data: handle 41 flags 0x02 dlen 16
       1     L2CAP(s): Connect rsp: dcid 0x0064 scid 0x0040 result 0 status 0
       1       Connection successful
       1 < ACL data: handle 41 flags 0x02 dlen 16
       1     L2CAP(s): Config req: dcid 0x0064 flags 0x00 clen 4
       1       MTU 1013
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 14
       1     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       1       Success
       1 > ACL data: handle 41 flags 0x02 dlen 16
       1     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       1       MTU 1013
       1 < ACL data: handle 41 flags 0x02 dlen 18
       1     L2CAP(s): Config rsp: scid 0x0064 flags 0x00 result 0 clen 4
       1       MTU 1013
       1 < ACL data: handle 41 flags 0x02 dlen 8
       1     L2CAP(d): cid 0x0064 len 4 [psm 3]
       1       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
       2 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 8
       1     L2CAP(d): cid 0x0040 len 4 [psm 3]
       1       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
       1 < ACL data: handle 41 flags 0x02 dlen 18
       1     L2CAP(d): cid 0x0064 len 14 [psm 3]
       1       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       1       dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       1       frame_size 1008 max_retrans 0 credits 7
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 18
       1     L2CAP(d): cid 0x0040 len 14 [psm 3]
       1       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       1       dlci 4 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       1       frame_size 127 max_retrans 0 credits 0
       1 < ACL data: handle 41 flags 0x02 dlen 8
       1     L2CAP(d): cid 0x0064 len 4 [psm 3]
       1       RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > ACL data: handle 41 flags 0x02 dlen 8
       1     L2CAP(d): cid 0x0040 len 4 [psm 3]
       1       RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
       1 < ACL data: handle 41 flags 0x02 dlen 12
       1     L2CAP(d): cid 0x0064 len 8 [psm 3]
       1       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       1       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
       1 < HCI Command: Add SCO Connection (0x01|0x0007) plen 4
       1 > ACL data: handle 41 flags 0x02 dlen 12
       1     L2CAP(d): cid 0x0040 len 8 [psm 3]
       1       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       1       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
       1 < ACL data: handle 41 flags 0x02 dlen 12
       1     L2CAP(d): cid 0x0064 len 8 [psm 3]
       1       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       1       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
       2 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > HCI Event: Command Status (0x0f) plen 4
       1 > ACL data: handle 41 flags 0x02 dlen 12
       1     L2CAP(d): cid 0x0040 len 8 [psm 3]
       1       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       1       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
       1 < ACL data: handle 41 flags 0x02 dlen 9
       1     L2CAP(d): cid 0x0064 len 5 [psm 3]
       1       RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
       1 > ACL data: handle 41 flags 0x02 dlen 9
       1     L2CAP(d): cid 0x0040 len 5 [psm 3]
       1       RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 15
       1 > HCI Event: Max Slots Change (0x1b) plen 3
       1 > HCI Event: Number of Completed Packets (0x13) plen 5
       1 > HCI Event: Connect Complete (0x03) plen 11
       1 > HCI Event: Max Slots Change (0x1b) plen 3
       1 > SCO data: handle 57 flags 0x00 dlen 48
   12943 > SCO data: handle 44 flags 0x00 dlen 48
       1 < HCI Command: Disconnect (0x01|0x0006) plen 3
       3 > SCO data: handle 44 flags 0x00 dlen 48
       1 > HCI Event: Command Status (0x0f) plen 4
       7 > SCO data: handle 44 flags 0x00 dlen 48
       1 > HCI Event: Disconn Complete (0x05) plen 4
       1 > HCI Event: Max Slots Change (0x1b) plen 3

This is what bluetoothd writes into the log
(I logged the aplay command as well)

Sep  6 11:40:49 kooka bluetoothd[30154]: Bluetooth daemon
Sep  6 11:40:49 kooka bluetoothd[30154]: Enabling debug information
Sep  6 11:40:49 kooka bluetoothd[30154]: parsing main.conf
Sep  6 11:40:49 kooka bluetoothd[30154]: offmode=NoScan
Sep  6 11:40:49 kooka bluetoothd[30154]: discovto=0
Sep  6 11:40:49 kooka bluetoothd[30154]: pageto=8192
Sep  6 11:40:49 kooka bluetoothd[30154]: name=%h-%d
Sep  6 11:40:49 kooka bluetoothd[30154]: class=0x000100
Sep  6 11:40:49 kooka bluetoothd[30154]: Starting SDP server
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92f6a98
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x1
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92f8a80
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x0
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x00
Sep  6 11:40:49 kooka bluetoothd[30154]: Loading plugins /usr/local/lib/bluetooth/plugins
Sep  6 11:40:49 kooka bluetoothd[30154]: /usr/local/lib/bluetooth/plugins/audio.so
Sep  6 11:40:49 kooka bluetoothd[30154]: Unix socket created: 11
Sep  6 11:40:49 kooka bluetoothd[30154]: /usr/local/lib/bluetooth/plugins/serial.so
Sep  6 11:40:49 kooka bluetoothd[30154]: /usr/local/lib/bluetooth/plugins/network.so
Sep  6 11:40:49 kooka bluetoothd[30154]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
Sep  6 11:40:49 kooka bluetoothd[30154]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
Sep  6 11:40:49 kooka bluetoothd[30154]: bridge pan0 created
Sep  6 11:40:49 kooka bluetoothd[30154]: /usr/local/lib/bluetooth/plugins/input.so
Sep  6 11:40:49 kooka bluetoothd[30154]: input.conf: Key file does not have key 'IdleTimeout'
Sep  6 11:40:49 kooka bluetoothd[30154]: HCI dev 0 registered
Sep  6 11:40:49 kooka bluetoothd[30154]: HCI dev 0 already up
Sep  6 11:40:49 kooka bluetoothd[30154]: headset_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10000
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10000
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92fb760
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10000
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x00
Sep  6 11:40:49 kooka bluetoothd[30154]: a2dp_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: SEP 0xb92f93b8 registered: type:0 codec:0 seid:1
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10001
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10001
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92f98a0
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10001
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x08
Sep  6 11:40:49 kooka bluetoothd[30154]: avrcp_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10002
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10002
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92f95c0
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10002
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x08
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10003
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10003
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92f9d58
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10003
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x08
Sep  6 11:40:49 kooka bluetoothd[30154]: proxy_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.serial.ProxyManager on path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: network_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10004
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10004
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92fc5c0
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10004
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x0a
Sep  6 11:40:49 kooka bluetoothd[30154]: register_server_record: got record id 0x10004
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.network.Peer on path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: network_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10005
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10005
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92fcbe8
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10005
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x0a
Sep  6 11:40:49 kooka bluetoothd[30154]: register_server_record: got record id 0x10005
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.network.Hub on path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: network_server_probe: path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Couldn't find record for : 0x10006
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding record with handle 0x10006
Sep  6 11:40:49 kooka bluetoothd[30154]: Adding rec : 0xb92fd210
Sep  6 11:40:49 kooka bluetoothd[30154]: with handle : 0x10006
Sep  6 11:40:49 kooka bluetoothd[30154]: Service classes 0x0a
Sep  6 11:40:49 kooka bluetoothd[30154]: register_server_record: got record id 0x10006
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.network.Router on path /org/bluez/hci0
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
Sep  6 11:40:49 kooka bluetoothd[30154]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
Sep  6 11:40:49 kooka bluetoothd[30154]: Found Headset record
Sep  6 11:40:49 kooka bluetoothd[30154]: Discovered Headset service on RFCOMM channel 2
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.audio.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Sep  6 11:40:49 kooka bluetoothd[30154]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Sep  6 11:40:49 kooka bluetoothd[30154]: Registered interface org.bluez.input.Device on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
Sep  6 11:40:49 kooka bluetoothd[30154]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
Sep  6 11:40:49 kooka bluetoothd[30154]: Adapter /org/bluez/hci0 has been enabled
Sep  6 11:40:49 kooka bluetoothd[30154]: Starting security manager 0
Sep  6 11:40:49 kooka bluetoothd[30154]: child 30157 exited
Sep  6 11:40:49 kooka bluetoothd[30154]: child 30158 exited
Sep  6 11:40:49 kooka bluetoothd[30154]: Agent registered for hci0 at :1.24:/org/bluez/agent/hci0
Sep  6 11:45:53 kooka aplay: aplay -D JX10 /home/stuart/lib/alarm.wav
Sep  6 11:45:53 kooka bluetoothd[30154]: Accepted new client connection on unix socket (fd=20)
Sep  6 11:45:53 kooka bluetoothd[30154]: Audio API: received BT_GETCAPABILITIES_REQ
Sep  6 11:45:53 kooka bluetoothd[30154]: Audio API: sending BT_GETCAPABILITIES_RSP
Sep  6 11:45:53 kooka bluetoothd[30154]: Audio API: received BT_SETCONFIGURATION_REQ
Sep  6 11:45:53 kooka bluetoothd[30154]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
Sep  6 11:45:53 kooka bluetoothd[30154]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 2
Sep  6 11:45:53 kooka bluetoothd[30154]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Sep  6 11:45:54 kooka bluetoothd[30154]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
Sep  6 11:45:54 kooka bluetoothd[30154]: kernel auth requirements = 0x00
Sep  6 11:45:54 kooka bluetoothd[30154]: stored link key type = 0x00
Sep  6 11:45:55 kooka bluetoothd[30154]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
Sep  6 11:45:55 kooka bluetoothd[30154]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Sep  6 11:45:55 kooka bluetoothd[30154]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Sep  6 11:46:35 kooka bluetoothd[30154]: connect(): Connection timed out (110)
Sep  6 11:46:35 kooka bluetoothd[30154]: Audio API: sending BT_SETCONFIGURATION_RSP
Sep  6 11:46:35 kooka bluetoothd[30154]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Sep  6 11:46:35 kooka bluetoothd[30154]: Audio API: received BT_STREAMSTART_REQ
Sep  6 11:46:35 kooka bluetoothd[30154]: Audio API: sending BT_STREAMSTART_RSP
Sep  6 11:46:35 kooka bluetoothd[30154]: Audio API: sending BT_STREAMFD_IND
Sep  6 11:46:35 kooka bluetoothd[30154]: unix_sendmsg_fd: Bad file descriptor(9)
Sep  6 11:46:35 kooka bluetoothd[30154]: resume failed
Sep  6 11:46:35 kooka bluetoothd[30154]: Audio API: sending BT_STREAMSTART_RSP
Sep  6 11:46:35 kooka bluetoothd[30154]: Unix client disconnected (fd=20)

