Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] keys under 2.6.5 and bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404200032.51458.cijoml@volny.cz>
References: <200404200032.51458.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1082414314.4403.84.camel@pegasus>
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
Date: Tue, 20 Apr 2004 00:38:34 +0200

Hi Michal,

> Now I looked into dmesg and thereis:
> 
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> 
> Maybe this will help?

as the error says, this is a XFree86 bug and not a kernel bug ;)

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
