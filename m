Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm: permission denied
From: Marcel Holtmann <marcel@holtmann.org>
To: "Zbigniew Diaczyszyn (gmx)" <z.dia@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000d01c3f343$d89f1ad0$e04db850@ULLA>
References: <000d01c3f343$d89f1ad0$e04db850@ULLA>
Content-Type: text/plain
Message-Id: <1076855680.14758.55.camel@pegasus>
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
Date: Sun, 15 Feb 2004 15:34:40 +0100

Hi Zbigniew,

> sorry, but the file is empty :-(
> 
> ---------------------------------------------------------------
> 
> linux:/home/dia # hcidump -w hcidump.log
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> linux:/home/dia # ls -l hcidump.log
> -rw-rws---    1 root     root            0 Feb 13 23:32 hcidump.log

if this happens then there was no traffic on the HCI layer. Check again,
because this can't be true.

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
