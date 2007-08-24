Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0708240706t22fd0f73p29220630ed9a7644@mail.gmail.com>
Date: Fri, 24 Aug 2007 15:06:33 +0100
From: "Hamid MENOUAR" <menouar@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1187957880.15402.157.camel@violet>
MIME-Version: 1.0
References: <BAY122-F23EB2BD61028C16F758A23FFD50@phx.gbl>
	<1187957880.15402.157.camel@violet>
Subject: Re: [Bluez-users] Can't connect RFCOMM
	socket:Resourcetemporarilyunavailable
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
I think it's better that I give you all the output I got from the
beginning in order to understand  better the situation.

The output is as follow:

[root@localhost ~]# hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

[root@localhost ~]# hciconfig hci0 reset
Can't set scan mode on hci0: Device or resource busy (16)
[root@localhost ~]# hciconfig hci0 reset
[root@localhost ~]#
[root@localhost ~]# hciconfig hci0
hci0:   Type: USB
        BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8 SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN
        RX bytes:146 acl:0 sco:0 events:17 errors:0
        TX bytes:65 acl:0 sco:0 commands:17 errors:0

[root@localhost ~]#
[root@localhost ~]# hcitool scan
Scanning ...
        00:0D:18:60:14:8E       Bluetooth-device

[root@localhost ~]#
[root@localhost ~]# /etc/init.d/bluetooth restart
Stopping Bluetooth services:                               [FAILED]
Starting Bluetooth services:                               [  OK  ]
[root@localhost ~]# /etc/init.d/bluetooth restart
Stopping Bluetooth services:                               [  OK  ]
Starting Bluetooth services:                               [  OK  ]
[root@localhost ~]#
[root@localhost ~]# l2ping 00:0D:18:60:14:8E
Ping: 00:0D:18:60:14:8E from 00:16:38:CA:56:A8 (data size 20) ...
4 bytes from 00:0D:18:60:14:8E id 0 time 52.69ms
4 bytes from 00:0D:18:60:14:8E id 1 time 9.75ms
4 bytes from 00:0D:18:60:14:8E id 2 time 29.74ms
4 bytes from 00:0D:18:60:14:8E id 3 time 31.71ms
4 sent, 4 received, 0% loss
[root@localhost ~]#
[root@localhost ~]# rfcomm release all
[root@localhost ~]#
[root@localhost ~]# rfcomm bind 00:0D:18:60:14:8E
[root@localhost ~]# rfcomm
rfcomm0: 00:0D:18:60:14:8E channel 0 clean
[root@localhost ~]#
[root@localhost ~]# rfcomm connect rfcomm0 00:0D:18:60:14:8E
Can't connect RFCOMM socket: Resource temporarily unavailable
[root@localhost ~]#
[root@localhost ~]# lsmod
Module                  Size  Used by
...
rfcomm                 42333  1
l2cap                  30661  5 rfcomm
hci_usb                18761  0
bluetooth              56133  3 rfcomm,l2cap,hci_usb
...
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
        channel 0;

        # Description of the connection
        comment "GPS: You got me";
}
[root@localhost ~]#
[root@localhost ~]# sdptool search DUN
Inquiring ...
Searching for DUN on 00:0D:18:60:14:8E ...
[root@localhost ~]#
[root@localhost ~]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff


What do you think ? any idea ?

Many thanks in advance,
Menouar


On 8/24/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
> > have u tried "l2ping" to your device?
> > try sdptool,hcitool also..check services running on ur gps device.
> > if tht doesn't help.
> > then check the services running on other laptop(which u have tried
> > successfully) and compare those with urs.
>
> as usual. Include "hcidump -X -V" output.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
