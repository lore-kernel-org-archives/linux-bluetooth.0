Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] accessing info on paired devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Pall Thayer <palli@pallit.lhi.is>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <41570BC9.6090109@pallit.lhi.is>
References: <41570BC9.6090109@pallit.lhi.is>
Content-Type: text/plain
Message-Id: <1096359364.4684.28.camel@notepaq>
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
Date: Tue, 28 Sep 2004 10:16:04 +0200

Hi Pall,

> I'm working on a little project that would have to automatically scan 
> for bluetooth devices (using a little perl script) and then attempt to 
> connect to them. However, I would prefer if it would only attempt to 
> connect to devices that have already been paired with the computer (via 
> bluetooth usb-dongle) and ignore discovered devices that have not been 
> paired. So, how can I find out which of the discovered devices have been 
> paired?

if there exists a link key for this device then they are paired, but the
problem is that security mode 1 not demands to pair two devices.

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
