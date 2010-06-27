Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jun 2010 17:17:12 +0200
From: clemens fischer <ino-news@spott.ath.cx>
To: linux-bluetooth@vger.kernel.org
Subject: obexd: cannot object-push certain files (large, w/ logs)
Message-ID: <20100627151712.GA4427@spotteswoode.de.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'uname -rims' -> Linux 2.6.34-spott i686 AuthenticAMD, obexd-0.28

I cannot send certain files from my nokia-3650 cell phone to the linux
PC.  I first thought they were too big with a bit less than 200kB, but
bigger files transfer fine.  The problem is reproducable.  The file in
question is Contacts.cdb, 171.8kB in size.  I have the feeling that it
has to do with the type of file sent, but I have no idea what and where
to check.  The files that work can be sent over and over without
problems, the ones that don't never do.

Here's the debug output from obexd:

  0 3 # /l/libexec/obexd -nd -r /home/toor/mobile/nokia-niels/obex/ -a -o
  obexd[8159]: Enabling debug information
  obexd[8159]: manager_init:
  obexd[8159]: Loading builtin plugins
  obexd[8159]: driver 0x805f554 transport bluetooth registered
  obexd[8159]: Plugin bluetooth loaded
  obexd[8159]: driver 0x805f570 transport usb registered
  obexd[8159]: Plugin usb loaded
  obexd[8159]: driver 0x805f5a0 mimetype x-obex/folder-listing registered
  obexd[8159]: driver 0x805f5e0 mimetype x-obex/capability registered
  obexd[8159]: driver 0x805f660 mimetype x-obex/folder-listing registered
  obexd[8159]: driver 0x805f620 mimetype (null) registered
  obexd[8159]: Plugin filesystem loaded
  obexd[8159]: driver 0x805f6c0 mimetype application/vnd.nokia-backup registered
  obexd[8159]: Plugin backup loaded
  obexd[8159]: driver 0x805f720 service Object Push server registered
  obexd[8159]: Plugin opp loaded
  obexd[8159]: driver 0x805f780 service File Transfer server registered
  obexd[8159]: driver 0x805f7c0 service Nokia OBEX PC Suite Services registered
  obexd[8159]: Plugin ftp loaded
  obexd[8159]: driver 0x805f860 mimetype x-bt/phonebook registered
  obexd[8159]: driver 0x805f8a0 mimetype x-bt/vcard-listing registered
  obexd[8159]: driver 0x805f8e0 mimetype x-bt/vcard registered
  obexd[8159]: driver 0x805f820 service Phonebook Access server registered
  obexd[8159]: Plugin pbap loaded
  obexd[8159]: driver 0x805f980 mimetype (null) registered
  obexd[8159]: driver 0x805f940 service OBEX server for SyncML, using SyncEvolution registered
  obexd[8159]: Plugin syncevolution loaded
  obexd[8159]: Loading plugins /opt/obexd/0.28/lib/obex/plugins
  obexd[8159]: bluetooth: listening on channel 9
  obexd[8159]: bluetooth: FindAdapter(any)
  obexd[8159]: bluetooth: Registered: Object Push server, handle: 0x10009
  obexd[8159]: bluetooth: New connection from: 00:60:57:77:21:E1, channel 9
  obexd[8159]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
  obexd[8159]: REQ(0x2), CONNECT(0x0), (null)(0x0)
  obexd[8159]: Version: 0x10. Flags: 0x00  OBEX packet length: 2044
  obexd[8159]: Resizing stream chunks to 1844
  obexd[8159]: Selected driver: Object Push server
  obexd[8159]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
  obexd[8159]: obex_handle_input: poll event HUP ERR
  ^Cobexd[8159]: Terminating due to signal 2
  obexd[8159]: Cleanup plugins
  obexd[8159]: driver 0x805f554 transport bluetooth unregistered
  obexd[8159]: driver 0x805f570 transport usb unregistered
  obexd[8159]: driver 0x805f5a0 mimetype x-obex/folder-listing unregistered
  obexd[8159]: driver 0x805f5e0 mimetype x-obex/capability unregistered
  obexd[8159]: driver 0x805f620 mimetype (null) unregistered
  obexd[8159]: driver 0x805f6c0 mimetype application/vnd.nokia-backup unregistered
  obexd[8159]: driver 0x805f720 service Object Push server unregistered
  obexd[8159]: driver 0x805f780 service File Transfer server unregistered
  obexd[8159]: driver 0x805f7c0 service Nokia OBEX PC Suite Services unregistered
  obexd[8159]: driver 0x805f820 service Phonebook Access server unregistered
  obexd[8159]: driver 0x805f860 mimetype x-bt/phonebook unregistered
  obexd[8159]: driver 0x805f8a0 mimetype x-bt/vcard-listing unregistered
  obexd[8159]: driver 0x805f8e0 mimetype x-bt/vcard unregistered
  obexd[8159]: driver 0x805f940 service OBEX server for SyncML, using SyncEvolution unregistered
  obexd[8159]: driver 0x805f980 mimetype (null) unregistered
  obexd[8159]: manager_cleanup:

And here's the packet trace from hcidump:

  16:56:13 + exec /command/chpst -v -m 11333000 /usr/sbin/hcidump -i hci0 -a -V
  16:58:30 HCI sniffer - Bluetooth packet analyzer ver 1.42
  16:58:30 device: hci0 snap_len: 1028 filter: 0xffffffff
  16:58:30 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
  16:58:30     class 0x5a0104
  16:58:30 > HCI Event: Command Complete (0x0e) plen 4
  16:58:30     Write Class of Device (0x03|0x0024) ncmd 1
  16:58:30     status 0x00
  16:58:30 < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
  16:58:30     fec 0x00
  16:58:30     Complete local name: 'spotteswoode.dnsalias.org-0'
  16:58:30     Complete service classes: 0x1115 0x1117 0x1116 0x1112 0x111f 0x110a 0x110c 0x110e 0x1103 0x1105
  16:58:30 > HCI Event: Command Complete (0x0e) plen 4
  16:58:30     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
  16:58:30     status 0x00
  16:58:36 > HCI Event: Connect Request (0x04) plen 10
  16:58:36     bdaddr 00:60:57:77:21:E1 class 0x500204 type ACL
  16:58:36 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  16:58:36     bdaddr 00:60:57:77:21:E1 role 0x00
  16:58:36     Role: Master
  16:58:36 > HCI Event: Command Status (0x0f) plen 4
  16:58:36     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
  16:58:36 > HCI Event: Role Change (0x12) plen 8
  16:58:36     status 0x00 bdaddr 00:60:57:77:21:E1 role 0x00
  16:58:36     Role: Master
  16:58:36 > HCI Event: Connect Complete (0x03) plen 11
  16:58:36     status 0x00 handle 38 bdaddr 00:60:57:77:21:E1 type ACL encrypt 0x00
  16:58:36 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  16:58:36     handle 38
  16:58:36 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  16:58:36     bdaddr 00:60:57:77:21:E1 mode 1
  16:58:36 > HCI Event: Command Status (0x0f) plen 4
  16:58:36     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
  16:58:36 > HCI Event: Max Slots Change (0x1b) plen 3
  16:58:36     handle 38 slots 5
  16:58:36 > HCI Event: Command Status (0x0f) plen 4
  16:58:36     Unknown (0x00|0x0000) status 0x00 ncmd 1
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:36     L2CAP(s): Connect req: psm 1 scid 0x012a
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 16
  16:58:36     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x012a result 1 status 0
  16:58:36       Connection pending - No futher information available
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 10
  16:58:36     L2CAP(s): Info req: type 2
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 > HCI Event: Read Remote Supported Features (0x0b) plen 11
  16:58:36     status 0x00 handle 38
  16:58:36     Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
  16:58:36 > HCI Event: QoS Setup Complete (0x0d) plen 21
  16:58:36     status 0x00 handle 38 flags 0
  16:58:36     Service type: 1
  16:58:36     Token rate: 0
  16:58:36     Peak bandwith: 0
  16:58:36     Latency: 5000
  16:58:36     Delay variation: -1
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 10
  16:58:36     L2CAP(s): Command rej: reason 0
  16:58:36       Command not understood
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 16
  16:58:36     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x012a result 0 status 0
  16:58:36       Connection successful
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
  16:58:36     bdaddr 00:60:57:77:21:E1 mode 2 clkoffset 0x0000
  16:58:36 > HCI Event: Command Status (0x0f) plen 4
  16:58:36     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:36     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 18
  16:58:36     L2CAP(s): Config rsp: scid 0x012a flags 0x00 result 0 clen 4
  16:58:36       MTU 672
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 12
  16:58:36     L2CAP(s): Config req: dcid 0x012a flags 0x00 clen 0
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 14
  16:58:36     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
  16:58:36       Success
  16:58:36 > HCI Event: Remote Name Req Complete (0x07) plen 255
  16:58:36     status 0x00 bdaddr 00:60:57:77:21:E1 name 'ino_waiting>'
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 17
  16:58:36     L2CAP(d): cid 0x0040 len 13 [psm 1]
  16:58:36         SDP SS Req: tid 0x1 len 0x8
  16:58:36           pat uuid-16 0x1105 (OBEXObjPush)
  16:58:36           max 65535
  16:58:36           cont 00
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 18
  16:58:36     L2CAP(d): cid 0x012a len 14 [psm 1]
  16:58:36         SDP SS Rsp: tid 0x1 len 0x9
  16:58:36           count 1
  16:58:36           handle 0x10009
  16:58:36           cont 00
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:36 > ACL data: handle 38 flags 0x02 dlen 21
  16:58:36     L2CAP(d): cid 0x0040 len 17 [psm 1]
  16:58:36         SDP SA Req: tid 0x2 len 0xc
  16:58:36           handle 0x10009
  16:58:36           max 1024
  16:58:36           aid(s) 0x0004 (ProtocolDescList)
  16:58:36           cont 00
  16:58:36 < ACL data: handle 38 flags 0x02 dlen 36
  16:58:36     L2CAP(d): cid 0x012a len 32 [psm 1]
  16:58:36         SDP SA Rsp: tid 0x2 len 0x1b
  16:58:36           count 24
  16:58:36           aid 0x0004 (ProtocolDescList)
  16:58:36              < < uuid-16 0x0100 (L2CAP) > <
  16:58:36              uuid-16 0x0003 (RFCOMM) uint 0x9 > <
  16:58:36              uuid-16 0x0008 (OBEX) > >
  16:58:36           cont 00
  16:58:36 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:36     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(s): Connect req: psm 3 scid 0x012b
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 16
  16:58:37     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x012b result 0 status 0
  16:58:37       Connection successful
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 18
  16:58:37     L2CAP(s): Config rsp: scid 0x012b flags 0x00 result 0 clen 4
  16:58:37       MTU 672
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 16
  16:58:37     L2CAP(s): Config req: dcid 0x012b flags 0x00 clen 4
  16:58:37       MTU 1013
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 18
  16:58:37     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
  16:58:37       MTU 1013
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x0041 len 4 [psm 3]
  16:58:37       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x012b len 4 [psm 3]
  16:58:37       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 18
  16:58:37     L2CAP(d): cid 0x0041 len 14 [psm 3]
  16:58:37       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
  16:58:37       dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0
  16:58:37       frame_size 667 max_retrans 0 credits 3
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 18
  16:58:37     L2CAP(d): cid 0x012b len 14 [psm 3]
  16:58:37       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
  16:58:37       dlci 18 frame_type 0 credit_flow 14 pri 0 ack_timer 0
  16:58:37       frame_size 667 max_retrans 0 credits 7
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x0041 len 4 [psm 3]
  16:58:37       RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x012b len 4 [psm 3]
  16:58:37       RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(d): cid 0x012b len 8 [psm 3]
  16:58:37       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
  16:58:37       dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(d): cid 0x0041 len 8 [psm 3]
  16:58:37       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
  16:58:37       dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(d): cid 0x012b len 8 [psm 3]
  16:58:37       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
  16:58:37       dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:37     L2CAP(d): cid 0x0041 len 8 [psm 3]
  16:58:37       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
  16:58:37       dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 9
  16:58:37     L2CAP(d): cid 0x012b len 5 [psm 3]
  16:58:37       RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 33
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 16
  16:58:37     L2CAP(d): cid 0x0041 len 12 [psm 3]
  16:58:37       RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 7 fcs 0xd2 credits 4
  16:58:37         OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 2044
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 15
  16:58:37     L2CAP(d): cid 0x012b len 11 [psm 3]
  16:58:37       RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 7 fcs 0x14
  16:58:37         OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 32767
  16:58:37         Status 200 = Success
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:37 > ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x0041 len 4 [psm 3]
  16:58:37       RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
  16:58:37 < ACL data: handle 38 flags 0x02 dlen 8
  16:58:37     L2CAP(d): cid 0x012b len 4 [psm 3]
  16:58:37       RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
  16:58:37 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:37     handle 38 packets 1
  16:58:39 < ACL data: handle 38 flags 0x02 dlen 8
  16:58:39     L2CAP(d): cid 0x012b len 4 [psm 3]
  16:58:39       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
  16:58:39 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:39     handle 38 packets 1
  16:58:39 > ACL data: handle 38 flags 0x02 dlen 8
  16:58:39     L2CAP(d): cid 0x0041 len 4 [psm 3]
  16:58:39       RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
  16:58:39 < ACL data: handle 38 flags 0x02 dlen 12
  16:58:39     L2CAP(s): Disconn req: dcid 0x012b scid 0x0041
  16:58:39 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:39     handle 38 packets 1
  16:58:39 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:39     L2CAP(s): Disconn rsp: dcid 0x012b scid 0x0041
  16:58:41 > ACL data: handle 38 flags 0x02 dlen 12
  16:58:41     L2CAP(s): Disconn req: dcid 0x0040 scid 0x012a
  16:58:41 < ACL data: handle 38 flags 0x02 dlen 12
  16:58:41     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x012a
  16:58:41 > HCI Event: Number of Completed Packets (0x13) plen 5
  16:58:41     handle 38 packets 1
  16:58:45 < HCI Command: Disconnect (0x01|0x0006) plen 3
  16:58:45     handle 38 reason 0x13
  16:58:45     Reason: Remote User Terminated Connection
  16:58:45 > HCI Event: Command Status (0x0f) plen 4
  16:58:45     Disconnect (0x01|0x0006) status 0x00 ncmd 1
  16:58:45 > HCI Event: Disconn Complete (0x05) plen 4
  16:58:45     status 0x00 handle 38 reason 0x16
  16:58:45     Reason: Connection Terminated by Local Host
  16:58:49 < HCI Command: Write Class of Device (0x03|0x0024) plen 3
  16:58:49     class 0x4a0104
  16:58:49 > HCI Event: Command Complete (0x0e) plen 4
  16:58:49     Write Class of Device (0x03|0x0024) ncmd 1
  16:58:49     status 0x00
  16:58:49 < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
  16:58:49     fec 0x00
  16:58:49     Complete local name: 'spotteswoode.dnsalias.org-0'
  16:58:49     Complete service classes: 0x1115 0x1117 0x1116 0x1112 0x111f 0x110a 0x110c 0x110e 0x1103
  16:58:49 > HCI Event: Command Complete (0x0e) plen 4
  16:58:49     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
  16:58:49     status 0x00


regards, clemens fischer
