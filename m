Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <433CF32D.1080205@ubuntu.com>
From: Charles Majola <charles@ubuntu.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pairing problem
References: <432E89E8.3040809@ubuntu.com>  <432E910B.4020301@ubuntu.com> <1127295068.495.19.camel@localhost.localdomain>
In-Reply-To: <1127295068.495.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 30 Sep 2005 10:11:25 +0200

Marcel Holtmann wrote:

>Hi Charles,
>
>  
>
>>I have a strange problem. For some reason when I boot my pc, I can't 
>>make outgoing connections from my computer to my cellphone until I 
>>restart bluez services(although already started at boot time, incomming 
>>connections work fine). If I restart my computer, I have to restart 
>>bluez services again so that outgoing connections work. I can't see 
>>anything might cause this, it used to work fine with bluez-{utils,libs}< 
>>2.20. Any ideas ?
>>    
>>
>
>install the latest bluez-utils-2.21 and try again. Run "hcidump -X -V"
>to see what is going on.
>  
>
Here is the outputdevice: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:6D:45:2E:4D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:0E:6D:45:2E:4D type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
 > HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 41 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 5000
    Delay variation: -1
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 4
      MTU 1024
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0048 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0E:6D:45:2E:4D
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:0E:6D:45:2E:4D
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:0E:6D:45:2E:4D
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host


 

>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by:
>Tame your development challenges with Apache's Geronimo App Server. 
>Download it for free - -and be entered to win a 42" plasma tv or your very
>own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
