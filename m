Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] No more ptys!
From: Marcel Holtmann <marcel@holtmann.org>
To: GUILLON Gabriel <gabriel.guillon@c-s.fr>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <413587BB.9010206@c-s.fr>
References: <4134B0AC.8030907@c-s.fr> <1093978822.2103.0.camel@pegasus>
	 <413587BB.9010206@c-s.fr>
Content-Type: text/plain
Message-Id: <1094213861.6052.12.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 03 Sep 2004 14:17:41 +0200

Hi Gabriel,

> >>I'm playing around with 2 bluetooth dongle, under linux (me:Debian and 
> >>other:Mandrake), trying rfcomm, hciattach, things like that.
> >>I do that using 'screen' commands.
> >>After a will, I cannot create more screen: "no more pty", says screen!
> >>I user kernel 2.6.8.1, bluez-utils 2.9-3
> > 
> > 
> > this is actually not a Bluetooth problem.
> 
> This only append when I play with BT. It never appended before.
> Few hours before, I played with about 10 screen session with no problem.
> Then I reduced the number of screen sessions, played with BT, tried to 
> open one more screen, then it failed!
> I looked at /dev/pts: there were the number of opened screen session, no 
> more, no less.
> I closes everything but X, then it worked again.
> I conclued with a memory problem (Mozilla, Thunderbird and OOo where 
> open, and my computer is a small computer)
> Day after, played again with BT, with not that much things opened (ie: 
> no ram problems, a priori)
> Same problem arrived: no more ttys.
> Time to reboot...

check the kernel mailing list, because this can't be a Bluetooth
problem. There was a memory related to PTYs so you may wanna check out a
newer kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
