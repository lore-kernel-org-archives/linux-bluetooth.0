Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluefw problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Joonas =?ISO-8859-1?Q?H=E4m=E4l=E4inen?= <kerberos@mbnet.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1064739488.4196.14.camel@Aielien>
References: <1064703452.10689.38.camel@Aielien>
	<1064732699.5012.26.camel@pegasus>  <1064739488.4196.14.camel@Aielien>
Content-Type: text/plain
Message-Id: <1064781427.5012.33.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 28 Sep 2003 22:37:01 +0200

Hi Joonas,

> thing is, I don't seem to have any bluetooth.o on my mandrake. I spent
> quite a while now searching for it, after I tried to get some usefull
> information from archive :)
> This is output from my lsmod, and thre it is also bluez not bluetooth at
> all. 

you must have it, otherwise you don't these log entires. Try this:

	find /lib/modules/ -name bluetooth.o

> As I told, it works if I first boot into windows, and then reboot to
> mandrake, then I get it working just fine. But if I do hard boot, or
> start right to mandrake, my lsmod looks just same, only difference is
> that my dongel isn't found.
> 
> Also, if I unplug dongel when it has been working, and plug it back, it
> isn't found by hciconfig anymore. Same if I do hciconfig hci0 down and
> then try bring it up again.

This means that the firmware loading didn't succeded. The problem can be
bluetooth.o because it grabs the Broadcom device without firmware.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
