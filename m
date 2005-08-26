Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] will bluez still works even if isochronous data
	transfer is not being supported ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050826112050.21504.qmail@web35311.mail.mud.yahoo.com>
References: <20050826112050.21504.qmail@web35311.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1125056087.25535.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 26 Aug 2005 13:34:46 +0200

Hi Swathi,

> I want to port bluez protocol stack onto the T-Engine ( which has a
> T-Kernel as the operating System). T-Kernel usb host protocol does not
> support isochronous data transfer. 

what the f* is T-Engine and T-Kernel?

The USB isoc transfer are only needed for the SCO channel in the USB
host transport protocol.

> Where can i find the whole bluez protocol stack ? the *.c files.
> For minimal functionality is it sufficient to have the bluez-libs and
> bluez-utils package as this is being mentioned in the
> http://www.bluez.org/download.html website.

Maybe you should look at www.kernel.org ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
