Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Debian testing required: bcm203x firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100267525.8785.39.camel@saag>
References: <1100260673.8785.20.camel@saag>
	 <1100261630.12168.71.camel@pegasus>  <1100267525.8785.39.camel@saag>
Content-Type: text/plain
Message-Id: <1100269038.7215.6.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 12 Nov 2004 15:17:18 +0100

Hi Edd,

> > the firmware files are in the wrong place. You are using the old
> > directory. They must be under /lib/firmware/.
> 
> Ah yes, I see that now.
> 
> I still tend to think it'd be better to have everything
> under /usr/lib/hotplug/firmware, but I understand your reasons, so I'll
> change this back.

we agreed on this change some time ago. It is official now and Fedora
Core 3 allows only this path while Debian and SuSE also accepts firmware
files in the old one.

> > Actually I would prefer to have bluez-bcm203x and bluez-firmware,
> > because I try to get the AVM and 3Com firmware also into this package.
> > This also avoids that people install bluez-bcm203x for their 2.6 kernel
> > even if they don't need it. The naming leads to that.
> 
> OK, I didn't know you planned other firmwares.  I have no problem with
> doing that rename.

I must resolve the legal issues first, but my plan is to keep all
firmwares in one place.

> > And btw what does it take to get a virtual packages called bluez that
> > installs all the needed BlueZ packages?
> 
> I can do that too.  Should it include the bcm203x firmware loader or
> not?

Please don't and also please don't suggest the installation of it. This
bcm203x tool is a relict for some people that are stuck to 2.4 and the
old Broadcom chips. Actually it seems that Broadcom gave up this chips
and the newer ones are storing the firmware in flash. Maybe you can pop
up a warning message when they install bluez-bcm203x like the lm-sensors
packages do.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
