Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hotplug
From: Marcel Holtmann <marcel@holtmann.org>
To: Aben Siatris <aben@webcom.sk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404101747.11107.aben@webcom.sk>
References: <200404101126.25631.conardcox@earthlink.net>
	 <200404101747.11107.aben@webcom.sk>
Content-Type: text/plain
Message-Id: <1081613051.5398.1.camel@pegasus>
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
Date: Sat, 10 Apr 2004 18:04:11 +0200

Hi Aben,

> > 	I'm trying to get bluez running on my gentoo linux server so I can connect to 
> > my IPaq 2215.  I've got a connection successfully established, but I'm trying 
> > to automate it with hotplug in hopes of setting up a NAP bridge.  The docs 
> > I've found so far are rather unclear on this subject, but I've created an 
> > '/etc/hotplug/bluetooth.agent' script.  Right now, I'm just trying to get 
> > hotplug to call that script when a connection is established to automatically 
> > configure bnep0, but it only seems to get called on startup when I reboot my 
> > kernel.  I had the impression that 'pand' would emit a hotplug event for 
> > bnep0 when a connection is established, but I'm not so sure now.  Any 
> > guidance about how I might proceed.  Thank you in advance for any information 
> > you may provide.
> 
> not bluetooth.agent, but net.agent.
> you need action after creating NET (bnep0)
> 
> i have iPAQ4155 connected.
> read thread  "No more bluez.o in 2.6?"

I don't know anything about Gentoo, but for Debian you don't have to
touch net.agent. Simply put another rule into /etc/network/interfaces.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
