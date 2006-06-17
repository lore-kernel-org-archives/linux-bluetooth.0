Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060614122439.GA5078@merconline.com>
References: <20060614122439.GA5078@merconline.com>
Date: Sat, 17 Jun 2006 12:24:16 +0200
Message-Id: <1150539856.17539.17.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] sdpd reliably crashes when scanned by Garmin	iQue
	M5
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi James,

> I'm having a bit of a problem with sdpd (actually, have had for about two
> yes). Each time I scan my laptop with my Garmin iQueue M5 (pocketpc), sdpd
> seems to lock up. This problem doesn't show itself when I scan outwards
> from the laptop to other bluetooth devices. obexftp seems to also work
> fine. I can even connect to the 3G network over my cell phone to get on
> the internet. But any time I launch BTExplorer and try and scan my laptop,
> sdpd goes to 100% cpu usage.

we might have fixed that, but maybe we don't. Make sure that you run the
latest CVS version of bluez-libs and bluez-utils and start sdpd with gdb
in the foreground. If you see sdpd busy looping then stop it and get the
backtrace for it.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
