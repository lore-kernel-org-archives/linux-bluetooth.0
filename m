Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c74b6b3d0711131128t7ddb75c0s9f53657b2173aea6@mail.gmail.com>
Date: Tue, 13 Nov 2007 20:28:29 +0100
From: "Adam Strojek" <zwierzak2003@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <c74b6b3d0711131125s38582456pf64390af9d3e447d@mail.gmail.com>
MIME-Version: 1.0
References: <c74b6b3d0711131125s38582456pf64390af9d3e447d@mail.gmail.com>
Subject: [Bluez-users] Bluez with Kensington Si670m Bluetooth mouse
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

Recently I buy great bluetooth mouse Kensington Si670m. It is good,
but bluez (even the newest) don support the extra buttons to navigate
on web pages (I can press to side my scroll to tigger action like
forward and backward). On Windows this works and also hcidump shows
new events, but bluez don't inform X about this event. Here is hcidump
 -X -V. Do you need something more?

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
// When I pressed into left side
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 ff  02                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 ff  02                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 ff  02                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 ff  02                       .........
// When I pressed into right side
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 01  01                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 01  01                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 01  01                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 01  01                       .........
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 0]
      0000: a1 02 00 00 00 00 00 01  01                       .........

I press here only this special buttons. Probably this is universal method.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
