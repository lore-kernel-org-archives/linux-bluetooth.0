Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Millinger <andreas.millinger@web.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1104073705.4578.2.camel@tuxlaptop.site>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Re: Re: Re: 3com bluetooth card
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
Date: Sun, 26 Dec 2004 16:08:24 +0100

Hello,

what do I have to write in the serial.opts file? Can you maybe send me a
copy of your serial.opts?

Andreas

> 
> Put whatever you want to run (hciattach command) into your rc.local file
> (/etc/rc.d) and it will be executed at bootup.
> 
> But, if you do not always have your 3com card installed when you boot it
> might be better to use the pcmcia subsystem to just run the command when
> you insert the card. (on Mandrake I edit the /etc/pcmcia/serial.opts file,
> your system may be different).
> 
> Jay



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
