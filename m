Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Edd Dumbill <edd@usefulinc.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100261630.12168.71.camel@pegasus>
References: <1100260673.8785.20.camel@saag>
	 <1100261630.12168.71.camel@pegasus>
Message-Id: <1100267525.8785.39.camel@saag>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Debian testing required: bcm203x firmware
Content-Type: text/plain
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Nov 2004 13:52:05 +0000

On Fri, 2004-11-12 at 13:13 +0100, Marcel Holtmann wrote:
> the firmware files are in the wrong place. You are using the old
> directory. They must be under /lib/firmware/.

Ah yes, I see that now.

I still tend to think it'd be better to have everything
under /usr/lib/hotplug/firmware, but I understand your reasons, so I'll
change this back.

> Actually I would prefer to have bluez-bcm203x and bluez-firmware,
> because I try to get the AVM and 3Com firmware also into this package.
> This also avoids that people install bluez-bcm203x for their 2.6 kernel
> even if they don't need it. The naming leads to that.

OK, I didn't know you planned other firmwares.  I have no problem with
doing that rename.

> And btw what does it take to get a virtual packages called bluez that
> installs all the needed BlueZ packages?

I can do that too.  Should it include the bcm203x firmware loader or
not?

-- Edd




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
