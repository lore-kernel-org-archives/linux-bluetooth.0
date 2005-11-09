Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [DBUS PATCH] Disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511090514g2aab5a3dg5ed3810f244b6b31@mail.gmail.com>
References: <e1effdeb0511070401v66d86898n41277902d0fbfa9b@mail.gmail.com>
	 <e1effdeb0511080829n4795636ewfb85de47383da57c@mail.gmail.com>
	 <1131488528.5544.17.camel@blade>
	 <20051108231118.GA13205@localhost.localdomain>
	 <e1effdeb0511090514g2aab5a3dg5ed3810f244b6b31@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131551532.5544.110.camel@blade>
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
Date: Wed, 09 Nov 2005 16:52:12 +0100

Hi Claudio,

> If the first "disconnect" patch is not integrated yet, please ignore
> it. It was missing close the HCI socket :)  and I changed some code
> style.

please redo this patch, because I am not fully happy with it. The
DBUS_RECONNECT_TIME should be defined (5 * 1000 * 1000) to make it easy
for people to change it. The compile will optimize this away anyhow.

Please don't change any error messages to repeat the function name. This
is not helpful if you are really looking for problems. Using grep inside
the source to find a error message is really helpful.

Can't reconnect_timer_handler() and reconnect_timer_start() be static?

Check your whitespace. There is no need to have useless whitespaces at
the end of a line. If an if-statement is over multiple lines we still
use tabes and we are not trying to align it with anything of the line
above. In fact we use two tabs to indent more then the actual code
inside the statement. See the rest of the file for examples.

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
