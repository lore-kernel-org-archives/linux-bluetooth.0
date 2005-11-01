Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511011108v13f75f08i6291e266eb235a34@mail.gmail.com>
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <1130760726.17124.17.camel@blade>
	 <e1effdeb0510310547m51a457f2m19f00ec5cf194289@mail.gmail.com>
	 <1130850674.31561.65.camel@blade>
	 <e1effdeb0511010521x6dfff470o9580b22bebd1c75d@mail.gmail.com>
	 <e1effdeb0511011108v13f75f08i6291e266eb235a34@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130875099.5048.17.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 01 Nov 2005 20:58:19 +0100

Hi Claudio,

> here is patch to move the find_conn function to lib.c file.

I just realized that I already moved it out of dbus.c and so lets keep
it in hcid as inline function for now.

> Regarding the error related functions, can I move to a error.c file or
> it's better keep them in the dbus.c?

At the moment, I think it is better to keep them there. I don't have any
real opinion at the moment and so it might be better not to move to much
code around.

> Another point is the Disconnect signal. Which approach you preffer
> exit or create a timer to re-connect each x seconds?

We should try to re-connect. The security is still running and so we
can't exit.

> IMHO, I think it not necessary handle this scenario. Restart the
> dbus-daemon is not common.

Every time you update your D-Bus installation. The Ubuntu guys even
popup a message box that you should reboot your system ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
