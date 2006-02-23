Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bitstuffing in a Rfcomm connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1140710294.3302.6.camel@localhost.localdomain>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
	 <1140642881.3319.10.camel@localhost.localdomain>
	 <1140643645.4519.42.camel@localhost>
	 <1140710294.3302.6.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1140713467.24721.45.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 23 Feb 2006 17:51:07 +0100

Hi Agustin,

> Here's the situation. I have an open rfcomm connection which I use
> through a file descriptor, fd: fd = open(devname, O_RDWR | O_NOCTTY);
> 
> I realized that the 'extra bytes' I was reading (using the read
> function) actually are some bytes that I'm periodically writing (using
> the write function) to this file descriptor. It's like I have an 'echo'
> of the bytes I write... I read all the incoming that AND the bytes I'm
> writing  to this fd.

set the TTY into raw mode or use the RFCOMM socket directly.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
