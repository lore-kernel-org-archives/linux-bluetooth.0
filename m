Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051206014920.25823.qmail@web32007.mail.mud.yahoo.com>
From: Paul Gustilo <pgustilo@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206014712.BCA9E13509@sc8-sf-spam2.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: Welcome to the "Bluez-users" mailing list
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
Date: Mon, 5 Dec 2005 17:49:20 -0800 (PST)

Hi Marcel,


Im having a problem with sony ericson S700i. I can
send a picture using opp 
the first time but after it I can not send anymore.
The phone is saying 
Bluetooth busy. I believed that the connection was not
freed... Im not sure 
about it. I need some help here.

Here is some traces from HCI dump...I just cut the
trace, I did not include 
the trace when the the phone is sending the image, I
guess from that point the 
transaction is still okay...


> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
< ACL data: handle 43 flags 0x02 dlen 9
    L2CAP(d): cid 0x004b len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c
credits 30
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 1
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 339
    L2CAP(d): cid 0x0040 len 335 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 329 fcs
0x46 credits 0
> ACL data: handle 43 flags 0x02 dlen 39
    L2CAP(d): cid 0x0040 len 35 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 29 fcs
0x46 credits 0
< ACL data: handle 43 flags 0x02 dlen 11
    L2CAP(d): cid 0x004b len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:15:B9:24:F2:4F class 0x7a0204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
    bdaddr 00:15:B9:24:F2:4F role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status
0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:15:B9:24:F2:4F
type ACL encrypt 0x00
< HCI Command: Change Connection Packet Type
(0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Page Scan Repetition Mode Change (0x20)
plen 7
    bdaddr 00:15:B9:24:F2:4F mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status
0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d)
plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1101 (SP)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 1
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0xf
          count 12
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1103 (DUN)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0042 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0042
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0043
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0043
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1108 (Headset)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0043
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0043
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 3
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x111e (Handsfree)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0044
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0044
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 3
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1105 (OBEXObjPush)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0044 len 20 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0xf
          count 12
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0044
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0044
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0045
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0045 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0046
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0046
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0046 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1118
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0046 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0046
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0046
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0047
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0047
result 0 status 0
      Connection successful
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x112d (SAP)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0047 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0047
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0047
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0049
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0049
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x110b (AudioSink)
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0049 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0049
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0049
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
8
      MTU 256 FlushTO 65535
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x110e
          max 240
          aid(s) 0x0001 (SrvClassIDList)
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5

I hope you can help me with my problem.


Thanks,
Paul



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
