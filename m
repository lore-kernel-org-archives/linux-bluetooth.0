Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1121342558.42d6545e9e679@www.webmail.ucl.ac.uk>
From: uceemoa@ucl.ac.uk
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] (Newbie) send strings/messaging using BlueZ
References: <1121264757.42d52475bf449@www.webmail.ucl.ac.uk> <1121335249.6192.8.camel@notepaq>
In-Reply-To: <1121335249.6192.8.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 14 Jul 2005 13:02:38 +0100

Hi Marcel,
Are there any of reference that in the web that i can refer to on doing the
program?

Cheers,
Fikry

Quoting Marcel Holtmann <marcel@holtmann.org>:

> Hi Fikry,
>
> > I'm a newbie in using the BlueZ. Could anyone tell me how to send a message
> or a
> > string from one machine to another via bluetooth e.g. sending "Hello
> World". In
> > my linux machine I downloaded and installed  bluez-hcidump-1.21,
> > bluez-libs-2.17 and bluez-utils-2.17. I did read that I can use rctest.c.
> Could
> > anyone tell me how to do that. Thank you.
>
> you can use the RFCOMM TTY devices and the echo/cat commands or you
> simply write a client/server program using RFCOMM sockets.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted by HP,
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
