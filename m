Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Modifying acl packet retransmission rates
From: Marcel Holtmann <marcel@holtmann.org>
To: Sean Loh <blaze_wk@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041028073327.66286.qmail@web41123.mail.yahoo.com>
References: <20041028073327.66286.qmail@web41123.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098960078.6636.9.camel@pegasus>
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
Date: Thu, 28 Oct 2004 12:41:18 +0200

Hi Sean,

> I was wondering if BlueZ is able to modify a Bluetooth
> dongle's acl packet timeout for retransmission or even
> disabling the retransmission rate all by itself.  If
> it is able to be done, what are the methods for
> implementing it.

you can only modify things for that HCI commands exists. This is the
host part of the Bluetooth stack and we don't have access to the link
manager, baseband or radio.

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
