Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez and D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Max <spamhole@gmx.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040403190647.GA16596@venus>
References: <20040403190647.GA16596@venus>
Content-Type: text/plain
Message-Id: <1081073362.2839.29.camel@pegasus>
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
Date: Sun, 04 Apr 2004 12:09:23 +0200

Hi Max,

> I have a D-Link DBT-120 (USB Bluetooth dongle) but can't get it to work.
> 
> The problem:
> 
> root@venus:~# lsusb 
> Bus 004 Device 008: ID 0a12:0001 Cambridge Silicon Radio Ltd. 
> <snip>
> 
> root@venus:~# bluefw 004/008
> 
> root@venus:~# hciconfig 
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 
> root@venus:~# hciconfig hci0 up
> Can't init device hci0. Input/output error(5)
> 
> The last command (hciconfig hci0 up) produces an error in syslog:
> 
> Apr  3 20:09:30 venus kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb d91c1954 err -28
> 
> I'm running kernel 2.6.4, the modules that I have loaded are bluetooth
> and hci_usb.

disable CONFIG_BT_HCIUSB_SCO in your kernel config.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
