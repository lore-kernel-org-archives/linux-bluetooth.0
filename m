Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AUX1 packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Thor Egil Skaug <paxtonrd@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000301c3fe31$fdf2b460$46a57e40@thores>
References: <000301c3fe31$fdf2b460$46a57e40@thores>
Content-Type: text/plain
Message-Id: <1078152924.1942.126.camel@pegasus>
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
Date: Mon, 01 Mar 2004 15:55:24 +0100

Hi Thor,

> Is there any way of having an ACL connection use AUX1 packets?
> 
> The packet type is not defined in the Bluetooth specification for
> the HCI_create_connection command.

you can't control this from the host stack side, because as you already
have seen it is not defined for the HCI_create_connection command. It is
the job of the link manager to choose the right packet types.

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
