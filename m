Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcidump, was: rfcomm: permission denied
From: Marcel Holtmann <marcel@holtmann.org>
To: "Zbigniew Diaczyszyn (gmx)" <z.dia@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <003b01c3f65e$371ef400$dc4db850@ULLA>
References: <000d01c3f343$d89f1ad0$e04db850@ULLA>
	 <1076855680.14758.55.camel@pegasus>  <000b01c3f599$04aaf520$de4bb850@ULLA>
	 <1077058491.2665.131.camel@pegasus>  <003b01c3f65e$371ef400$dc4db850@ULLA>
Content-Type: text/plain
Message-Id: <1077147114.2685.11.camel@pegasus>
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
Date: Thu, 19 Feb 2004 00:31:54 +0100

Hi Zbigniew,

> Right. After I had started the hcid daemon. The USB dongle is placed in the notebook.
> 
> Just for understanding: 
> the adress I get from hciconfig is the adress from my USB dongle, and I have to bind it to rfcomm?

yes, hciconfig shows you the local address of your device. For rfcomm
you have to use the remote address.

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
