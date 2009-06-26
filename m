Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2009 16:21:58 -0300
Message-ID: <2d5a2c100906261221o27f75ea7j534f69cfcaf0435a@mail.gmail.com>
Subject: another regression caused by DEFER_SETUP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This time on l2cap socket, it seems logitech freepulse headset manages
to trigger authentication and authorization at same time, to reproduce
it is simple a matter of pair the device, turn it off, remove it, turn
it on again so it attempt to connect back:


bluetoothd[7021]: AVDTP: incoming connect from 00:0D:44:83:9B:0E
bluetoothd[7021]: adapter_get_device(00:0D:44:83:9B:0E)
bluetoothd[7021]: btd_device_ref(0x525d898): ref=2
bluetoothd[7021]: Registered interface org.bluez.Audio on path
/org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E
bluetoothd[7021]: Probe drivers for /org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E
bluetoothd[7021]: audio handle_uuid: server not enabled for
0000110D-0000-1000-8000-00805F9B34FB (0x110d)
bluetoothd[7021]: authorize request was sent for
/org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E
bluetoothd[7021]: link_key_request (sba=00:19:DB:99:77:A2,
dba=00:0D:44:83:9B:0E)
bluetoothd[7021]: kernel auth requirements = 0x04
bluetoothd[7021]: pin_code_request (sba=00:19:DB:99:77:A2,
dba=00:0D:44:83:9B:0E)
bluetoothd[7021]: adapter_get_device(00:0D:44:83:9B:0E)
bluetoothd[7021]: /org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E:
requesting agent authentication
bluetoothd[7021]: Failed requesting authentication
bluetoothd[7021]: hcid_dbus_bonding_process_complete: status=06
bluetoothd[7021]: adapter_get_device(00:0D:44:83:9B:0E)
bluetoothd[7021]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[7021]: session_cb
bluetoothd[7021]: Disconnected from 00:0D:44:83:9B:0E
bluetoothd[7021]: avdtp_unref(0x5251378): ref=0
bluetoothd[7021]: avdtp_unref(0x5251378): freeing session and removing from list
bluetoothd[7021]: Removing temporary device
/org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E
bluetoothd[7021]: Removing device /org/bluez/7021/hci0/dev_00_0D_44_83_9B_0E
bluetoothd[7021]: unix_device_removed(0x52444d0)
bluetoothd[7021]: btd_device_unref(0x525d898): ref=1
bluetoothd[7021]: btd_device_unref(0x525d898): ref=0
bluetoothd[7021]: device_free(0x525d898)


2009-06-26 14:42:52.162573 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0D:44:83:9B:0E class 0x240418 type ACL
2009-06-26 14:42:52.162645 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
    bdaddr 00:0D:44:83:9B:0E role 0x00
    Role: Master
2009-06-26 14:42:52.172569 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2009-06-26 14:42:52.332546 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:0D:44:83:9B:0E role 0x00
    Role: Master
2009-06-26 14:42:52.408549 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0D:44:83:9B:0E type ACL encrypt 0x00
2009-06-26 14:42:52.408692 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 42
2009-06-26 14:42:52.410534 > HCI Event: Page Scan Repetition Mode
Change (0x20) plen 7
    bdaddr 00:0D:44:83:9B:0E mode 1
2009-06-26 14:42:52.424657 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0200
2009-06-26 14:42:52.424782 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0200 result 1 status 0
      Connection pending - No futher information available
2009-06-26 14:42:52.424789 < ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-06-26 14:42:52.430534 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 42 packets 1
2009-06-26 14:42:52.439523 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 42 packets 1
2009-06-26 14:42:52.440527 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2009-06-26 14:42:52.442529 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
2009-06-26 14:42:52.443273 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-06-26 14:42:52.443370 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0200 result 1 status 1
      Connection pending - Authentication pending
2009-06-26 14:42:52.448530 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 42 packets 1
2009-06-26 14:42:52.450527 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2009-06-26 14:42:52.450554 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:0D:44:83:9B:0E mode 2 clkoffset 0x0000
2009-06-26 14:42:52.457543 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-06-26 14:42:52.457599 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 42
2009-06-26 14:42:52.462530 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x01 0xfe 0x9b 0xf9 0x00 0x80
2009-06-26 14:42:52.468522 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2009-06-26 14:42:52.469519 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.502528 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0D:44:83:9B:0E name 'FreePulse_Wireless'
2009-06-26 14:42:52.550633 < HCI Command: Link Key Request Negative
Reply (0x01|0x000c) plen 6
    bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.554508 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.555505 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.604333 < HCI Command: PIN Code Request Negative
Reply (0x01|0x000e) plen 6
    bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.607498 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:0D:44:83:9B:0E
2009-06-26 14:42:52.608512 > HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 42
    Error: PIN or Key Missing
2009-06-26 14:42:52.608590 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0200 result 3 status 0
      Connection refused - security block
2009-06-26 14:42:52.612512 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 42 packets 1
2009-06-26 14:42:53.835302 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection

[73743.872434] __l2cap_chan_add: conn f6974e40, psm 0x19, dcid 0x0200
[73743.872440] l2cap_sock_set_timer: sk c5d69a00 state 2 timeout 10000
[73743.872447] l2cap_build_cmd: conn f6974e40, code 0x03, ident 0x01, len 8
[73743.872453] l2cap_send_cmd: code 0x03
[73743.872460] l2cap_build_cmd: conn f6974e40, code 0x0a, ident 0x01, len 2
[73743.872466] l2cap_send_cmd: code 0x0a
[73743.890995] l2cap_recv_acldata: conn f6974e40 len 16 flags 0x2
[73743.891005] l2cap_recv_frame: len 12, cid 0x0001
[73743.891013] l2cap_raw_recv: conn f6974e40
[73743.891020] l2cap_sig_channel: code 0x0b len 8 id 0x01
[73743.891027] l2cap_information_rsp: type 0x0002 result 0x00
[73743.891034] l2cap_conn_start: conn f6974e40
[73743.891047] l2cap_build_cmd: conn f6974e40, code 0x03, ident 0x01, len 8
[73743.891056] l2cap_send_cmd: code 0x03
[73743.892372] l2cap_sock_accept: sk f6725400 timeo 0
[73743.892384] l2cap_sock_accept: new socket c5d69a00
[73743.895806] l2cap_sock_getsockopt: sk c5d69a00
[73743.895811] l2cap_sock_getsockopt_old: sk c5d69a00
[73743.895838] l2cap_sock_getname: sock f40dfc00, sk c5d69a00
[73743.895862] l2cap_sock_getname: sock f40dfc00, sk c5d69a00
[73743.910266] l2cap_connect_cfm: hcon f5a29e00 bdaddr
0E:9B:83:44:0D:00 status 0
[73743.910275] l2cap_conn_ready: conn f6974e40
[73744.056247] l2cap_security_cfm: conn f6974e40
[73744.056256] l2cap_sock_set_timer: sk c5d69a00 state 8 timeout 25
[73744.056264] l2cap_build_cmd: conn f6974e40, code 0x03, ident 0x01, len 8
[73744.056271] l2cap_send_cmd: code 0x03
[73744.156512] l2cap_sock_timeout: sock c5d69a00 state 8
[73744.156517] __l2cap_sock_close: sk c5d69a00 state 8 socket f40dfc00
[73744.156520] l2cap_sock_clear_timer: sock c5d69a00 state 8
[73744.156523] l2cap_chan_del: sk c5d69a00, conn f6974e40, err 110
[73744.159286] l2cap_sock_release: sock f40dfc00, sk c5d69a00
[73744.159291] l2cap_sock_shutdown: sock f40dfc00, sk c5d69a00
[73744.159294] l2cap_sock_clear_timer: sock c5d69a00 state 9
[73744.159297] __l2cap_sock_close: sk c5d69a00 state 9 socket f40dfc00
[73744.159301] l2cap_sock_kill: sk c5d69a00 state 9
[73744.159304] l2cap_sock_destruct: sk c5d69a00
[73745.283036] l2cap_disconn_cfm: hcon f5a29e00 reason 19
[73745.283042] l2cap_conn_del: hcon f5a29e00 conn f6974e40, err 104


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
