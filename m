Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hciemu pb: can't set scan mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Gigie Lertriniva <gigie_lertriniva@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040228140120.70051.qmail@web20727.mail.yahoo.com>
References: <20040228140120.70051.qmail@web20727.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1077978175.2843.85.camel@pegasus>
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
Date: Sat, 28 Feb 2004 15:22:55 +0100

Hi Gigie,

> I created a fake Bluetooth device on my PC using
> hciemu. I can see it with hciconfig, get its status to
> "UP and RUNNING" but I fail to put it to PSCAN:
> 
> bash-2.05b# hciconfig hci1 pscan
> Can't set scan mode on hci1. Invalid request code(56)
> 
> What could be a reason for this problem?

the hciemu don't implements a full HCI. Only a limited number of
commands are supported. Look at the source code for details.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
