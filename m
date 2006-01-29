Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43DD19C5.7050207@dds.nl>
From: Johan Uiterwijk Winkel <juw@dds.nl>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------070005020808080407020404"
Subject: [Bluez-users] Problem connection to handsfree handset.
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
Date: Sun, 29 Jan 2006 20:38:45 +0100

This is a multi-part message in MIME format.
--------------070005020808080407020404
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello.

A few days ago I bought a bluetooth handsfree set, but my phone is not
supporting the uploading of phonenumber to the set. Not a big problem,
the set is functioning, but it would ofcource be nice to add the
phonebook to the handset.

As a programmer I thought it would be ease to upload the phonebook to
the handset with AT commands, but untill now I have not been able to
connect to the handset correctly.

The following problem exists (Using Suse Linux 10.0 with the standard
bluetooth tools (except hcidump ;-), downloaded version 1.24 ).

I think i have set up the connection correctly.

When I start minicom (setup to use /dev/rfcomm2, which is using channel
2)  I get the response of the handsfree set in minicom as expected:

AT+BRSF=28 (As described in HANDS-FREE PROFILE 1.5).

>From that moment on it looks like the connection is dead. There is no
response on anything I type into minicom.

Is this a known problem with rfcomm, or is minicom not the correct tool
to talk with the handset ?

I've attached the output of hcidump.

Any help is welcome.

Bye.

Johan.


--------------070005020808080407020404
Content-Type: text/plain;
 name="hcidump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.24
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  . . ` . . . . . . . . . . 
> HCI Event: Command Status (0x0f) plen 4
  . . . . 
> HCI Event: Link Key Request (0x17) plen 6
  . . ` . . . 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  . . ` . . . . > . ] . j Q . R O I , w R 
  . ; 
> HCI Event: Command Complete (0x0e) plen 10
  . . . . . . ` . . . 
> HCI Event: Connect Complete (0x03) plen 11
  . ) . . . ` . . . . . 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  ) . . . 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> HCI Event: Command Complete (0x0e) plen 6
  . . . . ) . 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  . . ` . . . . 
> HCI Event: Max Slots Change (0x1b) plen 3
  ) . . 
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0068 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0068 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0068 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0068 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0068 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 4 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0068 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d 
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0068 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0068 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0068 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0068 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 0 ilen 11 fcs 0xbf 
      A T + B R S F = 2 8 . 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0068 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 1 fcs 0x65 
      A 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0068 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 1 fcs 0x65 
      T 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0068 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 1 fcs 0x65 
      Z 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0068 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 1 fcs 0x65 
      . 
> HCI Event: Number of Completed Packets (0x13) plen 5
  . ) . . . 


--------------070005020808080407020404--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
