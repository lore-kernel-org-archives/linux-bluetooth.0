Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Watson <tsw@johana.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4118f9dd.johana@johana.com>
References: <4118f9dd.johana@johana.com>
Content-Type: text/plain
Message-Id: <1092208917.4564.235.camel@pegasus>
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
Date: Wed, 11 Aug 2004 09:21:57 +0200

Hi Tom,

> > in the hotplug directories. Maybe your hotplug scripts are too old and
> > they can't work with extra entries under /etc/hotplug/usb/.
> 
> As for the hotplug scripts, the one named 'usb.agent' is at version 1.12
> dated:  2002/4/1.  Is that sufficient.  The other files (usb.rc among
> them) seem to be of similar vintage.  It seems that this version of the
> 'usb.agent' does not check/load from usermap files in the usb directory.
> That appears to be the problem.  I have since upgraded to a later version
> of the script (1.41 dated 2004/04/01) which seems to go into the usb
> directory to get usermap's.  I'll try this to see what happens.

I have these on my Debian Sid machine and everything is working

	$Id: usb.agent,v 1.39 2004/03/26 22:36:38 kroah Exp $
	$Id: usb.rc,v 1.22 2004/03/27 07:44:39 ukai Exp $

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
