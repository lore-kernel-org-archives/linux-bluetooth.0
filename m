Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Connection failed error (110)
From: Marcel Holtmann <marcel@holtmann.org>
To: KEYUR DESAI <keyurde@nortelnetworks.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E337F6C8A5154F4C8E95349BA276D63008FBC4@zrtphxm0.corp.nortel.com>
References: 
	 <E337F6C8A5154F4C8E95349BA276D63008FBC4@zrtphxm0.corp.nortel.com>
Content-Type: text/plain
Message-Id: <1099446446.7125.68.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 03 Nov 2004 02:47:26 +0100

Hi Keyur,

there must be a "Reply to All" button in the your mail client ;)

> Here is my result of hcidump -X while doing 
> 
> 
> calhost keyur]$ su 
> Password: 
> [root@localhost keyur]# hciconfig hci0 up 
> [root@localhost keyur]# hciconfig hci0 down 
> [root@localhost keyur]# hciconfig hci0 up 
> Can't init device hci0. Connection timed out(110) 
> [root@localhost keyur]# hciconfig hci0 up 
> Can't init device hci0. Connection timed out(110) 
> [root@localhost keyur]# hciconfig hci0 
> hci0:   Type: USB 
>         BD Address: 00:0A:3A:50:4B:4D ACL MTU: 192:8  SCO MTU: 64:8 
>         DOWN 
>         RX bytes:83 acl:0 sco:0 events:10 errors:0 
>         TX bytes:40 acl:0 sco:0 commands:11 errors:0 
>   
> [root@localhost keyur]# /etc/init.d/bluetooth start 
> Starting Bluetooth subsystem: hcid sdpd rfcomm. 
> [root@localhost keyur]# hciconfig hci0 up 
> Can't init device hci0. Connection timed out(110) 
> [root@localhost keyur]#
> 
> 
> 
> root@localhost keyur]# hcidump -X 
> HCIDump - HCI packet analyzer ver 1.12 
> device: hci0 snap_len: 1028 filter: 0xffffffff 
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0 
> >HCI Event: Command Status (0x0f) plen 4 
>   0000: 00 01 00 00                                       .... 
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0 
> >HCI Event: Command Complete (0x0e) plen 12 
>   0000: 01 03 10 00 ff ff 0f 00  00 00 00
> 00              ............ 
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0 
> >HCI Event: Command Complete (0x0e) plen 11 
>   0000: 01 05 10 00 c0 00 40 08  00 08 00                 ......@.... 
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0 
> >HCI Event: Command Complete (0x0e) plen 10 
>   0000: 01 09 10 00 4d 4b 50 3a  0a 00                    ....MKP:.. 
> < HCI Command: Set Event Filter (0x03|0x0005) plen 2 
>   0000: 00 00                                             .. 
> >HCI Event: Command Complete (0x0e) plen 6 
>   0000: 01 25 0c 00 60 00                                 .%..`. 
> < HCI Command: Write Page Timeout (0x03|0x0018) plen 2 
>   0000: 00 80                                             .. 
> >HCI Event: Command Complete (0x0e) plen 4 
>   0000: 01 05 0c 12                                       .... 
> < HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2 
>   0000: 00 7d                                             .} 
> >HCI Event: Command Complete (0x0e) plen 4 
>   0000: 01 18 0c 00                                       .... 
> >HCI Event: Command Complete (0x0e) plen 4 
>   0000: 01 16 0c 00                                       .... 
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1 
>   0000: 03                                                . 
> >HCI Event: Command Complete (0x0e) plen 4 
>   0000: 01 1a 0c 00                                       .... 
> < HCI Command: Reset (0x03|0x0003) plen 0 
> >HCI Event: Command Complete (0x0e) plen 4 
>   0000: 01 03 0c 00                                       .... 
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> 
> 
> Also regarding the kernel confirmation
> 
> I did a uname -a and I get
> 
> Linux localhost.localdomain 2.6.5-1.358 # Sat May 8 .....

please try the latest 2.6.10-rc1-bk12 and repeat these steps. What is
your kernel config (only the CONFIG_BT_* part)?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
