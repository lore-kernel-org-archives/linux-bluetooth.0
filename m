Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45C22E9E.2090808@pracucci.com>
Date: Thu, 01 Feb 2007 18:17:02 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Users ML <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Broadcom: ACL packet for unknown connection handle
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

Dear Marcel,

I own several Bluetooth adapters and I've experienced a strange behavior 
with Broadcom-based USB dongles. Most time the kernel sends an HCI 
"Create connection" command to the adapter, it returns two ACL data 
packets (data length is 0) before the "Connection complete" event. I've 
read that a similar behavior has alreay been discussed in this mailing 
list, always with Broadcom based adaptors.

Since this behavior does not seem to be critical, I would like to know 
if it could be a problem for the kernel/bluez. In particular, does it 
badly affect any internal data structure or connection state? Is there 
any problem for Bluez (except that these two packets are lost)?

The following is a "double dump" of the problem.


--- start dump  ---

2007-02-01 17:52:40.275219 < HCI Command: Create Connection 
(0x01|0x0005) plen 13
bdaddr 00:07:80:81:03:52 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-02-01 17:52:40.275219 < 01 05 04 0D 52 03 81 80 07 00 18 CC 02 00 
00 00 00

2007-02-01 17:52:40.278016 > HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-02-01 17:52:40.278016 > 04 0F 04 00 01 05 04
 
2007-02-01 17:52:40.522009 > ACL data: handle 11 flags 0x01 dlen 0
2007-02-01 17:52:40.522009 > 02 0B 10 00 00

2007-02-01 17:52:40.535023 > ACL data: handle 11 flags 0x01 dlen 0
2007-02-01 17:52:40.535023 > 02 0B 10 00 00

2007-02-01 17:52:40.693007 > HCI Event: Connect Complete (0x03) plen 11
status 0x00 handle 11 bdaddr 00:07:80:81:03:52 type ACL encrypt 0x00
2007-02-01 17:52:40.693007 > 04 03 0B 00 0B 00 52 03 81 80 07 00 01 00

--- end dump ---


Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
