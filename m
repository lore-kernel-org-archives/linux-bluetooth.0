Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help id'ing USB bluetooth adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Chiverton <thomas.chiverton@bluefinger.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402111339.48630.thomas.chiverton@bluefinger.com>
References: <200402111236.34361.thomas.chiverton@bluefinger.com>
	 <1076505074.2777.69.camel@pegasus>
	 <200402111339.48630.thomas.chiverton@bluefinger.com>
Content-Type: text/plain
Message-Id: <1076531229.2792.16.camel@pegasus>
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
Date: Wed, 11 Feb 2004 21:27:09 +0100

Hi Thomas,

> > This looks like an USB problem. What kernel version is it? 
> 
> It's wherever RedHat9 is ... uname -a says
> Linux charles-compaq 2.4.20-28.9 #1 Thu Dec 18 13:45:22 EST 2003 i686 i686 
> i386 GNU/Linux

I can't tell you anything about a RedHat kernel.

> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT
> 
> I'm assuming that means despite the syslog error, things are mostly working, 
> though it seems to have failed to detect the address etc. for some reason - 
> any further ideas ?

Can you bring it up with "hciconfig hci0 up"?

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
