Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Linux 2.6.10-rc1 HID problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098722840.6927.4.camel@saag>
References: <1098722840.6927.4.camel@saag>
Content-Type: text/plain
Message-Id: <1098827078.14036.125.camel@pegasus>
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
Date: Tue, 26 Oct 2004 23:44:38 +0200

Hi Edd,

> Running Linux 2.6.10-rc1 I've got the following HID related problems:
> 
> * the multimedia keys on my Apple Bluetooth keyboard no longer work
> (showkey shows nothing)
> 
> * the microsoft bluetooth mouse no longer generates scroll wheel events
> (xev shows nothing)
> 
> hidd is running with --master (the apple keyboard won't successfully
> reconnect otherwise).

this sounds like boot mode and actually 2.6.10-rc1 only supports the
boot mode. For using the report mode, you have to apply my -mh1 patch.

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
