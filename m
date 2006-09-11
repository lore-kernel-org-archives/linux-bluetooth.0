Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
To: bluez-users@lists.sourceforge.net
Date: Sun, 10 Sep 2006 18:24:25 -0600
MIME-Version: 1.0
Message-Id: <200609101824.25866.Linux@feline-soul.com>
Subject: [Bluez-users] bluetooth headset: Fuction not Implemented?
Reply-To: Linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

hello folks,

You may recognise my name. I hope you do 'cause i've been trying to get a 
Logitech Bluetooth Traveler headset working for 2 months now. I am using the 
bluetooth hub that came with my logitech keyboard and mouse.

I have the pin code being processed now.  When i try to connect it i see the 
following:
btsco 00:0D:44:4F:37:72
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

hcidump gives me:
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Connect Complete (0x03) plen 11




-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
