Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] configuring bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
To: arundeep Singh <arundeep78@yahoo.com>
Cc: bluez users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040503184147.83583.qmail@web61102.mail.yahoo.com>
References: <20040503184147.83583.qmail@web61102.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1083686375.4666.36.camel@pegasus>
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
Date: Tue, 04 May 2004 17:59:35 +0200

Hi Arundeep,

> I am working on 2.6.4 kernel. I am trying to configure my bluetooth usb
> dongle by widcomm on my PC. but remain unable to. 

actually nobody here cares ;)

> bluez is there on the system. but i didn't find few of the config
> files. and also the there is no such device name hci0 or so in /dev
> directory.

Do you have an /dev/eth0 ;)

However what do /proc/bus/usb/devices say? Do you loaded the correct USB
host controller driver? Is this a Broadcom based dongle or what?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
