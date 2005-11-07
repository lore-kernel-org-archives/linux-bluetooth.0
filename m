Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter getting
Message-ID: <20051107121354.GA9950@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain> <1131315924.5824.14.camel@blade> <20051107093436.GB6845@localhost.localdomain> <1131359661.5824.97.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131359661.5824.97.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 7 Nov 2005 14:13:54 +0200

Hi Marcel,

On Mon, Nov 07, 2005, Marcel Holtmann wrote:
> The num_responses and the IAC should be separate setting. It would be
> great if this setting is specific to the D-Bus session of the caller. In
> this case every D-Bus user can have its own settings. Do you think this
> is possible?

Sure. We could either maintain a table of settings for each D-BUS peer
using the unique name that the bus assigns for each connection, or we
could also do the settings based on the unix user id of the client
application (using the dbus_bus_get_unix_user function).

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
