Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connect printer via bluetooth printer adaper
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Klose <mk@pottklose.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20040926T103741-961@post.gmane.org>
References: <loom.20040926T103741-961@post.gmane.org>
Content-Type: text/plain
Message-Id: <1096359475.4684.31.camel@notepaq>
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
Date: Tue, 28 Sep 2004 10:17:55 +0200

Hi Michael,

> I use Debian 3.1. The connection between usb bt dongle and bt printer adapter
> works. (hcitool scan delivers correct address of bt printer adapter, l2ping
> works alls well).
> 
> How do I set up the printer (cups), so that bt connection will be used.

install the bluez-cups package and then setup a printer with your CUPS
manager or whatever you use and type in the URI for that. For example to
use a printer with BD_ADDR aa:bb:cc:dd:ee:ff the URI will be
bluetooth://aabbccddeeff/

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
