Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051103085436.GA31046@localhost.localdomain>
References: <20051103072032.GA28568@localhost.localdomain>
	 <1131006878.6634.10.camel@localhost.localdomain>
	 <20051103085436.GA31046@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131008886.6634.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Nov 2005 10:08:06 +0100

Hi Johan,

> > this is great, but I fixed some more issues. After "LOG_ERR," etc. there
> > should be a whitespace and the syslog() call doesn't need a "\n" at the
> > end ;)
> 
> Yeah, I seem to have missed those. I guess nobody's perfect ;)

nobody is, but every cleanup is a step in the right direction. So keep
them coming.

> Could you comment on my question about the possibility of including the
> python test script in the cvs? It would simplify keeping it in sync with
> the daemon when the API changes.

I haven't looked at it, but I have no problem with putting it in the CVS
and also including it in the source package. However this will be then a
script that will never be installed. Is this ok for you?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
