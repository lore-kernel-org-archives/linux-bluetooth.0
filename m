Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid and standby button
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403190110.11645.cijoml@volny.cz>
References: <200403182352.18923.cijoml@volny.cz>
	 <1079654699.3301.98.camel@pegasus>  <200403190110.11645.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079655572.3301.121.camel@pegasus>
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
Date: Fri, 19 Mar 2004 01:19:32 +0100

Hi Michal,

> > actually this is a special key and it needs a special mapping. This
> > means report id 03 with the value 02. I thought my Microsoft spits out a
> > message in the syslog when I press the standby button, but I don't have
> > it handy right now.
> 
> Yes, you are right :)
> 
> Mar 19 01:06:57 notas bthid[525]: Sleep button pressed (ignored)
> 
> So we have to wait till you'll find time :)
> 
> Marcel how do you map special multimedia keys? Via xmodmap? Or via XKB 
> directly in xfree?
> And can you share your mapping file for this keyboard?
> I look for the best way how these keys export into KDE 3.2 hotkeys daemon.

I have no idea, because I never used any of the multimedia keys. I still
use my ten years old Microsoft Natural Keyboard and the most cutting
edge feature of it is the PS/2 adapter ;)

Maybe you should play with the hotkeys program, or write a patch for
bthid to create another input key code.

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
