Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket permissions
From: Marcel Holtmann <marcel@holtmann.org>
To: Thor Egil Skaug <paxtonrd@hotmail.com>
Cc: "'BlueZ Mailing List'" <bluez-users@lists.sourceforge.net>
In-Reply-To: <000101c3ffa4$a060e550$46a57e40@thores>
References: <000101c3ffa4$a060e550$46a57e40@thores>
Content-Type: text/plain
Message-Id: <1078157837.1942.145.camel@pegasus>
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
Date: Mon, 01 Mar 2004 17:17:17 +0100

Hi Thor,

> When I use the hciconfig, hcitool, etc. applications that depend on
> raw-data hci-sockets,
> I have to be logged in as root for it to work. If not I get a permission
> denied error.
> 
> Which files do I have to alter permissions on in order for a normal user
> to do this?

there is a limited number of commands and events that are accessable to
everybody. There are no file permissions to change this, because it
depends on CAP_NET_ADMIN rights.

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
