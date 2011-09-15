Return-Path: <cyrus@holtmann.org>
Message-ID: <A1F341EDB6154320803F3B7B5C275DDB@alexm>
From: "Alex Mach" <alexvm12e@mail.ru>
To: <linux-bluetooth@vger.kernel.org>
Subject: obexd: obex_handle_input: poll event HUP ERR
Date: Thu, 15 Sep 2011 11:43:51 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a problem with receiving files with obexd. After it receives
header (file name etc.) it hangs up the connection with
obex_handle_input: poll event HUP ERR
bluez-4.95kernel-2.6.38.7 armv5tejl 
GNU/Linuxlibopenobex1-1.5obexd-0.42/usr/sbin/obexd --auto-accept --root=/var/obex 
 -d -nobexd[844]: obexd daemon 0.42obexd[844]: src/main.c:main() Entering 
main loopobexd[844]: src/manager.c:manager_init() obexd[844]: 
src/plugin.c:plugin_init() Loading builtin pluginsobexd[844]: 
src/transport.c:obex_transport_driver_register() driver 0x37a00 transport 
bluetooth registeredobexd[844]: src/plugin.c:add_plugin() Plugin bluetooth 
loadedobexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 
0x37a94 mimetype x-obex/folder-listing registeredobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37a58 mimetype 
x-obex/capability registeredobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37ad0 mimetype 
x-obex/folder-listing registeredobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37a1c mimetype 
(null) registeredobexd[844]: src/plugin.c:add_plugin() Plugin filesystem 
loadedobexd[844]: src/service.c:obex_service_driver_register() driver 
0x37b18 service Object Push server registeredobexd[844]: 
src/plugin.c:add_plugin() Plugin opp loadedobexd[844]: 
src/service.c:obex_service_driver_register() driver 0x37b64 service File 
Transfer server registeredobexd[844]: src/plugin.c:add_plugin() Plugin ftp 
loadedobexd[844]: src/mimetype.c:obex_mime_type_driver_register() driver 
0x37bf0 mimetype x-bt/phonebook registeredobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37c2c mimetype 
x-bt/vcard-listing registeredobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37c68 mimetype 
x-bt/vcard registeredobexd[844]: 
src/service.c:obex_service_driver_register() driver 0x37bb0 service 
Phonebook Access server registeredobexd[844]: src/plugin.c:add_plugin() 
Plugin pbap loadedobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37cf0 mimetype 
(null) registeredobexd[844]: src/service.c:obex_service_driver_register() 
driver 0x37cb0 service Message Access server registeredobexd[844]: 
src/plugin.c:add_plugin() Plugin mas loadedobexd[844]: 
plugins/irmc.c:irmc_init()obexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37d3c mimetype 
(null) registeredobexd[844]: src/service.c:obex_service_driver_register() 
driver 0x37d78 service IRMC Sync server registeredobexd[844]: 
src/plugin.c:add_plugin() Plugin irmc loadedobexd[844]: 
src/mimetype.c:obex_mime_type_driver_register() driver 0x37dc4 mimetype 
(null) registeredobexd[844]: src/service.c:obex_service_driver_register() 
driver 0x37e00 service OBEX server for SyncML, using SyncEvolution 
registeredobexd[844]: src/plugin.c:add_plugin() Plugin syncevolution 
loadedobexd[844]: src/plugin.c:plugin_init() Loading plugins 
/var/buildroot-2011.05/output/staging/usr/lib/obex/pluginsobexd[844]: 
plugins/bluetooth.c:start() listening on channel 9obexd[844]: 
plugins/bluetooth.c:start() listening on channel 10obexd[844]: 
src/server.c:obex_server_init() No service driver registeredobexd[844]: 
plugins/bluetooth.c:start() listening on channel 15obexd[844]: 
plugins/bluetooth.c:start() listening on channel 14obexd[844]: 
plugins/bluetooth.c:start() listening on channel 19obexd[844]: 
plugins/bluetooth.c:start() listening on channel 16obexd[844]: 
plugins/bluetooth.c:find_adapter() FindAdapter(any)obexd[844]: 
plugins/bluetooth.c:add_record_reply() Registered: Object Push server, 
handle: 0x10005obexd[844]: plugins/bluetooth.c:add_record_reply() 
Registered: File Transfer server, handle: 0x10006obexd[844]: 
plugins/bluetooth.c:add_record_reply() Registered: Phonebook Access server, 
handle: 0x10007obexd[844]: plugins/bluetooth.c:add_record_reply() 
Registered: IRMC Sync server, handle: 0x10008obexd[844]: 
plugins/bluetooth.c:add_record_reply() Registered: OBEX server for SyncML, 
using SyncEvolution, handle: 0x10009obexd[844]: 
plugins/bluetooth.c:add_record_reply() Registered: Message Access server, 
handle: 0x1000aobexd[844]: bluetooth: New connection from: 
04:A8:2A:36:D5:0C, channel 9obexd[844]: REQHINT(0x1), CONNECT(0x0), 
(null)(0x0)obexd[844]: REQ(0x2), CONNECT(0x0), (null)(0x0)obexd[844]: 
src/obex.c:cmd_connect() Version: 0x10. Flags: 0x00 OBEX packet length: 
32767obexd[844]: src/obex.c:cmd_connect() Resizing stream chunks to 
32567obexd[844]: src/obex.c:cmd_connect() Selected driver: Object Push 
serverobexd[844]: REQ(0x2), CONNECT(0x0), CONTINUE(0x10)obexd[844]: 
REQDONE(0x3), CONNECT(0x0), (null)(0x0)obexd[844]: REQHINT(0x1), PUT(0x2), 
(null)(0x0)obexd[844]: REQCHECK(0xb), PUT(0x2), (null)(0x0)obexd[844]: 
src/obex.c:check_put() OBEX_HDR_NAME: (null)obexd[844]: 
src/obex.c:check_put() OBEX_HDR_LENGTH: 6718obexd[844]: 
src/obex.c:check_put() OBEX_HDR_TYPE: audio/midiobexd[844]: REQDONE(0x3), 
PUT(0x2), (null)(0x0)obexd[844]: obex_handle_input: poll event HUP 
ERRobexd[844]: src/obex.c:obex_handle_destroy()obexd[844]: Terminating due 
to signal 2# hcidump hci0HCI sniffer - Bluetooth packet analyzer ver 
2.1device: hci0 snap_len: 1028 filter: 0xffffffff > HCI Event: Connect 
Request (0x04) plen 10 bdaddr xx:xx:xx:xx:xx:xx class 0x520204 type ACL< HCI 
Command: Accept Connection Request (0x01|0x0009) plen 7bdaddr 
xx:xx:xx:xx:xx:xx role 0x00 Role: Master > HCI Event: Command Status (0x0f) 
plen 4 Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1> HCI 
Event: Role Change (0x12) plen 8 status 0x00 bdaddr xx:xx:xx:xx:xx:xx role 
0x00 Role: Master > HCI Event: Connect Complete (0x03) plen 11 status 0x00 
handle 42 bdaddr xx:xx:xx:xx:xx:xx type ACL encrypt 0x00< HCI Command: Read 
Remote Supported Features (0x01|0x001b) plen 2 handle 42 > HCI Event: Page 
Scan Repetition Mode Change (0x20) plen 7 bdaddr 04:A8:2A:36:D5:0C mode 1 > 
HCI Event: Command Status (0x0f) plen 4 Read Remote Supported Features 
(0x01|0x001b) status 0x00 ncmd 0 > HCI Event: Max Slots Change (0x1b) plen 3 
handle 42 slots 5 > HCI Event: Command Status (0x0f) plen 4 Unknown 
(0x00|0x0000) status 0x00 ncmd 1 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11 status 0x00 handle 42 Features: 0xbf 0xee 0x0f 0xce 0x98 0xbf 
0x59 0x83 < HCI Command: Remote Name Request (0x01|0x0019) plen 10 bdaddr 
xx:xx:xx:xx:xx:xx mode 2 clkoffset 0x0000 > HCI Event: Command Status (0x0f) 
plen 4 Remote Name Request (0x01|0x0019) status 0x00 ncmd 1 > ACL data: 
handle 42 flags 0x02 dlen 12 L2CAP(s): Connect req: psm 1 scid 0x0040 < ACL 
data: handle 42 flags 0x02 dlen 16 L2CAP(s): Connect rsp: dcid 0x0040 scid 
0x0040 result 1 status 0 Connection pending - No futher information 
available < ACL data: handle 42 flags 0x02 dlen 10 L2CAP(s): Info req: type 
2 > HCI Event: Remote Name Req Complete (0x07) plen 255 status 0x00 bdaddr 
xx:xx:xx:xx:xx:xx name 'C2-00' > HCI Event: Number of Completed Packets 
(0x13) plen 5 handle 42 packets 1 > HCI Event: Number of Completed Packets 
(0x13) plen 5 handle 42 packets 1 > ACL data: handle 42 flags 0x02 dlen 16 
L2CAP(s): Info rsp: type 2 result 0 Extended feature mask 0x0000 < ACL data: 
handle 42 flags 0x02 dlen 16 L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 
result 0 status 0 Connection successful < ACL data: handle 42 flags 0x02 
dlen 12 L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 > HCI Event: 
Number of Completed Packets (0x13) plen 5 handle 42 packets 1 > HCI Event: 
Number of Completed Packets (0x13) plen 5 handle 42 packets 1 > ACL data: 
handle 42 flags 0x02 dlen 16 L2CAP(s): Config req: dcid 0x0040 flags 0x00 
clen 4 MTU 65535 < ACL data: handle 42 flags 0x02 dlen 18 L2CAP(s): Config 
rsp: scid 0x0040 flags 0x00 result 0 clen 4 MTU 65535 > ACL data: handle 42 
flags 0x02 dlen 14 L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 
clen 0 Success > HCI Event: Number of Completed Packets (0x13) plen 5 handle 
42 packets 1 > ACL data: handle 42 flags 0x02 dlen 17 L2CAP(d): cid 0x0040 
len 13 [psm 1] SDP SS Req: tid 0x3 len 0x8 pat uuid-16 0x1105 (OBEXObjPush) 
max 255 cont 00 < ACL data: handle 42 flags 0x02 dlen 18 L2CAP(d): cid 
0x0040 len 14 [psm 1] SDP SS Rsp: tid 0x3 len 0x9 count 1 handle 0x10005 
cont 00 > HCI Event: Number of Completed Packets (0x13) plen 5 handle 42 
packets 1 > ACL data: handle 42 flags 0x02 dlen 24 L2CAP(d): cid 0x0040 len 
20 [psm 1] SDP SA Req: tid 0x4 len 0xf handle 0x10005 max 65435 aid(s) 
0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) cont 00 < ACL data: handle 
42 flags 0x02 dlen 44 L2CAP(d): cid 0x0040 len 40 [psm 1] SDP SA Rsp: tid 
0x4 len 0x23 count 32 aid 0x0001 (SrvClassIDList) < uuid-16 0x1105 
(OBEXObjPush) > aid 0x0004 (ProtocolDescList) < < uuid-16 0x0100 (L2CAP) > < 
uuid-16 0x0003 (RFCOMM) uint 0x9 > < uuid-16 0x0008 (OBEX) > > cont 00 > HCI 
Event: Number of Completed Packets (0x13) plen 5 handle 42 packets 1 > ACL 
data: handle 42 flags 0x02 dlen 12 L2CAP(s): Disconn req: dcid 0x0040 scid 
0x0040 < ACL data: handle 42 flags 0x02 dlen 12 L2CAP(s): Disconn rsp: dcid 
0x0040 scid 0x0040 > HCI Event: Number of Completed Packets (0x13) plen 5 
handle 42 packets 1 > ACL data: handle 42 flags 0x02 dlen 12 L2CAP(s): 
Connect req: psm 3 scid 0x0040 < ACL data: handle 42 flags 0x02 dlen 16 
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0 Connection 
successful < ACL data: handle 42 flags 0x02 dlen 16 L2CAP(s): Config req: 
dcid 0x0040 flags 0x00 clen 4 MTU 1013 > HCI Event: Number of Completed 
Packets (0x13) plen 5 handle 42 packets 1 > HCI Event: Number of Completed 
Packets (0x13) plen 5 handle 42 packets 1 > ACL data: handle 42 flags 0x02 
dlen 16 L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4 MTU 32772 < ACL 
data: handle 42 flags 0x02 dlen 18 L2CAP(s): Config rsp: scid 0x0040 flags 
0x00 result 0 clen 4 MTU 32772 > ACL data: handle 42 flags 0x02 dlen 18 
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 MTU 1013 > HCI 
Event: Number of Completed Packets (0x13) plen 5 handle 42 packets 1 > ACL 
data: handle 42 flags 0x02 dlen 8 L2CAP(d): cid 0x0040 len 4 [psm 3] 
RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c < ACL data: handle 42 
flags 0x02 dlen 8 L2CAP(d): cid 0x0040 len 4 [psm 3] RFCOMM(s): UA: cr 1 
dlci 0 pf 1 ilen 0 fcs 0xd7 > HCI Event: Number of Completed Packets (0x13) 
plen 5 handle 42 packets 1 > ACL data: handle 42 flags 0x02 dlen 18 
L2CAP(d): cid 0x0040 len 14 [psm 3] RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 
10 fcs 0x70 mcc_len 8 dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0 
frame_size 1008 max_retrans 0 credits 0 < ACL data: handle 42 flags 0x02 
dlen 18 L2CAP(d): cid 0x0040 len 14 [psm 3] RFCOMM(s): PN RSP: cr 0 dlci 0 
pf 0 ilen 10 fcs 0xaa mcc_len 8 dlci 18 frame_type 0 credit_flow 14 pri 0 
ack_timer 0 frame_size 1008 max_retrans 0 credits 7 > HCI Event: Number of 
Completed Packets (0x13) plen 5 handle 42 packets 1 > ACL data: handle 42 
flags 0x02 dlen 8 L2CAP(d): cid 0x0040 len 4 [psm 3] RFCOMM(s): SABM: cr 1 
dlci 18 pf 1 ilen 0 fcs 0x32 < ACL data: handle 42 flags 0x02 dlen 8 
L2CAP(d): cid 0x0040 len 4 [psm 3] RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 
fcs 0xf9 < ACL data: handle 42 flags 0x02 dlen 12 L2CAP(d): cid 0x0040 len 8 
[psm 3] RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2 dlci 
18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 > HCI Event: Number of 
Completed Packets (0x13) plen 5 handle 42 packets 1 > HCI Event: Number of 
Completed Packets (0x13) plen 5 handle 42 packets 1 > ACL data: handle 42 
flags 0x02 dlen 12 L2CAP(d): cid 0x0040 len 8 [psm 3] RFCOMM(s): MSC CMD: cr 
1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 
b1 1 b2 1 b3 0 len 0 < ACL data: handle 42 flags 0x02 dlen 12 L2CAP(d): cid 
0x0040 len 8 [psm 3] RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa 
mcc_len 2 dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0 > ACL 
data: handle 42 flags 0x02 dlen 12 L2CAP(d): cid 0x0040 len 8 [psm 3] 
RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 dlci 18 fc 0 
rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 < ACL data: handle 42 flags 0x02 
dlen 9 L2CAP(d): cid 0x0040 len 5 [psm 3] RFCOMM(d): UIH: cr 0 dlci 18 pf 1 
ilen 0 fcs 0x8 credits 33 > HCI Event: Number of Completed Packets (0x13) 
plen 5 handle 42 packets 1 > HCI Event: Number of Completed Packets (0x13) 
plen 5 handle 42 packets 1 > ACL data: handle 42 flags 0x02 dlen 9 L2CAP(d): 
cid 0x0040 len 5 [psm 3] RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 
credits 9 > ACL data: handle 42 flags 0x02 dlen 15 L2CAP(d): cid 0x0040 len 
11 [psm 3] RFCOMM(d): UIH: cr 1 dlci 18 pf 0 ilen 7 fcs 0xce OBEX: Connect 
cmd(f): len 7 version 1.0 flags 0 mtu 32767 < ACL data: handle 42 flags 0x02 
dlen 15 L2CAP(d): cid 0x0040 len 11 [psm 3] RFCOMM(d): UIH: cr 0 dlci 18 pf 
0 ilen 7 fcs 0x14 OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 
mtu 32767Status 200 = Success > HCI Event: Number of Completed Packets 
(0x13) plen 5 handle 42 packets 1 > ACL data: handle 42 flags 0x02 dlen 70 
L2CAP(d): cid 0x0040 len 66 [psm 3] RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 
61 fcs 0xd2 credits 1OBEX: Put cmd(c): len 61Name (0x01) = Unicode length 
18Length (0xc3) = 6718Type (0x42) = Sequence length 11Time (0x44) = Sequence 
length 15< ACL data: handle 42 flags 0x02 dlen 11L2CAP(d): cid 0x0040 len 7 
[psm 3]RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 3 fcs 0x14OBEX: Put rsp(f): 
status 400 len 3> HCI Event: Number of Completed Packets (0x13) plen 5handle 
42 packets 1> ACL data: handle 42 flags 0x02 dlen 8L2CAP(d): cid 0x0040 len 
4 [psm 3]RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3< ACL data: 
handle 42 flags 0x02 dlen 8L2CAP(d): cid 0x0040 len 4 [psm 3]RFCOMM(s): UA: 
cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9> HCI Event: Number of Completed Packets 
(0x13) plen 5handle 42 packets 1> ACL data: handle 42 flags 0x02 dlen 
8L2CAP(d): cid 0x0040 len 4 [psm 3]RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 
fcs 0xfd< ACL data: handle 42 flags 0x02 dlen 8L2CAP(d): cid 0x0040 len 4 
[psm 3]RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7> HCI Event: Number of 
Completed Packets (0x13) plen 5handle 42 packets 1> ACL data: handle 42 
flags 0x02 dlen 12L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040< ACL data: 
handle 42 flags 0x02 dlen 12L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040> 
HCI Event: Number of Completed Packets (0x13) plen 5handle 42 packets 1> HCI 
Event: Disconn Complete (0x05) plen 4status 0x00 handle 42 reason 
0x13Reason: Remote User Terminated Connection< HCI Command: Read Remote 
Version Information (0x01|0x001d) plen 2handle 42> HCI Event: Command Status 
(0x0f) plen 4Read Remote Version Information (0x01|0x001d) status 0x02 ncmd 
1Error: Unknown Connection IdentifierThanks,Alex. 

