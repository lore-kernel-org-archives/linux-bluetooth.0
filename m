Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] new bthid and switching off sensor in mouse???
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404030054.21634.cijoml@volny.cz>
References: <200404021906.54779.cijoml@volny.cz>
	 <200404022335.41175.cijoml@volny.cz> <1080945468.3456.1.camel@pegasus>
	 <200404030054.21634.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1080964638.3456.8.camel@pegasus>
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
Date: Sat, 03 Apr 2004 05:57:18 +0200

Hi Michal,

> cvs up -D "23 days ago" libs2 utils2

the time range of 23 days was here important, because I didn't know
about what source you were talking ;)

Actually I diffed them and for the library the only change I see is the
support for big endian. The change in the bthid program was only for the
udev created device node of uinput.

You don't tried the bthidd or bthidc program, do you?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
