Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4407AFCC.4030503@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A2DP alsa no sound
References: <43FDE154.7050803@cs.bgu.ac.il> <43FDFC4E.8040104@xmission.com> 	<4400F1DE.5070804@cs.bgu.ac.il> <4402B812.40204@xmission.com>
In-Reply-To: <4402B812.40204@xmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 03 Mar 2006 04:54:04 +0200

Hope this help:
Starting tommorow I will have better response time :-)

$ cat alsa.pcm.headphones.dump.txt
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:72:E1:03:6A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 41 bdaddr 00:02:72:E1:03:6A type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 25 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 41 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 41
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:02:72:E1:03:6A mode 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 41 slots 5
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:E1:03:6A
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:72:E1:03:6A key 8AEFE6DC3BBFC6D986CAE5B978805227
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:72:E1:03:6A
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 0
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 895
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 41 flags 0x02 dlen 7
     L2CAP(d): cid 0x0054 len 3 [psm 25]
       AVDTP(s): Discover cmd: transaction 0
       0000: 00                                                .
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 25]
       AVDTP(s): Discover rsp: transaction 0
         ACP SEID 1 - Audio Sink
< ACL data: handle 41 flags 0x02 dlen 7
     L2CAP(d): cid 0x0054 len 3 [psm 25]
       AVDTP(s): Capabilities cmd: transaction 1
         ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(d): cid 0x0040 len 12 [psm 25]
       AVDTP(s): Capabilities rsp: transaction 1
         Media Transport
         Media Codec - SBC
           16kHz 32kHz 44.1kHz 48kHz
           Mono DualChannel Stereo JointStereo
           4 8 12 16 Blocks
           4 8 Subbands
           SNR Loudness
           Bitpool Range 2-32
< ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(d): cid 0x0054 len 14 [psm 25]
       AVDTP(s): Set config cmd: transaction 2
         ACP SEID 1 - INT SEID 1
         Media Transport
         Media Codec - SBC
           44.1kHz
           Stereo
           16 Blocks
           8 Subbands
           SNR
           Bitpool Range 2-32
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
     L2CAP(d): cid 0x0040 len 2 [psm 25]
       AVDTP(s): Set config rsp: transaction 2
< ACL data: handle 41 flags 0x02 dlen 7
     L2CAP(d): cid 0x0054 len 3 [psm 25]
       AVDTP(s): Open cmd: transaction 3
         ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
     L2CAP(d): cid 0x0040 len 2 [psm 25]
       AVDTP(s): Open rsp: transaction 3
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 25 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0055 scid 0x0041 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0055 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0055 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 895
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0055 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 41 flags 0x02 dlen 7
     L2CAP(d): cid 0x0054 len 3 [psm 25]
       AVDTP(s): Start cmd: transaction 4
         ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
     L2CAP(d): cid 0x0040 len 2 [psm 25]
       AVDTP(s): Start rsp: transaction 4
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:E1:03:6A role 0x01
     Role: Slave
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 41 slots 5
 > ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 23 scid 0x0056
< ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0056 result 2 status 0
       Connection refused - PSM not supported
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 41 mode 0x02 interval 200
     Mode: Sniff
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0055 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 41 slots 1
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 41 mode 0x00 interval 0
     Mode: Active
 > ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0055 scid 0x0041
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 41 slots 5
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 41 mode 0x02 interval 200
     Mode: Sniff

Brad Midgley wrote:
> Niv
> 
>> I am attaching the whole diff between the mpg123 pipe to a2play that
>> works and the dump from xmms that doesnt.
>> also attaching the xmms output (23M open)
> 
>> 11c11
>> <     L2CAP(s): Connect req: psm 1 scid 0x0040
>> ---
>>
>>>    L2CAP(s): Connect req: psm 25 scid 0x0040
> 
> I haven't been able to dig in but something looks wrong already... isn't
> the correct code going to connect on psm 25 first for the commands and
> then on the detected psm (usually 1) later for the stream? Yet from what
> you've sent it looks like the working version connects to psm 1 first?
> 
> If I read your diff wrong, then maybe it's just that the plugin
> incorrectly tries to go right to streaming without setting it up
> properly using the l2cap connection on psm 25.
> 
> Brad



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
