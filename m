Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel panic when unplugging USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Arthur Dent <tobili@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY18-F13k1Ed28kIN400001802@hotmail.com>
References: <BAY18-F13k1Ed28kIN400001802@hotmail.com>
Content-Type: text/plain
Message-Id: <1083763071.4420.11.camel@pegasus>
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
Date: Wed, 05 May 2004 15:17:51 +0200

Hi Arthur,

> I compiled the kernel with the SCO variables set and I
> compiled the kernel where I disabled _any_ kernel variable
> containing SCO in ".config". The behavior did not change.
> I have looked through the mailing lists and I have found
> the hint to shut down the USB device before removing
> it, but when I execute "hciconfig hci0 down" the system
> instantly freezes just as in the case of removing the dongle
> by hand.
> Note, that additionally installing the bluez-kernel-2.3
> package removes the kernel panics.
> Unfortunately the hook-ups are so complete that I am not able
> to obtain any information about the reason from the log files.
> Could you give me a hint how to trace the reason...

installing bluez-kernel-2.3 don't counts, because this code it totally
outdated. What kind of dongle do you use? What do hciconfig -a say?

Do anyone else has problems with hci_usb and 2.4.26, because my test
machine with 2.4.26-mh1 works perfect.

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
