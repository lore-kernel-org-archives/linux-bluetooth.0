Return-Path: <cyrus@holtmann.org>
Message-ID: <4B0190D5.8090406@start.ca>
Date: Mon, 16 Nov 2009 12:50:13 -0500
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth headsets fail to trigger pulseaudio consistently (Long)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys, I have an issue with bluetooth on Opensuse 11.2; Pulseaudio 
0.9.19, Bluez 4.56, KBluetooth4 (I have also used gnome-bluetooth and 
have exactly the same symptoms, issues and reliability) and supplied 
graphic tools. Kernel 2.6.31.5-0.1-default.

My process is to start Kbluetooth4 and plug in the adapter (MSI Star 
Key, details of hci0 follow).

hci0:   Type: USB
         BD Address: 00:1F:CF:20:69:57 ACL MTU: 1021:4 SCO MTU: 48:10
         UP RUNNING PSCAN
         RX bytes:2105 acl:27 sco:0 events:75 errors:0
         TX bytes:1187 acl:32 sco:0 commands:35 errors:0
         Features: 0xff 0xfe 0xff 0x7e 0x98 0x19 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'linux-2wd6-0'
         Class: 0x5a0104
         Service Classes: Networking, Capturing, Object Transfer, Telephony
         Device Class: Computer, Desktop workstation
         HCI Ver: 2.0 (0x3) HCI Rev: 0x302 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x302
         Manufacturer: Integrated System Solution Corp. (57)

I have 2 headsets, Jabra BT2040 and VBT185Z. Both of them have worked 
well several times before with the same adapter. I press the button on 
the headset and allow them to pair. Set always trust. Monitor status 
from Kbluetooth4 which works as well as gnome-bluetooth in monitoring 
status, connected, trusted etc. No problem here. Headsets connect pretty 
much reliably.

The dump from the connection is listed below.

Now comes the problem: I use PulseAudio manager to monitor the 
activation of the sink and source when the headsets connect. The default 
sink is auto_null and the default source is auto_null.monitor. Once in 
about 50 (fifty) connections pulseaudio sees the bluetooth connection 
and the sink and source are activated away from the defaults and the 
headsets become audio input and output addressable through alsa. The 
rest of the time sink and source do not change.

Below I have added the hcidump and below that is the log from the failed 
connection. Thanks for any assistance.

Colin

===============================================

# hcidump -t -X -V 

HCI sniffer - Bluetooth packet analyzer ver 1.42 

device: hci0 snap_len: 1028 filter: 0xffffffff 

2009-11-16 12:33:24.365084 > HCI Event: Connect Request (0x04) plen 10 

     bdaddr 00:1A:45:32:E7:16 class 0x200404 type ACL 

2009-11-16 12:33:24.365137 < HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7
     bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-16 12:33:24.369088 > HCI Event: Command Status (0x0f) plen 4 

     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1 

2009-11-16 12:33:24.529064 > HCI Event: Role Change (0x12) plen 8 

     status 0x00 bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-16 12:33:24.538061 > HCI Event: Connect Complete (0x03) plen 11 

     status 0x00 handle 1 bdaddr 00:1A:45:32:E7:16 type ACL encrypt 0x00 

2009-11-16 12:33:24.538109 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
     handle 1 

2009-11-16 12:33:24.540085 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
     status 0x00 handle 1 ptype 0x3318 

     Packet type: DM1 DH1 2-DH3 2-DH5 3-DH3 3-DH5 

2009-11-16 12:33:24.542084 > HCI Event: Command Status (0x0f) plen 4 

     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1 

2009-11-16 12:33:24.574321 < HCI Command: Remote Name Request 
(0x01|0x0019) plen 10
     bdaddr 00:1A:45:32:E7:16 mode 2 clkoffset 0x0000 

2009-11-16 12:33:24.578080 > HCI Event: Command Status (0x0f) plen 4 

     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1 

2009-11-16 12:33:24.583075 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
     status 0x00 handle 1 

     Features: 0xbc 0xfe 0x0f 0x86 0x8b 0xe9 0x00 0x00 

2009-11-16 12:33:24.728043 > HCI Event: Remote Name Req Complete (0x07) 
plen 255
     status 0x00 bdaddr 00:1A:45:32:E7:16 name 'Jabra BT2040' 

2009-11-16 12:33:24.818040 > HCI Event: Link Key Request (0x17) plen 6 

     bdaddr 00:1A:45:32:E7:16 

2009-11-16 12:33:24.818577 < HCI Command: Link Key Request Reply 
(0x01|0x000b) plen 22
     bdaddr 00:1A:45:32:E7:16 key 0B80606F6B6D6250E00B6AF2791994BD 

2009-11-16 12:33:24.823038 > HCI Event: Command Complete (0x0e) plen 10 

     Link Key Request Reply (0x01|0x000b) ncmd 1 

     status 0x00 bdaddr 00:1A:45:32:E7:16 

2009-11-16 12:33:24.926032 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 1 scid 0x0040 

2009-11-16 12:33:24.926100 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0 

       Connection pending - No futher information available 

2009-11-16 12:33:24.926109 < ACL data: handle 1 flags 0x02 dlen 10 

     L2CAP(s): Info req: type 2 

2009-11-16 12:33:24.931047 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:24.933044 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:24.974070 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Info rsp: type 2 result 0 

       Extended feature mask 0x0000 

2009-11-16 12:33:24.974176 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0 

       Connection successful 

2009-11-16 12:33:24.978045 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.019053 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4 

       MTU 48 

2009-11-16 12:33:25.019105 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 

       MTU 48 

2009-11-16 12:33:25.019113 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 

2009-11-16 12:33:25.023038 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.025055 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.062074 > ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0 

       Success 

2009-11-16 12:33:25.093040 > ACL data: handle 1 flags 0x02 dlen 24 

     L2CAP(d): cid 0x0040 len 20 [psm 1] 

         SDP SSA Req: tid 0x1 len 0xf 

           pat uuid-32 0x111f (Handsfree AG) 

           max 38 

           aid(s) 0x0004 (ProtocolDescList) 

           cont 00 

2009-11-16 12:33:25.093718 < ACL data: handle 1 flags 0x02 dlen 33 

     L2CAP(d): cid 0x0040 len 29 [psm 1] 

         SDP SSA Rsp: tid 0x1 len 0x18 

           count 21 

           record #0 

               aid 0x0004 (ProtocolDescList) 

                  < < uuid-16 0x0100 (L2CAP) > < 

                  uuid-16 0x0003 (RFCOMM) uint 0xd > > 

           cont 00 

2009-11-16 12:33:25.098038 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.139043 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040 

2009-11-16 12:33:25.139133 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040 

2009-11-16 12:33:25.143032 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.549980 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 3 scid 0x0041 

2009-11-16 12:33:25.550034 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0 

       Connection successful 

2009-11-16 12:33:25.553994 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.602004 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4 

       MTU 132 

2009-11-16 12:33:25.602076 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4 

       MTU 132 

2009-11-16 12:33:25.602084 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4 

       MTU 1013 

2009-11-16 12:33:25.607005 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.609004 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.645975 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 

       MTU 1013 

2009-11-16 12:33:25.677012 > ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0040 len 4 [psm 3] 

       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 

2009-11-16 12:33:25.677174 < ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0041 len 4 [psm 3] 

       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 

2009-11-16 12:33:25.681993 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:25.899953 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0040 len 14 [psm 3] 

       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8 

       dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0 

       frame_size 126 max_retrans 0 credits 0 

2009-11-16 12:33:25.900238 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0041 len 14 [psm 3] 

       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8 

       dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0 

       frame_size 126 max_retrans 0 credits 7 

2009-11-16 12:33:25.903947 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.092937 > ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0040 len 4 [psm 3] 

       RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 

2009-11-16 12:33:26.093133 < HCI Command: Authentication Requested 
(0x01|0x0011) plen 2
     handle 1 

2009-11-16 12:33:26.095930 > HCI Event: Command Status (0x0f) plen 4 

     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1 

2009-11-16 12:33:26.169949 > HCI Event: Auth Complete (0x06) plen 3 

     status 0x00 handle 1 

2009-11-16 12:33:26.170004 < HCI Command: Set Connection Encryption 
(0x01|0x0013) plen 3
     handle 1 encrypt 0x01 

2009-11-16 12:33:26.172953 > HCI Event: Command Status (0x0f) plen 4 

     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1 

2009-11-16 12:33:26.383931 > HCI Event: Encrypt Change (0x08) plen 4 

     status 0x00 handle 1 encrypt 0x01 

2009-11-16 12:33:26.384890 < ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0041 len 4 [psm 3] 

       RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c 

2009-11-16 12:33:26.384961 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0041 len 8 [psm 3] 

       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 

2009-11-16 12:33:26.390929 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.392925 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.459935 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0040 len 8 [psm 3] 

       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 

2009-11-16 12:33:26.461932 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0040 len 8 [psm 3] 

       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0 

2009-11-16 12:33:26.462040 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0041 len 8 [psm 3] 

       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0 

2009-11-16 12:33:26.462060 < ACL data: handle 1 flags 0x02 dlen 9 

     L2CAP(d): cid 0x0041 len 5 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33 

2009-11-16 12:33:26.465924 > ACL data: handle 1 flags 0x02 dlen 9 

     L2CAP(d): cid 0x0040 len 5 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15 

2009-11-16 12:33:26.466926 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.468925 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.666889 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 1 scid 0x0042 

2009-11-16 12:33:26.666946 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0 

       Connection successful 

2009-11-16 12:33:26.671899 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.714928 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4 

       MTU 48 

2009-11-16 12:33:26.714991 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4 

       MTU 48 

2009-11-16 12:33:26.715000 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0 

2009-11-16 12:33:26.718909 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.720906 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.731911 > ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0 

       Success 

2009-11-16 12:33:26.762904 > ACL data: handle 1 flags 0x02 dlen 24 

     L2CAP(d): cid 0x0041 len 20 [psm 1] 

         SDP SSA Req: tid 0x1 len 0xf 

           pat uuid-32 0x111f (Handsfree AG) 

           max 38 

           aid(s) 0x0009 (BTProfileDescList) 

           cont 00 

2009-11-16 12:33:26.763537 < ACL data: handle 1 flags 0x02 dlen 29 

     L2CAP(d): cid 0x0042 len 25 [psm 1] 

         SDP SSA Rsp: tid 0x1 len 0x14 

           count 17 

           record #0 

               aid 0x0009 (BTProfileDescList) 

                  < < uuid-16 0x111e (Handsfree) uint 0x105 > > 

           cont 00 

2009-11-16 12:33:26.767899 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:26.809901 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042 

2009-11-16 12:33:26.809991 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042 

2009-11-16 12:33:26.813897 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.112856 > ACL data: handle 1 flags 0x02 dlen 19 

     L2CAP(d): cid 0x0040 len 15 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4 

       0000: 41 54 2b 42 52 53 46 3d  32 36 0d 
AT+BRSF=26.
2009-11-16 12:33:27.113263 < ACL data: handle 1 flags 0x02 dlen 22 

     L2CAP(d): cid 0x0041 len 18 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e 

       0000: 0d 0a 2b 42 52 53 46 3a  20 33 35 32 0d 0a        ..+BRSF: 
352..
2009-11-16 12:33:27.113296 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 0d 0a 4f 4b 0d 0a                                 ..OK.. 

2009-11-16 12:33:27.117872 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.119852 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.387857 > ACL data: handle 1 flags 0x02 dlen 19 

     L2CAP(d): cid 0x0040 len 15 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2 

       0000: 41 54 2b 43 49 4e 44 3d  3f 0d 
AT+CIND=?.
2009-11-16 12:33:27.388202 < ACL data: handle 1 flags 0x02 dlen 134 

     L2CAP(d): cid 0x0041 len 130 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 126 fcs 0x3e 

       0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 62 61 74 74 63  ..+CIND: 
("battc
       0010: 68 67 22 2c 28 30 2d 35  29 29 2c 28 22 73 69 67 
hg",(0-5)),("sig
       0020: 6e 61 6c 22 2c 28 30 2d  35 29 29 2c 28 22 73 65 
nal",(0-5)),("se
       0030: 72 76 69 63 65 22 2c 28  30 2c 31 29 29 2c 28 22 
rvice",(0,1)),("
       0040: 63 61 6c 6c 22 2c 28 30  2c 31 29 29 2c 28 22 63 
call",(0,1)),("c
       0050: 61 6c 6c 73 65 74 75 70  22 2c 28 30 2d 33 29 29 
allsetup",(0-3))
       0060: 2c 28 22 63 61 6c 6c 68  65 6c 64 22 2c 28 30 2d 
,("callheld",(0-
       0070: 32 29 29 2c 28 22 72 6f  61 6d 22 2c 28 30 
2)),("roam",(0
2009-11-16 12:33:27.388228 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 2c 31 29 29 0d 0a                                 ,1)).. 

2009-11-16 12:33:27.388236 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 0d 0a 4f 4b 0d 0a                                 ..OK.. 

2009-11-16 12:33:27.393857 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.394873 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.396850 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-16 12:33:27.946787 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0040 len 14 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 3 

       0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
2009-11-16 12:33:27.947200 < ACL data: handle 1 flags 0x02 dlen 32
     L2CAP(d): cid 0x0041 len 28 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 24 fcs 0x3e
       0000: 0d 0a 2b 43 49 4e 44 3a  20 35 2c 35 2c 31 2c 30  ..+CIND: 
5,5,1,0
       0010: 2c 30 2c 30 2c 30 0d 0a                           ,0,0,0..
2009-11-16 12:33:27.947231 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-16 12:33:27.951800 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-16 12:33:27.953803 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-16 12:33:28.446748 > ACL data: handle 1 flags 0x02 dlen 28
     L2CAP(d): cid 0x0040 len 24 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 19 fcs 0xf8 credits 2
       0000: 41 54 2b 43 4d 45 52 3d  33 2c 20 30 2c 20 30 2c 
AT+CMER=3, 0, 0,
       0010: 20 31 0d                                           1.
2009-11-16 12:33:28.452518 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-16 12:33:28.456769 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-16 12:33:29.549659 > ACL data: handle 1 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 1
       0000: 41 54 2b 42 54 52 48 3f  0d                       AT+BTRH?.
2009-11-16 12:33:29.550034 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-16 12:33:29.553676 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-16 12:33:30.392593 > ACL data: handle 1 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
       0000: 41 54 2b 56 47 53 3d 31  35 0d                    AT+VGS=15.
2009-11-16 12:33:30.392974 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-16 12:33:30.397609 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-16 12:33:30.773563 > ACL data: handle 1 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
       0000: 41 54 2b 56 47 4d 3d 31  35 0d                    AT+VGM=15.
2009-11-16 12:33:30.773945 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-16 12:33:30.777578 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1

===============================================

Example failed connection:

Nov 16 07:37:06 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:06 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:06 linux-2wd6 bluetoothd[9409]: link_key_request 
(sba=00:1F:CF:20:69:57, dba=00:1A:45:32:E7:16)
Nov 16 07:37:07 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:07 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:07 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:07 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Device, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:07 linux-2wd6 bluetoothd[9409]: link_key_request 
(sba=00:1F:CF:20:69:57, dba=00:1A:45:32:E7:16)
Nov 16 07:37:08 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:08 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:08 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Audio, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:08 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Audio, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Audio, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: 
module-bluetooth-discover.c: Loading module-bluetooth-device 
address="00:1A:45:32:E7:16" 
path="/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16" 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: card.c: Created 6 
"bluez_card.00_1A_45_32_E7_16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Connected to the bluetooth audio service
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Sending BT_REQUEST -> BT_GET_CAPABILITIES
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_RESPONSE <- BT_GET_CAPABILITIES
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Payload size is 9 6
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Sending BT_REQUEST -> BT_GET_CAPABILITIES
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_RESPONSE <- BT_GET_CAPABILITIES
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Payload size is 9 6
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Got device capabilities
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Sending BT_REQUEST -> BT_OPEN
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_RESPONSE <- BT_OPEN
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Sending BT_REQUEST -> BT_SET_CONFIGURATION
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_RESPONSE <- BT_SET_CONFIGURATION
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Connection to the device configured
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Got the stream socket
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: Created sink 11 
"bluez_sink.00_1A_45_32_E7_16" with sample spec s16le 1ch 8000Hz and 
channel map mono 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: 
bluetooth.protocol = "sco"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: 
device.intended_roles = "phone"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: 
device.description = "Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     device.string 
= "00:1A:45:32:E7:16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     device.api = 
"bluez"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     device.class = 
"sound"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     device.bus = 
"bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: 
device.form_factor = "headset"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     bluez.path = 
"/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     bluez.class = 
"0x200404"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c:     bluez.name = 
"Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: sink.c: 
device.icon_name = "audio-headset-bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: Created source 
16 "bluez_sink.00_1A_45_32_E7_16.monitor" with sample spec s16le 1ch 
8000Hz and channel map mono 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.description = "Monitor of Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.class 
= "monitor"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.string = "00:1A:45:32:E7:16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.api = 
"bluez"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.bus = 
"bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.form_factor = "headset"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.path = 
"/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.class 
= "0x200404"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.name = 
"Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.icon_name = "audio-headset-bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-device-restore.c: 
Restoring volume for source bluez_source.00_1A_45_32_E7_16.
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: Created source 
17 "bluez_source.00_1A_45_32_E7_16" with sample spec s16le 1ch 8000Hz 
and channel map mono 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
bluetooth.protocol = "hsp"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.intended_roles = "phone"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.description = "Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.string = "00:1A:45:32:E7:16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.api = 
"bluez"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.class 
= "sound"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     device.bus = 
"bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.form_factor = "headset"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.path = 
"/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.class 
= "0x200404"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c:     bluez.name = 
"Jabra BT2040"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: source.c: 
device.icon_name = "audio-headset-bluetooth"
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
IO Thread starting up
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: core-util.c: Successfully 
enabled SCHED_RR scheduling for thread, with priority 4, which is lower 
than the requested 5. 

Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Sending BT_REQUEST -> BT_START_STREAM
Nov 16 07:37:11 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:51 linux-2wd6 bluetoothd[9409]: HUP or ERR on socket 

Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_RESPONSE <- BT_START_STREAM
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Trying to receive message from audio service...
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Received BT_INDICATION <- BT_NEW_STREAM
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
Stream properly set up, we're ready to roll!
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
FD error: POLLERR
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
IO thread failed
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-suspend-on-idle.c: 
Sink bluez_sink.00_1A_45_32_E7_16 becomes idle, timeout in 5 seconds. 
 

Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-always-sink.c: A 
new sink has been discovered. Unloading null-sink.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-suspend-on-idle.c: 
Source bluez_source.00_1A_45_32_E7_16 becomes idle, timeout in 5 
seconds. 

Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Loaded 
"module-bluetooth-device" (index: #29; argument: 
"address="00:1A:45:32:E7:16" 
path="/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16""). 

Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Audio, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=PropertyChanged 
 

Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Unloading 
"module-null-sink" (index: #28).
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-rescue-streams.c: 
No sink inputs to move away.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-rescue-streams.c: 
No source outputs to move away.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-null-sink.c: Thread 
shutting down
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c: Freeing sink 10 
"auto_null"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: Freeing source 
15 "auto_null.monitor"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Unloaded 
"module-null-sink" (index: #28).
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Unloading 
"module-bluetooth-device" (index: #29).
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-always-sink.c: 
Autoloading null-sink as no other sinks detected.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-device-restore.c: 
Restoring volume for sink auto_null.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c: Created sink 12 
"auto_null" with sample spec s16le 2ch 44100Hz and channel map 
front-left,front-right
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c: 
device.description = "Dummy Output"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c:     device.class = 
"abstract"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c: 
device.icon_name = "audio-card"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: Created source 
18 "auto_null.monitor" with sample spec s16le 2ch 44100Hz and channel 
map front-left,front-right
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: 
device.description = "Monitor of Dummy Output"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c:     device.class 
= "monitor"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: 
device.icon_name = "audio-input-microphone"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-null-sink.c: Thread 
starting up
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-suspend-on-idle.c: 
Sink auto_null becomes idle, timeout in 5 seconds.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Loaded 
"module-null-sink" (index: #30; argument: "sink_name=auto_null 
sink_properties='device.description="Dummy Output"'").
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-rescue-streams.c: 
No sink inputs to move away.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-rescue-streams.c: 
No source outputs to move away.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-rescue-streams.c: 
No source outputs to move away.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-bluetooth-device.c: 
IO thread shutting down
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: sink.c: Freeing sink 11 
"bluez_sink.00_1A_45_32_E7_16"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: Freeing source 
16 "bluez_sink.00_1A_45_32_E7_16.monitor"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: source.c: Freeing source 
17 "bluez_source.00_1A_45_32_E7_16"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: card.c: Freed 6 
"bluez_card.00_1A_45_32_E7_16"
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module.c: Unloaded 
"module-bluetooth-device" (index: #29).
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=SpeakerGainChanged
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, member=SpeakerGainChanged
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=(null), path=(null), member=(null)
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=(null), path=(null), member=(null)
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, 
member=MicrophoneGainChanged
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=org.bluez.Headset, 
path=/org/bluez/9408/hci0/dev_00_1A_45_32_E7_16, 
member=MicrophoneGainChanged
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: bluetooth-util.c: dbus: 
interface=(null), path=(null), member=(null)
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: module-console-kit.c: 
dbus: interface=(null), path=(null), member=(null)
Nov 16 07:37:51 linux-2wd6 pulseaudio[12059]: core-subscribe.c: Dropped 
redundant event due to change event.
Nov 16 07:37:56 linux-2wd6 pulseaudio[12059]: module-suspend-on-idle.c: 
Sink auto_null idle for too long, suspending ...
Nov 16 07:37:56 linux-2wd6 pulseaudio[12059]: sink.c: Suspend cause of 
sink auto_null is 0x0004, suspending




