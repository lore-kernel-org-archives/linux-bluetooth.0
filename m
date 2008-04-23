Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: "Jackie" <xhx321@gmail.com>
Date: Wed, 23 Apr 2008 23:41:26 +0800
Message-ID: <funlb1$1om$1@ger.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] Return 'Invalid arguments' status after l2ping
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0515895751=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0515895751==
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
Content-Transfer-Encoding: 7bit

Hello all:
     I compiled the blueZ-2.20 on the mipsel platform, kernel version is 
2.4.21. While execute
the command like "l2ping xx:xx:xx:xx:xx:xx". The shell tips "Connection 
failed: invalid arguments"
immediately.

hcidump the data like this:
/tmp/bin # ../sbin/hcidump -x &
/tmp/bin # HCI sniffer - Bluetooth packet analyzer ver 1.22
device: hci0 snap_len: 1028 filter: 0xffffffff
/tmp/bin # ./l2ping 00:17:4b:54:8d:2e
< HCI Command: Create Connection (0x01|0x0005) plen 13
  2E 8D 54 4B 17 00 18 CC 02 00 00 00 01
Can't connect: Invalid argument
/tmp/bin # > HCI Event: Command Status (0x0f) plen 4
  12 01 05 04

By the way, the bluetooth dongle's HCI version is 1.1

Who could tell me the reason? thanks 




--===============0515895751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0515895751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0515895751==--
