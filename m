Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Device class resetting itself after device is
	removed
From: Marcel Holtmann <marcel@holtmann.org>
To: trejkaz@trypticon.org
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411020056.00919.trejkaz@trypticon.org>
References: <200411012222.49520.trejkaz@trypticon.org>
	 <1099313117.16247.84.camel@pegasus>
	 <200411020056.00919.trejkaz@trypticon.org>
Content-Type: text/plain
Message-Id: <1099319623.16247.102.camel@pegasus>
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
Date: Mon, 01 Nov 2004 15:33:43 +0100

Hi Trejkaz,

> > are you sure that your hcid is running?
> 
> Yup, looks healthy so far:
> 
> [100] trejkaz@raven:~> ps -ef|grep hcid
> root      6821     1  0 Nov01 ?        00:00:00 hcid: processing events                   

if it still doesn't work, you may have to restart it to use your new
settings.

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
