Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Feldman <wb0gaz@hotmail.com>
To: bluez-users@lists.sourceforge.net
Cc: wb0gaz@hotmail.com
Message-Id: <20040620170410.96A6F530.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Bluez-users] rfcomm - "Connection refused"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 20 Jun 2004 17:04:10 -0600

This continues my work to get a bluetooth connection going from
my RH9 laptop to a Sony Ericsson T68 (not i) cell phone.

I've created /dev/rfcomm0 (and 1, 2, 3) per below.

The situation I'm encountering is this - when I issue rfcomm command
to link /dev/rfcomm0 to the DUN service in the phone (which I believe
is on channel 1 per sdpscan), I encounter "connection refused".

I've edited /etc/bluetooth/rfcomm.conf to reflect my phone's MAC 
address
and RFCOMM use of channel 1.

I've edited /etc/bluetooth/bluepin and /etc/bluetooth/pin to reflect 
a simple
4-digit PIN I often use. The phone never asks for a PIN (it normally 
does when
I am linking from the windows laptop or win ce device to the phone...)

The sequence of commands I am using is below - hciconfig up to enable
the bluetooth card (that appears to be working, I've been able to use 
a number
of other commands to interact with the phone), then rfcomm which is my
attempt to link /dev/rfcomm0 with the DUN service of the phone. I 
then try
to make a serial connection to /dev/rfcomm0 (I've tried minicom as 
well as
the cat command below.) Any serial connection to /dev/rfcomm0 results 
in
the "connection refused" message.

Further down in this posting is the output of hcidump that occurs at 
the time
I issue the cat </dev/rfcomm0 command below.
 
Dave
wb0gaz@hotmail.com

==================================================

crw-r--r--    1 root     root     216,   0 Jun 15 04:16 /dev/rfcomm0

----------------------------------------------------------------------
----

hciconfig hci0 up
rfcomm bind /dev/rfcomm0 MAC-ADDRESS 1
rfcomm
  --->  rfcomm0: MAC-ADDRESS channel 1 clean
cat </dev/rfcomm0
  --->  bash: /dev/rfcomm0: Connection refused
rfcomm
  --->  rfcomm0: MAC-ADDRESS channel 1 closed

----------------------------------------------------------------------
----

HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0055 scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0055 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 251 
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 251 
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0055 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x55 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x55 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 
246 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 19
    L2CAP(d): cid 0x40 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 0 pri 7 ack_timer 0 frame_size 
246 max_retrans 0 credits 0
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x55 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73 
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x55 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0055 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0055 scid 0x0040
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
