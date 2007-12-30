Return-Path: <cyrus@holtmann.org>
From: Timothy Livingston <tim@livingstonautomation.com>
To: bluez-users@lists.sourceforge.net
Date: Sun, 30 Dec 2007 14:58:33 -0500
Message-Id: <1199044713.6648.4.camel@acer>
Mime-Version: 1.0
Subject: [Bluez-users] RFCOMM connection to a cell phone
Reply-To: tim@livingstonautomation.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I am interested in tinkering with my bluetooth devices. I have been
reading the specs for the different profiles. It is my understanding
that I should be able to make an rfcomm connection to my cellphone and
issue AT commands. 

The first time the connect command is issued, the phone and computer
prompt for the key, and they both report that they paired successfully.

However, when using the command "rfcomm connect 0  00:1C:62:3A:7D:69 1"
I get "Can't connect RFCOMM socket: Connection refused".


HCIDump:Results of "sudo hcidump -a"

HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  i } : b . . . . . . . . . 
> HCI Event: Command Status (0x0f) plen 4
  . . . . 
> HCI Event: Role Change (0x12) plen 8
  . i } : b . . . 
> HCI Event: Link Key Request (0x17) plen 6
  i } : b . . 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  i } : b . . . . . . . . H . F . O ` . . 
  . . 
> HCI Event: Command Complete (0x0e) plen 10
  . . . . i } : b . . 
> HCI Event: Connect Complete (0x03) plen 11
  . . . i } : b . . . . 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  . . 
> HCI Event: Command Status (0x0f) plen 4
  . . . . 
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  . . . . 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  . . . . . . . . . . . 
> HCI Event: Command Complete (0x0e) plen 6
  . . . . . . 
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  i } : b . . . . . . 
> HCI Event: Max Slots Change (0x1b) plen 3
  . . . 
> HCI Event: Command Status (0x0f) plen 4
  . . . . 
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x015c scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x015c flags 0x00 clen 4
      MTU 1013 
> HCI Event: Remote Name Req Complete (0x07) plen 255
  . i } : b . . T i m s   L G   V X 8 3 0 
  0 . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . . . . . . 
  . . . . . . . . . . . . . . . 
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x015c flags 0x00 result 0 clen 4
      Success
      MTU 672 
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x015c len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . . 
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x015c len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 666 max_retrans 0 credits 3
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x015c len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x015c len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x015c scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . . 
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x015c scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  . . . 
> HCI Event: Command Status (0x0f) plen 4
  . . . . 
> HCI Event: Disconn Complete (0x05) plen 4
  . . . . 


Any help or suggestions are appreciated!

Thanks!



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
