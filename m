Return-Path: <cyrus@holtmann.org>
Message-ID: <40aff9180810311819p59006e48neb237afde2759ef7@mail.gmail.com>
Date: Sat, 1 Nov 2008 02:19:30 +0100
From: Fiorellino <fiorellino@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: wireless keyboard still not working after "supposedly" correct pairing
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

seems I was too quick to judge.

I realized that under Windows no led blinks when the keyboard works
properly, so I suspect there is still some problem.

Also, after the "correct" pairing happens, hcidump does not show
anything when I press keys on the keboard. I don't have anything else
as a reference, but that doesn't sound right.

Some output for debugging, if someone with more experience has the
chance to look into it.

Thanks for any hint,

alfonso

##########################
voyage:~/bluez-4.17/test# ./simple-agent hci0 00:18:00:00:78:86
##########################
Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Network is down
voyage:~/bluez-4.17/test# ./simple-agent hci0 00:18:00:00:78:86
RequestPinCode (/org/bluez/hci0/dev_00_18_00_00_78_86)
Enter PIN Code: 123456
Release
New device (/org/bluez/hci0/dev_00_18_00_00_78_86)


##########################
voyage:~# bluetoothd -nd
##########################
bluetoothd[7029]: Bluetooth daemon
bluetoothd[7029]: Enabling debug information
bluetoothd[7029]: parsing main.conf
bluetoothd[7029]: offmode=NoScan
bluetoothd[7029]: discovto=0
bluetoothd[7029]: pageto=8192
bluetoothd[7029]: name=%h-%d
bluetoothd[7029]: class=0x000100
bluetoothd[7029]: inqmode=0
bluetoothd[7029]: Starting SDP server
bluetoothd[7029]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[7029]: Parsing /etc/bluetooth/network.conf failed: No such
file or directory
bluetoothd[7029]: Config options: InterfacePrefix=bnep%d,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[7029]: bridge pan0 created
bluetoothd[7029]: Parsing /etc/bluetooth/input.conf failed: No such
file or directory
bluetoothd[7029]: Parsing /etc/bluetooth/audio.conf failed: No such
file or directory
bluetoothd[7029]: Unix socket created: 13
bluetoothd[7029]: Telephony plugin initialized
bluetoothd[7029]: HFP AG features: "Ability to reject a call"
"Enhanced call status" "Extended Error Result Codes"
bluetoothd[7029]: HCI dev 0 registered
bluetoothd[7029]: child 7035 forked
bluetoothd[7029]: HCI dev 0 already up
bluetoothd[7029]: service_probe: path /org/bluez/hci0
bluetoothd[7029]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[7029]: network_server_probe: path /org/bluez/hci0
bluetoothd[7029]: Adding record with handle 0x10000
bluetoothd[7029]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[7029]: register_server_record: got record id 0x10000
bluetoothd[7029]: Registered interface org.bluez.NetworkPeer on path
/org/bluez/hci0
bluetoothd[7029]: network_server_probe: path /org/bluez/hci0
bluetoothd[7029]: Adding record with handle 0x10001
bluetoothd[7029]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[7029]: register_server_record: got record id 0x10001
bluetoothd[7029]: Registered interface org.bluez.NetworkHub on path
/org/bluez/hci0
bluetoothd[7029]: network_server_probe: path /org/bluez/hci0
bluetoothd[7029]: Adding record with handle 0x10002
bluetoothd[7029]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[7029]: register_server_record: got record id 0x10002
bluetoothd[7029]: Registered interface org.bluez.NetworkRouter on path
/org/bluez/hci0
bluetoothd[7029]: proxy_probe: path /org/bluez/hci0
bluetoothd[7029]: Registered interface org.bluez.SerialProxyManager on
path /org/bluez/hci0
bluetoothd[7029]: headset_server_probe: path /org/bluez/hci0
bluetoothd[7029]: Adding record with handle 0x10003
bluetoothd[7029]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[7029]: Adding record with handle 0x10004
bluetoothd[7029]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[7029]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[7029]: SEP 0xb7fe8db8 registered: type:0 codec:0 seid:1
bluetoothd[7029]: Adding record with handle 0x10005
bluetoothd[7029]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[7029]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[7029]: Adding record with handle 0x10006
bluetoothd[7029]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[7029]: Adding record with handle 0x10007
bluetoothd[7029]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[7029]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[7029]: Creating device /org/bluez/hci0/dev_00_1E_37_FC_F7_99
bluetoothd[7029]: Probe drivers for /org/bluez/hci0/dev_00_1E_37_FC_F7_99
bluetoothd[7029]: serial_probe: path /org/bluez/hci0/dev_00_1E_37_FC_F7_99
bluetoothd[7029]: Registered interface org.bluez.Serial on path
/org/bluez/hci0/dev_00_1E_37_FC_F7_99
bluetoothd[7029]: adapter_get_device(00:1E:37:FC:F7:99)
bluetoothd[7029]: audio handle_uuid: server not enabled for
00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[7029]: audio handle_uuid: server not enabled for
0000110a-0000-1000-8000-00805f9b34fb (0x110a)
bluetoothd[7029]: Found Audio Sink
bluetoothd[7029]: Registered interface org.bluez.AudioSink on path
/org/bluez/hci0/dev_00_1E_37_FC_F7_99
bluetoothd[7029]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[7029]: Starting security manager 0
bluetoothd[7029]: child 7035 exited
bluetoothd[7029]: Failed to access HAL
bluetoothd[7029]: bonding_request_new(00:18:00:00:78:86)
bluetoothd[7029]: adapter_get_device(00:18:00:00:78:86)
bluetoothd[7029]: adapter_create_device(00:18:00:00:78:86)
bluetoothd[7029]: Creating device /org/bluez/hci0/dev_00_18_00_00_78_86
bluetoothd[7029]: Temporary agent registered for
hci0/00:18:00:00:78:86 at :1.62:/test/agent
bluetoothd[7029]: adapter_get_device(00:18:00:00:78:86)
bluetoothd[7029]: Hangup or error on bonding IO channel
bluetoothd[7029]: Releasing agent :1.62, /test/agent
bluetoothd[7029]: Removing device /org/bluez/hci0/dev_00_18_00_00_78_86
bluetoothd[7029]: bonding_request_new(00:18:00:00:78:86)
bluetoothd[7029]: adapter_get_device(00:18:00:00:78:86)
bluetoothd[7029]: adapter_create_device(00:18:00:00:78:86)
bluetoothd[7029]: Creating device /org/bluez/hci0/dev_00_18_00_00_78_86
bluetoothd[7029]: Temporary agent registered for
hci0/00:18:00:00:78:86 at :1.63:/test/agent
bluetoothd[7029]: adapter_get_device(00:18:00:00:78:86)
bluetoothd[7029]: link_key_request (sba=00:1B:DC:0F:74:09,
dba=00:18:00:00:78:86)
bluetoothd[7029]: kernel auth requirements = 0x00
bluetoothd[7029]: pin_code_request (sba=00:1B:DC:0F:74:09,
dba=00:18:00:00:78:86)
bluetoothd[7029]: hcid_dbus_new_auth_request
bluetoothd[7029]: link_key_notify (sba=00:1B:DC:0F:74:09, dba=00:18:00:00:78:86)
bluetoothd[7029]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[7029]: adapter_get_device(00:18:00:00:78:86)
bluetoothd[7029]: Releasing agent :1.63, /test/agent
bluetoothd[7029]: Probe drivers for /org/bluez/hci0/dev_00_18_00_00_78_86
bluetoothd[7029]: hid_device_probe: path /org/bluez/hci0/dev_00_18_00_00_78_86
bluetoothd[7029]: Registered interface org.bluez.Input on path
/org/bluez/hci0/dev_00_18_00_00_78_86

##########################
hcidump:
##########################
voyage:~/bluez-4.17/test# hcidump -r btdump.bin
HCI sniffer - Bluetooth packet analyzer ver 1.42
< HCI Command: Write Local Name (0x03|0x0013) plen 248
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
< HCI Command: Read Default Link Policy Settings (0x02|0x000e) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
> HCI Event: Command Complete (0x0e) plen 4
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
> HCI Event: Command Complete (0x0e) plen 8
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0007
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Remote Name Req Complete (0x07) plen 255
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Link Key Notification (0x18) plen 23
> HCI Event: Auth Complete (0x06) plen 3
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0041 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 137
    L2CAP(d): cid 0x0041 len 133 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x80
          count 125
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1200 (PNPInfo) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
                 uuid-16 0x0001 (SDP) > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1200 (PNPInfo) uint 0x100 > >
              aid 0x0101 (SrvDesc)
                 str "Bluetooth Keyboard"
              aid 0x0200 (VersionNumList)
                 uint 0x100
              aid 0x0201 (SrvDBState)
                 uint 0xdc6
              aid 0x0202 (unknown)
                 uint 0x3752
              aid 0x0203 (unknown)
                 uint 0x100
              aid 0x0204 (unknown)
                 bool 0x1
              aid 0x0205 (unknown)
                 uint 0x2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0043 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1124 (HID)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 367
> ACL data: handle 42 flags 0x01 dlen 100
    L2CAP(d): cid 0x0040 len 463 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x1ca
          count 455
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1124 (HID) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
                 uuid-16 0x0011 (HIDP) > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1124 (HID) uint 0x100 > >
              aid 0x000d (IconURL)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16
0x0011 (HIDP) > > >
              aid 0x0100 (SrvName)
                 str "Bluetooth Keyboard"
              aid 0x0101 (SrvDesc)
                 str "Bluetooth Keyboard"
              aid 0x0102 (ProviderName)
                 str "PSTC"
              aid 0x0200 (VersionNumList)
                 uint 0x110
              aid 0x0201 (SrvDBState)
                 uint 0x100
              aid 0x0202 (unknown)
                 uint 0x40
              aid 0x0203 (unknown)
                 uint 0x21
              aid 0x0204 (unknown)
                 bool 0x1
              aid 0x0205 (unknown)
                 bool 0x1
              aid 0x0206 (unknown)
                 < < uint 0x22 str 05 01 09 06 a1 01 05 07 85 01 19 e0
29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05
08 85 01 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 25 e7
05 07 19 00 29 e7 81 00 05 06 09 20 15 00 25 ff 75 08 95 01 85 47 b1
22 05 06 85 ff 95 01 75 02 09 24 09 26 81 02 75 06 81 01 c0 05 0c 09
01 a1 01 85 03 05 0c 15 00 25 01 0a 23 02 0a 8a 01 0a 21 02 0a 24 02
0a 25 02 0a 26 02 0a 27 02 0a 2a 02 09 b5 09 b6 09 b7 09 cd 09 e2 09
e9 09 ea 75 01 95 0f 81 02 75 01 95 01 81 01 c0 05 01 09 02 a1 01 09
01 a1 00 85 02 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01
75 05 81 03 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0
c0 > >
              aid 0x0207 (unknown)
                 < < uint 0x409 uint 0x100 > >
              aid 0x0208 (unknown)
                 bool 0x0
              aid 0x0209 (unknown)
                 bool 0x1
              aid 0x020a (unknown)
                 bool 0x1
              aid 0x020b (unknown)
                 uint 0x100
              aid 0x020c (unknown)
                 uint 0x1f40
              aid 0x020d (unknown)
                 bool 0x0
              aid 0x020e (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0044 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1203 (Audio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0044 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0044 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0045 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0045 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0045 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0045 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0046 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110e (AVRemote)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0047 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1115 (PANU)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0048 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1117 (GN)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0049 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1116 (NAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0049 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x004a len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1101 (SP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004a scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x004b len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001115-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004b scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004b scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004c flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004c flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x004c len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001117-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004c scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004d flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004d flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x004d len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001116-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004d scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004d scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004e scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004e scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004e flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004e flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x004e len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001101-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004e scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004e scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004f flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004f flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x004f len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001103-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004f scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004f scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0050 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001108-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0050 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0050 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0051 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000111e-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0052 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001112-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0052 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0052 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0053 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000111f-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0053 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0053 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0054 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000110d-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0054 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0054 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0055 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0055 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0055 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0055 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0055 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000110a-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0055 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0055 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0056 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0056 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0056 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000110b-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0056 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0056 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0057 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0057 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0057 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0057 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0057 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000110c-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0057 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0057 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0058 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0058 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0058 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0058 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0058 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 0000110e-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0058 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0058 scid 0x0041
> HCI Event: Disconn Complete (0x05) plen 4
voyage:~/bluez-4.17/test#
