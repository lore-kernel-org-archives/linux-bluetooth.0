Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux@feline-soul.com
In-Reply-To: <4253.216.47.59.131.1156884752.squirrel@webmail.feline-soul.net>
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
Date: Wed, 30 Aug 2006 01:00:59 +0200
Message-Id: <1156892459.4026.56.camel@aeonflux.holtmann.net>
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

> I've looked through the blues-utils 3.2 source code directories and not
> seen such a script. Can you point it out to me, or is it code that need to
> be compiled, or a pice of code that needs to be extracted/followed.

it is hcid/passkey-agent.c and it is a C program. You can of course do
the same in Python or any other language with D-Bus bindings.

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
