Return-Path: <bluez-users-admin@lists.sourceforge.net>
Date: Wed, 22 Dec 2004 11:33:25 -0500 (EST)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3com bluetooth card
In-Reply-To: <1103732215.5300.6.camel@tuxlaptop.site>
Message-ID: <Pine.GSO.4.58.0412221128450.23233@gaia3.cc.gatech.edu>
References: <1103732215.5300.6.camel@tuxlaptop.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

1) Is it a serial device (I think so)?
 1a) Does the kernel/pcmcia subsystem recognize it as a serial device, and
	add a /dev/ttyS<x> entry for it?
	-try (as root) "tail -f /var/log/messages" and watch the output as
	you plug the card in. Does it bind to a specific tty? (When I plug
	my PCMCIA card in, the kernel assigns it to /dev/ttyS4.)
2) If it's recognized as a serial port, try "hciattach /dev/ttyS<x> any"
(where <x> is replaced by the specific number assigned by your kernel.
  -I'm on a windows box, and can't remember if the 3com card is discussed
	in the man page or not. For my Zoom card I use "hciattach
	/dev/ttyS4 bcsp". Keep watching the tail of /var/log/messages and
	see if an error occurs.
3) Be sure to start up the rest of the bluetooth subsystem. (On my
Mandrake box, this is easy "service bluetooth start", many other
distributions use the same init script system, so it's likely to work for
you too...) [I don't believe that it matters if you do this before or
after you insert the card.

Jay

On Wed, 22 Dec 2004, Andreas Millinger wrote:

> Hello,
>
> I have bought a 3com bluetooth card Version 3. How can I use it? I have
> Suse 9.2 on my Laptop. I read that I must use hciattach. But which
> parameter do I have to use (dev, speed, ...)? Do I have to change the
> bluetooth.conf in /etc/pcmcia/ ? I didnt find the card there. And if
> yes, what do I have to write? Is there a howto for this? I searched the
> mailinglist and the Internet, but I didn't find a answer.
>
> best regards
> Andreas
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
