Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Getting installed usb bluetooth adaptor into
	linux system
From: Marcel Holtmann <marcel@holtmann.org>
To: David Mezkiriz <dmezkiriz@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20040721T155547-62@post.gmane.org>
References: <loom.20040721T155547-62@post.gmane.org>
Content-Type: text/plain
Message-Id: <1090478946.21828.12.camel@pegasus>
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
Date: Thu, 22 Jul 2004 08:49:06 +0200

Hi David,

> I've got a usb bluetooth adapter 100Mb from Conceptronic,
> a no well-known hardware company, I've been struggling 
> trying to get installed bluetooth in my PC and laptop
> but I didn't succeed in it. So my last hope is to ask 
> for some help:
> 
> I installed rpm packages you updated in my redhat 9.0
> pc. When I plug my bluetooth adaptor I don't know how
> to proceed in order to get a device (like /dev/sda1 or
> so) to mount the system, at least that's what I
> expected. 
> I may be mistaken, so could you please tell me how to
> proceed, or Could you tell me a good how-to?. 

network adapters don't use any device nodes and so Bluetooth also don't
uses them. Look at the output of "dmesg" and check "hciconfig -a". What
is the content of /proc/bus/usb/devices?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
