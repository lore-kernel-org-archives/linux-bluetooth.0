Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pete Stevens <pete@ex-parrot.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0509151651420.23886@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] sdptool -i
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
Date: Thu, 15 Sep 2005 16:56:20 +0100 (BST)

Hi,

My system has multiple bluetooth dongles. How can I specify which dongle
to use with sdptool ? I thought there was a -i option that specified the
interface but this doesn't seem to work.

[root@pstevens root]# hciconfig
hci0:   Type: USB
        BD Address: 00:0E:A1:33:0E:4A ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:303 acl:0 sco:0 commands:14 errors:0

hci1:   Type: USB
        BD Address: 00:0E:A1:33:0E:45 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:303 acl:0 sco:0 commands:14 errors:0


[root@pstevens root]# sdptool -i hci0 search OPUSH
sdptool: invalid option -- i
sdptool - SDP Tool v1.5
Usage:
        sdptool [options] <command> [command parameters]


As far as I can tell, sdptool 1.5 is the latest version. Scanning the mailing
list suggests that the -i option has been mentioned but I can't confirm if
it's been implemented or not.

Many thanks,

Pete Stevens

--
Pete Stevens
pete@ex-parrot.com
http://www.ex-parrot.com/~pete/

             I have kleptomania, but when it gets bad, I take something for it.
                                                                   -- Anonymous


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
