Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] new bthid and switching off sensor in mouse???
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404031108.59037.cijoml@volny.cz>
References: <200404021906.54779.cijoml@volny.cz>
	 <200404030054.21634.cijoml@volny.cz> <1080964638.3456.8.camel@pegasus>
	 <200404031108.59037.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1080984184.2839.2.camel@pegasus>
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
Date: Sat, 03 Apr 2004 11:23:04 +0200

Hi Michal,

> > Actually I diffed them and for the library the only change I see is the
> > support for big endian. The change in the bthid program was only for the
> > udev created device node of uinput.
> 
> No. It strange, I tried it again and problem is still here? Can't it be 
> problem in endian changes in libs?

it can be. Please try to find out if it is part of HCI or SDP endian
changes.

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
