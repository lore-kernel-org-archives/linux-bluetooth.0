Return-Path: <bluez-users-admin@lists.sourceforge.net>
Date: Wed, 22 Dec 2004 16:30:46 -0500 (EST)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: 3com bluetooth card
In-Reply-To: <1103743130.4607.1.camel@tuxlaptop.site>
Message-ID: <Pine.GSO.4.58.0412221625260.20243@gaia3.cc.gatech.edu>
References: <1103743130.4607.1.camel@tuxlaptop.site>
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

Put whatever you want to run (hciattach command) into your rc.local file
(/etc/rc.d) and it will be executed at bootup.

But, if you do not always have your 3com card installed when you boot it
might be better to use the pcmcia subsystem to just run the command when
you insert the card. (on Mandrake I edit the /etc/pcmcia/serial.opts file,
your system may be different).

Jay

On Wed, 22 Dec 2004, Andreas Millinger wrote:

> Hello,
>
> thanks a lot, that has worked properly. And how can I attach the device
> at startup?
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
