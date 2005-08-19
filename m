Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] current state of Microsoft bluetooth mouse
	(scroll wheel)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1124406281.16439.8.camel@localhost.localdomain>
References: <1124406281.16439.8.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1124462940.6398.6.camel@notepaq>
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
Date: Fri, 19 Aug 2005 16:49:00 +0200

Hi Scott,

> I've got a "Microsoft Intellimouse Explorer for Bluetooth", and while it
> does mouse properly, neither the scroll wheel or the extra buttons work.
> I've just patched my kernel with patch-2.6.12-mh2.gz from
> http://www.bluez.org/patches.html, and I have bluetooth-utils 18.1, but
> still no luck. I get nothing out of /dev/input/mice for those buttons or
> the scroll wheel. 

is this the first or second genration of the mouse. I own the first
generation and it works fine in report protocol mode with my -mh patch.
The Bitkeeper repository is out of date, because we don't use Bitkeeper
anymore. The latest stuff is inside the Git repostiories at kernel.org.

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
