Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux@feline-soul.com
In-Reply-To: <2461.216.47.59.131.1156887151.squirrel@webmail.feline-soul.net>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
	<e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
	<e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
	<e1effdeb0608281114l3b6a29barfb8c6b29b7197638@mail.gmail.com>
	<1270.216.47.59.131.1156790715.squirrel@webmail.feline-soul.net>
	<1156799718.5613.48.camel@aeonflux.holtmann.net>
	<36756.216.47.59.131.1156793990.squirrel@webmail.feline-soul.net>
	<1156809299.5613.56.camel@aeonflux.holtmann.net>
	<2056.216.47.59.131.1156803892.squirrel@webmail.feline-soul.net>
	<1156848432.5613.67.camel@aeonflux.holtmann.net>
	<1345.216.47.59.131.1156883686.squirrel@webmail.feline-soul.net>
	<1156890900.4026.49.camel@aeonflux.holtmann.net>
	<4253.216.47.59.131.1156884752.squirrel@webmail.feline-soul.net>
	<1156892459.4026.56.camel@aeonflux.holtmann.net>
	<2461.216.47.59.131.1156887151.squirrel@webmail.feline-soul.net>
Date: Wed, 30 Aug 2006 01:46:13 +0200
Message-Id: <1156895173.4026.59.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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

> I looked it over. I am only just starting to learn C so this is a little
> daunting. I tried a "gcc -Wall -o passkey-agent -passkey-agent.c" and that
> didn't work (i didn't really expect it to). I didn't see a configure
> script that would create a make file for the agent.

after ./configure you can run make and it will compile passkey-agent for
you. It will always be compiled, but never be installed.

> If my X system goes down, all of my paring  devices will go down with it,
> since i would need gnome up to get them working. How can i get this agent
> working?

Once the devices are paired. You have a link key. The hcid handles this
for you. You need the passkey agent only for entering the PIN code.

> I'm just confused. Since the bluez-gnome is a new release, what did people
> do before it arrived to get pairing devices working?

Actually I expected that someone else will write the appropriate passkey
agents for their desktop systems. So in the end I did for the one that I
use. Only the Nokia 770 Maemo platform had its own passkey agent.

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
