Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051125165103.GA18967@localhost.localdomain>
References: <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <20051125165103.GA18967@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1132942324.5577.25.camel@blade>
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
Date: Fri, 25 Nov 2005 19:12:04 +0100

Hi Johan,

> > come up with some proposals. I have real clue, but we should have some
> > special rights for the current session user.
> 
> What do you mean by "current session user"?

the currently logged in user can modify settings etc. I think the D-Bus
speaks about at_console or something like that. The idea behind this is
that a local user can use the Bluetooth device, but a remote user can't.
For me that is enough for a default security.

> I'd propose essentially a two level system where you have a level which
> is allowed to do everything, and another one which only allows "normal
> user" operations. root and users belonging to the "bluetooth" (or
> "btadmin" or whatever) group would be on the "everyting allowed" level,
> while everyone else would be on the other.
> 
> Of course this doesn't mean that distributions couldn't replace the
> policy with a more flexible (and complex) one to suit their needs. I'm
> just proposing this to be the default that comes with bluez-utils.
> 
> Also, I don't think it makes sense for the default D-BUS policy (which
> comes with upstream with bluez-utils) to deny a normal user things that
> can anyway be done using libbluetooth directly (e.g. using the command
> line tools).

This will be done by the security settings inside the kernel. The
general rule was to allow all reads, but no writes to normal users.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
