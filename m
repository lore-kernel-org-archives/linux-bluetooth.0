Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] compiling bluez/obex (btobex)
From: Marcel Holtmann <marcel@holtmann.org>
To: Massimiliano Cuccia <massimiliano_cuccia@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040927191505.32405.qmail@web53202.mail.yahoo.com>
References: <20040927191505.32405.qmail@web53202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096355726.4684.1.camel@notepaq>
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
Date: Tue, 28 Sep 2004 09:15:26 +0200

Hi Massimiliano,

> > the INSTALL document says to execute ./configure,
> > but
> > the file is not included.
> OK, reading some documentation about autoconf I have
> found that is needed to run aclocal before running
> autoconf.

simply call ./bootstrap in the CVS repository. It will do the correct
autoconf/automake work for you and after that you can proceed with
calling configure and so on.

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
