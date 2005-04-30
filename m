Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Attila Zsigmond <mail@backend-wizard.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Something strange with minicom
References: <200504300003.22570@ByZsA> <1114818982.8836.116.camel@pegasus>
In-Reply-To: <1114818982.8836.116.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200504302029.45490@ByZsA>
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
Date: Sat, 30 Apr 2005 20:29:43 +0200

On Saturday 30 April 2005 01:56, Marcel Holtmann wrote:
> Hi Attila,
> use "hcidump -X -V --psm=3" so I don't have to decode everything by
> myself.
>
> Start hcidump earlier so it can decode the whole connection setup.
>
> Regards
>
> Marcel

Here is a dump with the parameters suggested. It seems normal for me. I 
begin to think that this problem is in relation to my sharp gx15 phone 
configuration and not to bluez. But I'm not sure. What do you think?

HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 41                                                A
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 54                                                T
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 5a                                                Z
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 61                                                a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 74                                                t
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 6 fcs 0x40
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 61                                                a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 74                                                t
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..

Attila 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
