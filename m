Return-Path: <cyrus@holtmann.org>
From: "Birchler, Neil" <nbirchler@staudertech.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 7 Jan 2013 09:16:38 -0600
Subject: Security Block w/ PAN Profile
Message-ID: <C9D7B43DFD01FD4A9A9201D28C5F097A01197D882D@server09>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings,

I'm working on using PAN to communicate between Android devices and an embedded system. I have successfully used BlueZ 4.60 for quite some time, but our embedded system's BSP has rolled from 4.60 to 4.98. When I try to use the same connection methodology we've been using successfully with 4.98, I get 'Security Block' errors and the PAN connection doesn't come up. I've attached the output of hcidump, as well as the syslog output with debugging turned on for bluetoothd. Any advice on where to look would be appreciated, as I'm out of ideas.

Thanks,
Neil Birchler
nbirchler@staudertech.com

hcidump output:

HCI sniffer - Bluetooth packet analyzer ver 2.5
device: hci0 snap_len: 1500 filter: 0xffffffff
2013-01-01 19:41:47.711831 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 0C:71:5D:35:35:35 class 0x5a020c type ACL
2013-01-01 19:41:47.712014 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 0C:71:5D:35:35:35 role 0x01
    Role: Slave
2013-01-01 19:41:47.721829 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2013-01-01 19:41:47.871794 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 37 bdaddr 0C:71:5D:35:35:35 type ACL encrypt 0x00
2013-01-01 19:41:47.871943 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 37
2013-01-01 19:41:47.882232 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 0C:71:5D:35:35:35 mode 0
2013-01-01 19:41:47.882430 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2013-01-01 19:41:47.901891 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5
2013-01-01 19:41:47.911813 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2013-01-01 19:41:47.921815 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 37
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
2013-01-01 19:41:47.921947 < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 37 page 1
2013-01-01 19:41:47.932331 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
2013-01-01 19:41:47.932518 > HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 37 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
2013-01-01 19:41:47.941841 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 0C:71:5D:35:35:35
2013-01-01 19:41:47.946631 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 0C:71:5D:35:35:35 key F76F28010A620BC0651BF18AE4B26B3C
2013-01-01 19:41:47.961757 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 0C:71:5D:35:35:35
2013-01-01 19:41:47.991743 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 37 encrypt 0x01
2013-01-01 19:41:48.021733 > ACL data: handle 37 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2013-01-01 19:41:48.021850 < ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0080
        Fixed Channels
2013-01-01 19:41:48.051737 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.051902 > ACL data: handle 37 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
2013-01-01 19:41:48.051977 < ACL data: handle 37 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
2013-01-01 19:41:48.061818 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.061973 > ACL data: handle 37 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
2013-01-01 19:41:48.062106 < ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
2013-01-01 19:41:48.062320 < ACL data: handle 37 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2013-01-01 19:41:48.091761 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.091925 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.101725 > ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0018
        Enhanced Retransmission mode
        Streaming mode
2013-01-01 19:41:48.101880 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 37
2013-01-01 19:41:48.102005 < ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
      Connection pending - Authentication pending
2013-01-01 19:41:48.111773 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2013-01-01 19:41:48.111941 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 0C:71:5D:35:35:35
2013-01-01 19:41:48.112969 < ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
      Connection refused - security block
2013-01-01 19:41:48.115041 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 0C:71:5D:35:35:35 key F76F28010A620BC0651BF18AE4B26B3C
2013-01-01 19:41:48.132281 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.132448 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.132569 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 0C:71:5D:35:35:35
2013-01-01 19:41:48.151736 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 37
2013-01-01 19:41:48.151877 < ACL data: handle 37 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2013-01-01 19:41:48.171738 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 37 packets 1
2013-01-01 19:41:48.171942 > ACL data: handle 37 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
      Command not understood
2013-01-01 19:41:50.221777 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 37 reason 0x13
    Reason: Remote User Terminated Connection

syslog output:
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: src/adapter.c:adapter_get_device() 0C:71:5D:35:35:35
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:remote_features_information() hci0 status 0
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() hci0 dba 0C:71:5D:35:35:35
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:get_auth_info() hci0 dba 0C:71:5D:35:35:35
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() Matching key found
Jan  1 19:41:47 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() link key type 0x05
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: network/server.c:confirm_event() BNEP: incoming connect from 0C:71:5D:35:35:35
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() hci0 dba 0C:71:5D:35:35:35
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:get_auth_info() hci0 dba 0C:71:5D:35:35:35
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() Matching key found
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:link_key_request() link key type 0x05
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:auth_complete() hci0 status 0
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:bonding_complete() status 0x00
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: src/adapter.c:adapter_get_device() 0C:71:5D:35:35:35
Jan  1 19:41:48 (none) daemon.debug bluetoothd[784]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
Jan  1 19:41:50 (none) daemon.debug bluetoothd[784]: plugins/hciops.c:disconn_complete() handle 37 status 0x00
Jan  1 19:41:50 (none) daemon.debug bluetoothd[784]: src/event.c:btd_event_disconn_complete()
Jan  1 19:41:50 (none) daemon.debug bluetoothd[784]: src/adapter.c:adapter_remove_connection()


This message is a confidential communication from Stauder Technologies. The information contained in this electronic communication, and any attachments thereto, is privileged and confidential and intended solely for use by the addressee(s). Any other use, dissemination, or copying of this electronic communication is strictly prohibited. If this was erroneously sent to you, please notify us immediately at (636) 498-6658.
