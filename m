Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DiNovo and bluetooth-hub functionality
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1111179050.8427.5.camel@localhost.localdomain>
References: <906f7190caa2.90caa2906f71@liu.se>
	 <1111176683.9600.39.camel@pegasus>
	 <1111179050.8427.5.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1111180341.9600.48.camel@pegasus>
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
Date: Fri, 18 Mar 2005 22:12:21 +0100

Hi Mattias,

> > you need a running "hidd --server". They will reconnect to this server
> > after a keypress.
> 
> Well, how can I get that? Remember that I've only been on a Linux-system
> for two days now, and I really don't know that much =)
> 
> I actually tried starting up the computer, logging into GNOME and then
> directly logging of. Then the system says "shutting down Bluetooth
> services" so they must indeed be running.
> 
> But... when I disconnect my spare keyboard and start up the computer
> again, and Gnome shows the login screen, the is NO result from the
> diNovo keyboard / mouse / mediapad. Tried pushing the connect buttons on
> both them AND the hub - won't do it.
> 
> Is it really possible to get the system to recognize my keyboard at
> startup. Has anyone had success with that?
> 
> I'd tried running "hidd --server" directly after logging in, but that
> won't do it. I still have to press the connect buttons, do "hidd
> --search" or alternatively "hidd --connect ADRESS" for each device.
> 
> I didn't think it would be this hard... =/

check /etc/default/bluez-utils and look at HIDD_ENABLED. If Ubuntu uses
the Debian BlueZ packages then this might work.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
