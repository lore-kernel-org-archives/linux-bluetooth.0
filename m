Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidp and connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405141524.04481.cijoml@volny.cz>
References: <200405141524.04481.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1084556671.25099.201.camel@pegasus>
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
Date: Fri, 14 May 2004 19:44:32 +0200

Hi Michal,

> when hidd is not started and device wants connect, system prints errors about 
> unknown connections.

what kind of errors are you talking about? You must be more specific.

> 1) Maybe we should have somewhere in /etc/bluetooth list of allowed devices 
> which will be accepted without hidd runnnig?

Why should we accept a device when hidd is not running?

> 2) When hidp and other modules compiled directly into kernel, we should under 
> single mode allow all hid devices to connect without hidd running to allow 
> users maintain their system without any daemons running

This is impossible. If you need this, you have to go with Bluetooth
dongles that implement HID proxy.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
