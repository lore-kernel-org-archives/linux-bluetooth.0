Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <448946B7.6000002@personnelware.com>
Date: Fri, 09 Jun 2006 05:00:23 -0500
From: Carl K <carl@personnelware.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] seg fault in rfcomm
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

carl@asus17:~$ sudo hcitool scan
Scanning ...
        08:00:37:03:EF:36       PM325 by LG
carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4
Connected /dev/rfcomm0 to 08:00:37:03:EF:36 on channel 4
Press CTRL-C for hangup

Segmentation fault
carl@asus17:~$

I was connected with minicom, did a ^AQ (exit without resetting the modem)

just tried again, no probmem.

Carl K


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
