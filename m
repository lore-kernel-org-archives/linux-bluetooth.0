Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] newbie: Is Bluez only for  PC's or does it work
	on any linux kernel version 2.4.x .?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050823050058.8940.qmail@web35314.mail.mud.yahoo.com>
References: <20050823050058.8940.qmail@web35314.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1124780783.23599.122.camel@pegasus>
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
Date: Tue, 23 Aug 2005 09:06:23 +0200

Hi Swathi,

> This is my first question on the bluez forum. I have the embedded
> linux board sitsang-400 from Intel (processor PXA255).  Linux 2.4.19
> B-1-2-1 Kernel runs on this. This version of Linux doesn't support
> Bluez. Through the bluez.org website i was able to find out that by
> installing the Linux Kernel Patch 2.4.19, i would be able to support
> and communicate between bluetooth devices. My question is 
> Does this Bluez work only on the PC's which has linux O.S 2.4.x
> versions or will i be able to install on any of the embedded linux
> boards which has the linux kernel version 2.4.x

in general BlueZ should work with any embedded board and any 2.4 Linux
kernel. However the support for the 2.4 kernel series is deprecated and
you should really move to a 2.6 kernel for any further development.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
