Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?us-ascii?Q?Dave=20Dev?= <alwaysgone@seznam.cz>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Message-Id: <18254.476735-32120-513904206-1062794584@seznam.cz>
Cc: 
Mime-Version: 1.0
Reply-To: =?us-ascii?Q?Dave=20Dev?= <alwaysgone@seznam.cz>
Subject: [Bluez-users] =?us-ascii?Q?Errror=20=23=2021?=
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 05 Sep 2003 22:43:04 +0200 (CEST)

Anyone know what this error "21" is at the bottom and why role-switching is refusing to take place?  Can you tell if it's the host (USB dongle) or remote device (client/7650) that is refusing to role-switch?

Thanks in advance.  D.


root@localhost jds]# /usr/sbin/hcidump -x -t
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
1062687133.011099 > HCI Event: Connect Request(0x04) plen 10
B8 50 30 EE 02 00 04 22 50 01
1062687133.011643 < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
B8 50 30 EE 02 00 00
1062687133.026095 > HCI Event: Command Status(0x0f) plen 4
00 01 09 04
1062687133.104082 > HCI Event: Connect Complete(0x03) plen 11 
21 28 00 B8 50 30 EE 02 00 01 00

____________________________________________________________
WWW stranky zdarma na http://www.sweb.cz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
