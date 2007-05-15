Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Tue, 15 May 2007 18:40:15 +0000 (UTC)
Message-ID: <loom.20070515T203009-183@post.gmane.org>
References: <loom.20070513T135336-907@post.gmane.org>
	<1179162429.13351.63.camel@violet>
	<loom.20070515T190851-57@post.gmane.org>
	<1179250065.10069.30.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?dbus=2EDBusException=3A=09org=2Ebluez=2Ei?=
	=?utf-8?q?nput=2EError=2EAlreadyExists=3A=09Input=09Already=09exis?=
	=?utf-8?q?ts?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Marcel Holtmann <marcel <at> holtmann.org> writes:
> run "hcidump -X -V" to see what actually happens.

Hi Marcel,

I've tried hcidump but its output doesn't help me ;) As far as I understand the
output it in "Connection pending - Authorization pending" then "Connection
successful" and finally in "Connection refused - PSM not supported" do you know
what this means?

This is the tail of hcidump:

> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0221 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0221 flags 0x00 clen 4
      MTU 48 
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 27
> ACL data: handle 12 flags 0x01 dlen 13
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0221 flags 0x00 result 0 clen 4
      Success
      MTU 48 
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0221 scid 0x0040
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0220 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0042
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0222 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x02 interval 32
    Mode: Sniff
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0221 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0220 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0042 result 2 status 0
      Connection refused - PSM not supported
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 12 mode 0x00 interval 0
    Mode: Active
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x13
    Reason: Remote User Terminated Connection


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
