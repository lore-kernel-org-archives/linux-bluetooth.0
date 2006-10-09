Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7d3798db0610090212w7a14212fn76f7e6646e56e873@mail.gmail.com>
Date: Mon, 9 Oct 2006 11:12:18 +0200
From: "=?ISO-8859-1?Q?Robert_Dahlstr=F6m?=" <robert.dahlstrom.4007@student.uu.se>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] A few more RFCOMM questions
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

Thanks for all earlier replies that cleared things up a lot for me. I
still have a few questions about the Serial Port profile though:

After registering a Serial Port profile with sdpd successfully, do I
also need to create a RFCOMM tty to be able to communicate with it? I
have not fully understood how they work with bluez. I looked at the
dund source code and noticed that it did create the ttys itself. Is
this also what I have to do?

(The background is still the Maxell Digital Pen. I have finally got it
to actually send the first parts of RFCOMM data to bluez which is a
great step forward but I still need to be able to talk with it more.
In Windows and with the widcomm stuff it is enough to simply have the
Serial Port service (named 'anotostreaming') and the Pen happily uses
that.)

The output of the communication that takes place if someone finds it
helpful (I took out the initial connection and service discovery
items...): (Everything is ok until the pen detecs an error and then
disconnects, I guess this has to with me not doing enough with the
RFCOMM tty stuff)

--- begin snip ---
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0042
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 17
> ACL data: handle 40 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 1013
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 17
> ACL data: handle 40 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1008 max_retrans 0 credits 1
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 40 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 40 reason 0x13
    Reason: Remote User Terminated Connection
---end snip---




Regards

-- 
Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
