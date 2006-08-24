Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 24 Aug 2006 23:50:05 +0300
From: Niv <nivv@cs.bgu.ac.il>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <44EE10FD.5060404@cs.bgu.ac.il>
MIME-version: 1.0
Subject: [Bluez-users] 2.25->3.3 can't ping headset
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

Hay,
I decided to try 3.3 in a manual install. I am 2.6.17 gentoo user. I got 
  libs and utils as well as hcidump.
I can ping my nokia cell , but not my headset. I tried erasing  #rm -rf 
/var/lib/bluetooth/ ; then put the headset in pairing mode. then "saw" 
it via hcitool scan; then tried pinging it -> Can't connect: Permission 
denied

all services are up (hcid,sdp,rfcomm) and  hcidump -X -V is:

< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:0D:44:33:E1:63 ptype 0xcc18 rswitch 0x01 clkoffset 0x61fa 
(valid)
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:0D:44:33:E1:63
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
     bdaddr 00:0D:44:33:E1:63
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 00:0D:44:33:E1:63
 > HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:0D:44:33:E1:63
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
     bdaddr 00:0D:44:33:E1:63
 > HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1

it used to work with 2.25.

how to fix?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
