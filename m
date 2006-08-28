Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1270.216.47.59.131.1156790715.squirrel@webmail.feline-soul.net>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
	<e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
	<e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
	<e1effdeb0608281114l3b6a29barfb8c6b29b7197638@mail.gmail.com>
	<1270.216.47.59.131.1156790715.squirrel@webmail.feline-soul.net>
Date: Mon, 28 Aug 2006 23:15:18 +0200
Message-Id: <1156799718.5613.48.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I reset a pairing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Bearcat,

> I get that message too. However, i have "pin_helper
> /usr/lib/kdebluetooth/kbluepin;" in my config file. I can run this
> kbluepin from the cli and it starts fine and returns "PIN:000" if i enter
> 0000. Why isn't this firing up for me when i try to connect?
> 
> I'll try the bluez-gnome agent, but i try to avoid gnome stuff so i don't
> have all those libs installed.

the PIN helper stuff have been removed from the 3.x releases. You need
to use a passkey agent. However the KDE-Bluetooth guys might simply
extend their kbluepin with a passkey agent and then it will work without
any GNOME program. However that is up to the KDE guys and not to me.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
