Return-Path: <cyrus@holtmann.org>
Message-ID: <4B02804C.1020505@start.ca>
Date: Tue, 17 Nov 2009 05:51:56 -0500
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: Peter Hurley <phurley@charter.net>, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth headsets fail to trigger pulseaudio consistently (Long)
References: <4B0190D5.8090406@start.ca> <007001ca66eb$8c664220$a532c660$@net>
In-Reply-To: <007001ca66eb$8c664220$a532c660$@net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Peter:

On 11/16/2009 01:35 PM, Peter Hurley wrote:
> Hi Colin,
>
>> # hcidump -t -X -V
>
> This dump looks truncated.  Is this all the output or did the trace
> start generating tons of SCO packets that you snipped?  There might be
> BT commands/replies in the mass of SCO packets that got snipped too.
>
> Also, you need to set the already-running bluetooth daemon into debug
> output mode.  You can do this with:
>
> sudo kill -SIGUSR2 [pid of bluetoothd]
>
> Then the daemon log will be way more useful - please repost that daemon
> log. Also, there's no need to include pulseaudio output because I
> virtually guarantee it's just "the messenger".
>
> I noticed the time stamps in the trace and log aren't for the same
> interval.  The hcidump trace and the daemon log should be for the same
> events/time interval, ok?
>
> Regards,
> Peter Hurley
>

Here is another go this time with timestamps. I found that the command

kill -SIGUSR2 [pid of bluetoothd]

had no effect on bluetooth process on my system, so I killed it with 
kill -9 PID and then restarted with

bluetoothd -d -u

which seems to have directed the debug output to the log with 
timestamps. The following two outputs are from the same failed attempt 
to get pulse to start up its bluetooth modules. Both are complete with 
no editing. When output stopped I waited about 2 minutes before copying.

Headset button is pressed at 05:40:33

==================================

# hcidump -t -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2009-11-17 05:40:32.824682 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:1A:45:32:E7:16 class 0x200404 type ACL
2009-11-17 05:40:32.824733 < HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7
     bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-17 05:40:32.828692 > HCI Event: Command Status (0x0f) plen 4 

     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1 

2009-11-17 05:40:32.988628 > HCI Event: Role Change (0x12) plen 8 

     status 0x00 bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-17 05:40:32.995642 > HCI Event: Connect Complete (0x03) plen 11 

     status 0x00 handle 1 bdaddr 00:1A:45:32:E7:16 type ACL encrypt 0x00 

2009-11-17 05:40:32.995696 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
     handle 1 

2009-11-17 05:40:32.996656 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
     status 0x00 handle 1 ptype 0x3318 

     Packet type: DM1 DH1 2-DH3 2-DH5 3-DH3 3-DH5 

2009-11-17 05:40:32.999646 > HCI Event: Command Status (0x0f) plen 4 

     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1 

2009-11-17 05:40:33.046646 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
     status 0x00 handle 1 

     Features: 0xbc 0xfe 0x0f 0x86 0x8b 0xe9 0x00 0x00 

2009-11-17 05:40:33.049316 < HCI Command: Remote Name Request 
(0x01|0x0019) plen 10
     bdaddr 00:1A:45:32:E7:16 mode 2 clkoffset 0x0000 

2009-11-17 05:40:33.052632 > HCI Event: Command Status (0x0f) plen 4 

     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1 

2009-11-17 05:40:33.202593 > HCI Event: Remote Name Req Complete (0x07) 
plen 255
     status 0x00 bdaddr 00:1A:45:32:E7:16 name 'Jabra BT2040' 

2009-11-17 05:40:33.258550 > HCI Event: Link Key Request (0x17) plen 6 

     bdaddr 00:1A:45:32:E7:16 

2009-11-17 05:40:33.259069 < HCI Command: Link Key Request Reply 
(0x01|0x000b) plen 22
     bdaddr 00:1A:45:32:E7:16 key 0B80606F6B6D6250E00B6AF2791994BD 

2009-11-17 05:40:33.263548 > HCI Event: Command Complete (0x0e) plen 10 

     Link Key Request Reply (0x01|0x000b) ncmd 1 

     status 0x00 bdaddr 00:1A:45:32:E7:16 

2009-11-17 05:40:33.356522 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 1 scid 0x0040 

2009-11-17 05:40:33.356576 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0 

       Connection pending - No futher information available 

2009-11-17 05:40:33.356585 < ACL data: handle 1 flags 0x02 dlen 10 

     L2CAP(s): Info req: type 2 

2009-11-17 05:40:33.361531 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.363508 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.404500 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Info rsp: type 2 result 0 

       Extended feature mask 0x0000 

2009-11-17 05:40:33.404546 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0 

       Connection successful 

2009-11-17 05:40:33.408516 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.449486 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4 

       MTU 48 

2009-11-17 05:40:33.449533 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 

       MTU 48 

2009-11-17 05:40:33.449541 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 

2009-11-17 05:40:33.453499 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.455483 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.492474 > ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0 

       Success 

2009-11-17 05:40:33.523465 > ACL data: handle 1 flags 0x02 dlen 24 

     L2CAP(d): cid 0x0040 len 20 [psm 1] 

         SDP SSA Req: tid 0x1 len 0xf 

           pat uuid-32 0x111f (Handsfree AG) 

           max 38 

           aid(s) 0x0004 (ProtocolDescList) 

           cont 00 

2009-11-17 05:40:33.524109 < ACL data: handle 1 flags 0x02 dlen 33 

     L2CAP(d): cid 0x0040 len 29 [psm 1] 

         SDP SSA Rsp: tid 0x1 len 0x18 

           count 21 

           record #0 

               aid 0x0004 (ProtocolDescList) 

                  < < uuid-16 0x0100 (L2CAP) > < 

                  uuid-16 0x0003 (RFCOMM) uint 0xd > > 

           cont 00 

2009-11-17 05:40:33.528475 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:33.569448 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040 

2009-11-17 05:40:33.569505 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040 

2009-11-17 05:40:33.573462 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.001317 > HCI Event: Disconn Complete (0x05) plen 4 

     status 0x00 handle 1 reason 0x13 

     Reason: Remote User Terminated Connection 

2009-11-17 05:40:34.102287 > HCI Event: Connect Request (0x04) plen 10 

     bdaddr 00:1A:45:32:E7:16 class 0x200404 type ACL 

2009-11-17 05:40:34.102337 < HCI Command: Accept Connection Request 
(0x01|0x0009) plen 7
     bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-17 05:40:34.106303 > HCI Event: Command Status (0x0f) plen 4 

     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1 

2009-11-17 05:40:34.266274 > HCI Event: Role Change (0x12) plen 8 

     status 0x00 bdaddr 00:1A:45:32:E7:16 role 0x00 

     Role: Master 

2009-11-17 05:40:34.280259 > HCI Event: Connect Complete (0x03) plen 11 

     status 0x00 handle 1 bdaddr 00:1A:45:32:E7:16 type ACL encrypt 0x00 

2009-11-17 05:40:34.280336 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
     handle 1 

2009-11-17 05:40:34.282254 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
     status 0x00 handle 1 ptype 0x3318 

     Packet type: DM1 DH1 2-DH3 2-DH5 3-DH3 3-DH5 

2009-11-17 05:40:34.284244 > HCI Event: Command Status (0x0f) plen 4 

     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1 

2009-11-17 05:40:34.313675 < HCI Command: Remote Name Request 
(0x01|0x0019) plen 10
     bdaddr 00:1A:45:32:E7:16 mode 2 clkoffset 0x0000 

2009-11-17 05:40:34.316256 > HCI Event: Command Status (0x0f) plen 4 

     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1 

2009-11-17 05:40:34.322235 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
     status 0x00 handle 1 

     Features: 0xbc 0xfe 0x0f 0x86 0x8b 0xe9 0x00 0x00 

2009-11-17 05:40:34.456175 > HCI Event: Remote Name Req Complete (0x07) 
plen 255
     status 0x00 bdaddr 00:1A:45:32:E7:16 name 'Jabra BT2040' 

2009-11-17 05:40:34.534155 > HCI Event: Link Key Request (0x17) plen 6 

     bdaddr 00:1A:45:32:E7:16 

2009-11-17 05:40:34.536649 < HCI Command: Link Key Request Reply 
(0x01|0x000b) plen 22
     bdaddr 00:1A:45:32:E7:16 key 0B80606F6B6D6250E00B6AF2791994BD 

2009-11-17 05:40:34.541161 > HCI Event: Command Complete (0x0e) plen 10 

     Link Key Request Reply (0x01|0x000b) ncmd 1 

     status 0x00 bdaddr 00:1A:45:32:E7:16 

2009-11-17 05:40:34.634125 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 3 scid 0x0041 

2009-11-17 05:40:34.634187 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 1 status 0 

       Connection pending - No futher information available 

2009-11-17 05:40:34.634197 < ACL data: handle 1 flags 0x02 dlen 10 

     L2CAP(s): Info req: type 2 

2009-11-17 05:40:34.638132 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.640047 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.682109 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Info rsp: type 2 result 0 

       Extended feature mask 0x0000 

2009-11-17 05:40:34.682155 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0 

       Connection successful 

2009-11-17 05:40:34.687106 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.729093 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4 

       MTU 132 

2009-11-17 05:40:34.729139 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4 

       MTU 132 

2009-11-17 05:40:34.729147 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4 

       MTU 1013 

2009-11-17 05:40:34.733106 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.735089 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.772082 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4 

       MTU 1013 

2009-11-17 05:40:34.803073 > ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0040 len 4 [psm 3] 

       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 

2009-11-17 05:40:34.803304 < ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0041 len 4 [psm 3] 

       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 

2009-11-17 05:40:34.808072 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:34.901042 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0040 len 14 [psm 3] 

       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8 

       dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0 

       frame_size 126 max_retrans 0 credits 0 

2009-11-17 05:40:34.901307 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0041 len 14 [psm 3] 

       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8 

       dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0 

       frame_size 126 max_retrans 0 credits 7 

2009-11-17 05:40:34.905056 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.096978 > ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0040 len 4 [psm 3] 

       RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 

2009-11-17 05:40:35.097179 < HCI Command: Authentication Requested 
(0x01|0x0011) plen 2
     handle 1 

2009-11-17 05:40:35.099976 > HCI Event: Command Status (0x0f) plen 4 

     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1 

2009-11-17 05:40:35.171959 > HCI Event: Auth Complete (0x06) plen 3 

     status 0x00 handle 1 

2009-11-17 05:40:35.171996 < HCI Command: Set Connection Encryption 
(0x01|0x0013) plen 3
     handle 1 encrypt 0x01 

2009-11-17 05:40:35.174961 > HCI Event: Command Status (0x0f) plen 4 

     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1 

2009-11-17 05:40:35.375924 > HCI Event: Encrypt Change (0x08) plen 4 

     status 0x00 handle 1 encrypt 0x01 

2009-11-17 05:40:35.376996 < ACL data: handle 1 flags 0x02 dlen 8 

     L2CAP(d): cid 0x0041 len 4 [psm 3] 

       RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c 

2009-11-17 05:40:35.377034 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0041 len 8 [psm 3] 

       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 

2009-11-17 05:40:35.382910 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.384049 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.452872 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0040 len 8 [psm 3] 

       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0 

2009-11-17 05:40:35.453869 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0040 len 8 [psm 3] 

       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0 

2009-11-17 05:40:35.453911 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(d): cid 0x0041 len 8 [psm 3] 

       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2 

       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0 

2009-11-17 05:40:35.453929 < ACL data: handle 1 flags 0x02 dlen 9 

     L2CAP(d): cid 0x0041 len 5 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33 

2009-11-17 05:40:35.456881 > ACL data: handle 1 flags 0x02 dlen 9 

     L2CAP(d): cid 0x0040 len 5 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15 

2009-11-17 05:40:35.457879 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.459866 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.676801 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Connect req: psm 1 scid 0x0042 

2009-11-17 05:40:35.676855 < ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0 

       Connection successful 

2009-11-17 05:40:35.681816 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.723790 > ACL data: handle 1 flags 0x02 dlen 16 

     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4 

       MTU 48 

2009-11-17 05:40:35.723837 < ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4 

       MTU 48 

2009-11-17 05:40:35.723845 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0 

2009-11-17 05:40:35.727784 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.728803 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.766773 > ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0 

       Success 

2009-11-17 05:40:35.797764 > ACL data: handle 1 flags 0x02 dlen 24 

     L2CAP(d): cid 0x0041 len 20 [psm 1] 

         SDP SSA Req: tid 0x1 len 0xf 

           pat uuid-32 0x111f (Handsfree AG) 

           max 38 

           aid(s) 0x0009 (BTProfileDescList) 

           cont 00 

2009-11-17 05:40:35.798505 < ACL data: handle 1 flags 0x02 dlen 29 

     L2CAP(d): cid 0x0042 len 25 [psm 1] 

         SDP SSA Rsp: tid 0x1 len 0x14 

           count 17 

           record #0 

               aid 0x0009 (BTProfileDescList) 

                  < < uuid-16 0x111e (Handsfree) uint 0x105 > > 

           cont 00 

2009-11-17 05:40:35.802783 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:35.843752 > ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042 

2009-11-17 05:40:35.843804 < ACL data: handle 1 flags 0x02 dlen 12 

     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042 

2009-11-17 05:40:35.847746 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:36.265655 > ACL data: handle 1 flags 0x02 dlen 19 

     L2CAP(d): cid 0x0040 len 15 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4 

       0000: 41 54 2b 42 52 53 46 3d  32 36 0d 
AT+BRSF=26.
2009-11-17 05:40:36.266046 < ACL data: handle 1 flags 0x02 dlen 22 

     L2CAP(d): cid 0x0041 len 18 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e 

       0000: 0d 0a 2b 42 52 53 46 3a  20 33 35 32 0d 0a        ..+BRSF: 
352..
2009-11-17 05:40:36.266075 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 0d 0a 4f 4b 0d 0a                                 ..OK.. 

2009-11-17 05:40:36.271639 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:36.273639 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:36.784501 > ACL data: handle 1 flags 0x02 dlen 19 

     L2CAP(d): cid 0x0040 len 15 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2 

       0000: 41 54 2b 43 49 4e 44 3d  3f 0d 
AT+CIND=?.
2009-11-17 05:40:36.785009 < ACL data: handle 1 flags 0x02 dlen 134 

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
2009-11-17 05:40:36.785043 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 2c 31 29 29 0d 0a                                 ,1)).. 

2009-11-17 05:40:36.785050 < ACL data: handle 1 flags 0x02 dlen 14 

     L2CAP(d): cid 0x0041 len 10 [psm 3] 

       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 

       0000: 0d 0a 4f 4b 0d 0a                                 ..OK.. 

2009-11-17 05:40:36.791485 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:36.793503 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:36.795470 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1 

2009-11-17 05:40:37.462257 > ACL data: handle 1 flags 0x02 dlen 18 

     L2CAP(d): cid 0x0040 len 14 [psm 3] 

       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 3 

       0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
2009-11-17 05:40:37.462755 < ACL data: handle 1 flags 0x02 dlen 32
     L2CAP(d): cid 0x0041 len 28 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 24 fcs 0x3e
       0000: 0d 0a 2b 43 49 4e 44 3a  20 35 2c 35 2c 31 2c 30  ..+CIND: 
5,5,1,0
       0010: 2c 30 2c 30 2c 30 0d 0a                           ,0,0,0..
2009-11-17 05:40:37.462790 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-17 05:40:37.467254 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-17 05:40:37.468265 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-17 05:40:38.063071 > ACL data: handle 1 flags 0x02 dlen 28
     L2CAP(d): cid 0x0040 len 24 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 19 fcs 0xf8 credits 2
       0000: 41 54 2b 43 4d 45 52 3d  33 2c 20 30 2c 20 30 2c 
AT+CMER=3, 0, 0,
       0010: 20 31 0d                                           1.
2009-11-17 05:40:38.065647 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-17 05:40:38.069091 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-17 05:40:39.143741 > ACL data: handle 1 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 1
       0000: 41 54 2b 42 54 52 48 3f  0d                       AT+BTRH?.
2009-11-17 05:40:39.144256 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-17 05:40:39.147743 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-17 05:40:39.996476 > ACL data: handle 1 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
       0000: 41 54 2b 56 47 53 3d 31  35 0d                    AT+VGS=15.
2009-11-17 05:40:39.997002 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-17 05:40:40.001495 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1
2009-11-17 05:40:40.370376 > ACL data: handle 1 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
       0000: 41 54 2b 56 47 4d 3d 31  35 0d                    AT+VGM=15.
2009-11-17 05:40:40.370824 < ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
2009-11-17 05:40:40.375359 > HCI Event: Number of Completed Packets 
(0x13) plen 5
     handle 1 packets 1


==================================

system log


Nov 17 05:40:33 linux-2wd6 bluetoothd[6845]: 
adapter_get_device(00:1A:45:32:E7:16)
Nov 17 05:40:33 linux-2wd6 bluetoothd[6845]: Unable to add connection 1
Nov 17 05:40:33 linux-2wd6 bluetoothd[6845]: link_key_request 
(sba=00:1F:CF:20:69:57, dba=00:1A:45:32:E7:16)
Nov 17 05:40:33 linux-2wd6 bluetoothd[6845]: kernel auth requirements = 0x00
Nov 17 05:40:33 linux-2wd6 bluetoothd[6845]: stored link key type = 0x00
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: No matching connection 
found for handle 1
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: 
adapter_get_device(00:1A:45:32:E7:16)
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: Unable to add connection 1
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: link_key_request 
(sba=00:1F:CF:20:69:57, dba=00:1A:45:32:E7:16)
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: kernel auth requirements = 0x00
Nov 17 05:40:34 linux-2wd6 bluetoothd[6845]: stored link key type = 0x00
Nov 17 05:40:35 linux-2wd6 bluetoothd[6845]: 
hcid_dbus_bonding_process_complete: status=00
Nov 17 05:40:35 linux-2wd6 bluetoothd[6845]: 
adapter_get_device(00:1A:45:32:E7:16)
Nov 17 05:40:35 linux-2wd6 bluetoothd[6845]: 
hcid_dbus_bonding_process_complete: no pending auth request
Nov 17 05:40:35 linux-2wd6 bluetoothd[6845]: State changed 
/org/bluez/6844/hci0/dev_00_1A_45_32_E7_16: HEADSET_STATE_DISCONNECTED 
-> HEADSET_STATE_CONNECTING
Nov 17 05:40:35 linux-2wd6 bluetoothd[6845]: 
/org/bluez/6844/hci0/dev_00_1A_45_32_E7_16: Connected to 00:1A:45:32:E7:16
Nov 17 05:40:36 linux-2wd6 bluetoothd[6845]: Received AT+BRSF=26
Nov 17 05:40:36 linux-2wd6 bluetoothd[6845]: HFP HF features: "Call 
waiting and 3-way calling" "Voice recognition activation" "Remote volume 
control"
Nov 17 05:40:36 linux-2wd6 bluetoothd[6845]: Received AT+CIND=?
Nov 17 05:40:37 linux-2wd6 bluetoothd[6845]: Received AT+CIND?
Nov 17 05:40:38 linux-2wd6 bluetoothd[6845]: Received AT+CMER=3, 0, 0, 1
Nov 17 05:40:38 linux-2wd6 bluetoothd[6845]: Event reporting (CMER): 
mode=3, ind=1
Nov 17 05:40:38 linux-2wd6 bluetoothd[6845]: HFP Service Level 
Connection established
Nov 17 05:40:38 linux-2wd6 bluetoothd[6845]: telephony-dummy: device 
0xb77eb200 connected
Nov 17 05:40:38 linux-2wd6 bluetoothd[6845]: State changed 
/org/bluez/6844/hci0/dev_00_1A_45_32_E7_16: HEADSET_STATE_CONNECTING -> 
HEADSET_STATE_CONNECTED
Nov 17 05:40:39 linux-2wd6 bluetoothd[6845]: Received AT+BTRH?
Nov 17 05:40:39 linux-2wd6 bluetoothd[6845]: Received AT+VGS=15
Nov 17 05:40:40 linux-2wd6 bluetoothd[6845]: Received AT+VGM=15

=============

