Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin Bluetooth USB Printer Adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: dave.givens@phaldor.co.uk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <418650E3.3070909@phaldor.co.uk>
References: <418601B6.2010905@phaldor.co.uk>
	 <1099313330.16247.91.camel@pegasus>  <418650E3.3070909@phaldor.co.uk>
Content-Type: text/plain
Message-Id: <1099324636.16247.135.camel@pegasus>
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
Date: Mon, 01 Nov 2004 16:57:16 +0100

Hi Dave,

there must be a "Reply to All" button in your mail client ;)

>     I have installed  bluez-utils-2.10, shutdown linux and restarted,
> but when I enter a custom entry in the print configurer, it will not
> accept it. I am entering in the following format 
> 
> bluetooth://0002456574a3/spp
> 
> is this the incorrect format or am I entering in the wrong place? Is
> there something else I hav'nt done?

you don't need to add the protocol, because the backend will identify
the support protocol by itself. Only fill in the BD_ADDR with the
colons.

Do you tried the web frontend at localhost:631 ?

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
