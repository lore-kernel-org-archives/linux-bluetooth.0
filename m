Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060731145507.69939.qmail@web51407.mail.yahoo.com>
Date: Mon, 31 Jul 2006 07:55:07 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm connection disconnects immediately
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

I did find sdptool browse command to search for rfcomm
channel for various services. But SDPTool output is
always empty. Why is this? Pls let me know. 

Here is HCIdump ouput when i try command 
sdptool browse 00:13:17:03:46:88

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:03:46:88
< HCI Command: Link Key Request Reply (0x01|0x000b)
plen 22

    bdaddr 00:13:17:03:46:88 key
9B5BBF681BF037F70F25654204DB5E99
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:13:17:03:46:88
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x01
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen
10
    bdaddr 00:13:17:03:46:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd
1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0056 scid 0x0040
result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0056 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:03:46:88 name
'Motorola HS850'
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 48
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0056 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0056 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0056 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0056 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host


>Hi Marcel,
   
>  I am using a C program to connect RFCOMM channel to
>headset.
>  How do i find out which RFCOMM channel is supported
>by headset HS850? 
>Is there any bluez command i can use? 
   
>  Pls. let me know.
   
>  regards,
>  Manoj

>>Hi Manoj,

>> I am trying to make RFcomm connection with Motorola
>> HS850 through a DBT120 dongle. I am using linux
>> 2.4.21-40 kernel and bluez 3.1 .
>> I see that the rfcomm connection gets disconnected
>> immediately. Is this how it is supposed to work? I
>> have pasted hcidump below.

>it would be best if you switch to a recent 2.6 kernel
>instead of using
>an old 2.4 kernel.

>What commands are using to connect to that headset?
>Are you sure that
>you are using the correct RFCOMM channel.

>Regards

>Marcel

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
