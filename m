Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4343EF4F.7010901@ruault.com>
From: Charles-Edouard Ruault <ce@ruault.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Nokia 6680 services....
References: <4340F256.3040605@ruault.com> <1128339452.22437.6.camel@blade>	 <4343953D.7070901@ruault.com> <1128511597.5102.2.camel@localhost.localdomain>
In-Reply-To: <1128511597.5102.2.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------080201010603020900090604"
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
Date: Wed, 05 Oct 2005 17:20:47 +0200

This is a multi-part message in MIME format.
--------------080201010603020900090604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel,

Marcel Holtmann wrote:

>Hi Charles,
>
>  
>
>>thanks for the reply. In the meantime i had dug into the code and
>>figured this out ....
>>I'm now trying to use obexftp to tranfer data to/from my phone but it's
>>failing ( it used to work fine on my motorola e398 ).
>>Here's the log i'm getting:
>>
>>obexftp -b 00:xx:xx:xx:xx:xx -l -v
>>Browsing 00:xx:xx:xx:xx:xx ...
>>No custom transport
>>Connecting...bt: 1
>>done
>>Receiving (null)... failed: (null)
>>Disconnecting...done
>>
>>However, the device does advertise an obex file transfer profile:
>>
>>Service Description: OBEX File Transfer
>>Service RecHandle: 0x10005
>>Service Class ID List:
>>"OBEX File Transfer" (0x1106)
>>Protocol Descriptor List:
>>"L2CAP" (0x0100)
>>"RFCOMM" (0x0003)
>>Channel: 10
>>"OBEX" (0x0008)
>>Language Base Attr List:
>>code_ISO639: 0x454e
>>encoding: 0x6a
>>base_offset: 0x100
>>Profile Descriptor List:
>>"OBEX File Transfer" (0x1106)
>>Version: 0x0100
>>
>>
>>Specifying channel 10 to obexftp does not improve things ...
>>    
>>
>
>show us the output of "hcidump -X -V" for this transaction.
>
>Regards
>
>Marcel
>
>
>
>  
>
I've attached the info you've requested !
I hope it can help.
Regards.

-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C


--------------080201010603020900090604
Content-Type: text/x-log;
 name="dump.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump.log"

HCI sniffer - Bluetooth packet analyzer ver 1.25
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:12:62:A3:80:A5 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 46 bdaddr 00:12:62:A3:80:A5 type ACL encrypt 0x00
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 46 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 46
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:12:62:A3:80:A5 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 46 slots 5
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 46 flags 0x02 dlen 22
    L2CAP(d): cid 0x004a len 18 [psm 0]
      0000: 06 00 00 00 0d 35 03 19  11 06 ff ff 35 03 09 00  .....5......5...
      0010: 00 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 0]
      0000: 07 00 00 00 0f 00 0c 35  0a 35 08 09 00 00 0a 00  .......5.5......
      0010: 01 00 05 00                                       ....
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004a scid 0x0040
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0040
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004b scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004b scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 4
      MTU 1024 
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672 
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 0]
      0000: 03 3f 01 1c                                       .?..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
< ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x004b len 14 [psm 0]
      0000: 03 ef 15 83 11 14 f0 07  00 9b 02 00 07 70        .............p
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 0]
      0000: 01 ef 15 81 11 14 e0 07  00 9b 02 00 03 aa        ..............
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 0]
      0000: 53 3f 01 fd                                       S?..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:12:62:A3:80:A5
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:12:62:A3:80:A5 key FD333123024DD1DE2CC26C56D8DEE191
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:12:62:A3:80:A5
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 53 73 01 36                                       Ss.6
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 0]
      0000: 03 ef 09 e3 05 53 8d 70                           .....S.p
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 01 ef 09 e3 05 53 8d aa                           .....S..
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x004b len 8 [psm 0]
      0000: 03 ef 09 e1 05 53 8d 70                           .....S.p
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 01 ef 09 e1 05 53 8d aa                           .....S..
< ACL data: handle 46 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 0]
      0000: 53 ff 01 21 2d                                    S..!-
< ACL data: handle 46 flags 0x02 dlen 34
    L2CAP(d): cid 0x004b len 30 [psm 0]
      0000: 53 ef 35 80 00 1a 11 00  04 00 46 00 13 f9 ec 7b  S.5.......F....{
      0010: c4 95 3c 11 d2 98 4e 52  54 00 dc 9e 09 31        ..<...NRT....1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 0]
      0000: 51 ff 01 04 f7                                    Q....
> ACL data: handle 46 flags 0x02 dlen 40
    L2CAP(d): cid 0x0041 len 36 [psm 0]
      0000: 51 ff 3f 01 a0 00 1f 10  00 0f a0 cb c3 0f a5 96  Q.?.............
      0010: 4a 00 13 f9 ec 7b c4 95  3c 11 d2 98 4e 52 54 00  J....{..<...NRT.
      0020: dc 9e 09 f7                                       ....
< ACL data: handle 46 flags 0x02 dlen 36
    L2CAP(d): cid 0x004b len 32 [psm 0]
      0000: 53 ef 39 83 00 1c 42 00  19 78 2d 6f 62 65 78 2f  S.9...B..x-obex/
      0010: 66 6f 6c 64 65 72 2d 6c  69 73 74 69 6e 67 00 31  folder-listing.1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 51 ff 07 01 d3 00 03 f7                           Q.......
< ACL data: handle 46 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 0]
      0000: 53 ef 07 81 00 03 31                              S.....1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 51 ff 07 01 a0 00 03 f7                           Q.......
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 51 53 01 7d                                       QS.}
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 0]
      0000: 51 73 01 57                                       Qs.W
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x004b len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004b scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004b scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 46 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 46 reason 0x16
    Reason: Connection Terminated by Local Host

--------------080201010603020900090604--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
