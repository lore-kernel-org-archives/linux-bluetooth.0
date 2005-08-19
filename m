Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] current state of Microsoft bluetooth mouse
	(scroll wheel)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1124467117.16439.15.camel@localhost.localdomain>
References: <1124406281.16439.8.camel@localhost.localdomain>
	 <1124462940.6398.6.camel@notepaq>
	 <1124467117.16439.15.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1124467190.6398.19.camel@notepaq>
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
Date: Fri, 19 Aug 2005 17:59:50 +0200

Hi Scott,

> It doesn't actually say what version it is (so i maybe ought to assume
> version 1, but you never know with M$). Is there a good way to tell if
> that patch made a difference? Or should my hidd output have been
> different?

use "hcitool info ..." as root and show us the output.

> Could you explain the details of "report mode" vs "boot mode"? I only
> have a vauge idea of what the difference is.

Look at the mailing list archive or the USB HID specification.

> Also, is this to say that if i use a git kernel, there's no reason it
> shouldn't work perfectly? 

Using a 2.6.12-mh2 kernel should be fine.

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
