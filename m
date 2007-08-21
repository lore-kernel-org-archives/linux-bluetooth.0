Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0708210825k2b8eb108kb9c77b75d7bf7d26@mail.gmail.com>
Date: Tue, 21 Aug 2007 16:25:47 +0100
From: "Hamid MENOUAR" <menouar@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Can't connect RFCOMM socket: Resource temporarily
	unavailable
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

Dear all,

I'm trying to connect some my laptop (Fedora Core 4) to some bluetooth
device using an ANYCOM bluetooth USB adaptor. Every thing works well
but not when doing the last step. When doing "rfcomm connect rfcomm0
xx:xx:xx:xx:xx:xx" I get this message "Can't connect RFCOMM socket:
Resource temporarily unavailable"

The code is as in follow:

[root@localhost ~]# hciconfig
hci0:   Type: USB
        BD Address: 00:16:38:CA:55:ED ACL MTU: 1017:8 SCO MTU: 64:1
        DOWN
        RX bytes:1642 acl:2 sco:0 events:85 errors:0
        TX bytes:264 acl:1 sco:0 commands:52 errors:0

[root@localhost ~]#
[root@localhost ~]# hciconfig hci0 reset
[root@localhost ~]# hciconfig
hci0:   Type: USB
        BD Address: 00:16:38:CA:55:ED ACL MTU: 1017:8 SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN
        RX bytes:1713 acl:2 sco:0 events:93 errors:0
        TX bytes:295 acl:1 sco:0 commands:60 errors:0

[root@localhost ~]#
[root@localhost ~]# hcitool scan
Scanning ...
        00:0D:18:60:14:8E       Bluetooth-device
[root@localhost ~]#
[root@localhost ~]# /etc/init.d/bluetooth restart
Stopping Bluetooth services:                               [FAILED]
Starting Bluetooth services:                               [  OK  ]
[root@localhost ~]#
[root@localhost ~]# /etc/init.d/bluetooth restart
Stopping Bluetooth services:                               [  OK  ]
Starting Bluetooth services:                               [  OK  ]
[root@localhost ~]#
[root@localhost ~]# l2ping 00:0D:18:60:14:8E
Ping: 00:0D:18:60:14:8E from 00:16:38:CA:55:ED (data size 20) ...
4 bytes from 00:0D:18:60:14:8E id 0 time 50.87ms
4 bytes from 00:0D:18:60:14:8E id 1 time 8.71ms
4 bytes from 00:0D:18:60:14:8E id 2 time 13.76ms
3 sent, 3 received, 0% loss
[root@localhost ~]#
[root@localhost ~]# rfcomm release all
[root@localhost ~]#
[root@localhost ~]# rfcomm connect rfcomm0 00:0D:18:60:14:8E
Can't connect RFCOMM socket: Resource temporarily unavailable
[root@localhost ~]#
[root@localhost ~]# lsmod
Module                  Size  Used by
...
rfcomm                 42333  0
l2cap                  30661  5 rfcomm
hci_usb                18761  1
bluetooth              56133  5 rfcomm,l2cap,hci_usb
...
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]# cat /etc/bluetooth/rfcomm.conf
#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
        # Automatically bind the device at startup
        bind yes;

        # Bluetooth address of the device
        device 00:0D:18:60:14:8E;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "You got me";
}
[root@localhost ~]#


Does anybody know how to solve this problem (Can't connect RFCOMM
socket: Resource temporarily unavailable) ?

Thanks very much for your help.
Menouar

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
