Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] About serial interface bluetooth module
From: Marcel Holtmann <marcel@holtmann.org>
To: mike <mikelee@avantwave.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <416F8FE1.7060509@avantwave.com>
References: <416F8FE1.7060509@avantwave.com>
Content-Type: text/plain
Message-Id: <1097927452.4911.4.camel@pegasus>
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
Date: Sat, 16 Oct 2004 13:50:53 +0200

Hi Mike,

>     I am new to bluez, Here are some questions on serial driver 
> hci_uart.And i am using Fedora2 with bluez-lib-2.10 bluez-util-2.10
> 
>     I am now using a serial bluetooth module, after i install bluez-lib 
> and bluez-util. I can see the rfcomm,l2cap,bluetooth module is loaded. 
> but no hci_uart module.
>     and when i use hciattach /dev/ttyS0......... to attach the serial 
> module, it fail and reply "Initialization timed out". After i insmod 
> hci_uart.ko from /lib/module . It is just the same.
> 
>     The module is work well in MS window and the cable is checked. am i 
> use wrong version or any steps i missed?

you must find the correct parameters for the hciattach call. About what
kind of module are we talking?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
