Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Detecting RSSI without connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
References: <qszactrj3c5.fsf@timepilot.gpcc.itd.umich.edu>
Content-Type: text/plain
Message-Id: <1099960170.29330.43.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 01:29:30 +0100

Hi Scott,

> For a project I'm working on, I'd like to determine which of several
> (possibly many) Bluetooth devices is closest.  "Best RSSI" is a good
> enough approximation of "closest" for my purposes, and since there may
> be many devices and I don't have any other interest in them, I'd like
> to get the RSSI without establishing a connection with each device.
> 
> It appears that "hcitool rssi <bdaddr>" requires that a connection is
> established.  Do any cards provide a way of getting RSSI that doesn't
> require establishing a connection?

starting with the Bluetooth 1.2 specification it is possible to get the
RSSI value from the inquiry results. Check the mailing list archives for
more details.

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
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
