Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux@feline-soul.com
In-Reply-To: <200608291908.52176.Linux@feline-soul.com>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<2461.216.47.59.131.1156887151.squirrel@webmail.feline-soul.net>
	<1156895173.4026.59.camel@aeonflux.holtmann.net>
	<200608291908.52176.Linux@feline-soul.com>
Date: Wed, 30 Aug 2006 11:52:35 +0200
Message-Id: <1156931555.4026.79.camel@aeonflux.holtmann.net>
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

> Ok, the passkey-agent runs. But i get errors. Here's what i'm doing:
> 
> 1. Switch to root.
> 1. put headset into paring mode.
> 2. run "btsco 00:0D:44:4F:37:72"
> 3. run "passkey-agent 0000 00:0D:44:4F:37:72"
> 
> I get "Can't get on system bus" from passkey-agent.  Is dbus misconfigured?

might be. You can however use "passkey-agent --default 0000" to be on
the safe side. There is a difference between the default passkey agent
and the application specific passkey agent.

> I know dbus is running.  The "00:0D:44:4F:37:72" is the address of my 
> headset.  "0:07:61:1C:9F:D3" is the address of my hub. I've tried that as 
> well. I've also tried encapsulating the 0000 with quotes in case it is a 
> string. I am running passkey-agent as root.

Not needed to run it as root.

> What am i doing wrong. Is there a way to create the file 
> in /var/lib/bluetooth\00:07:61:1C:9F:D3 by hand?  What should the file be 
> called and what should it contain.

You can use /var/lib/bluetooth/00:07:61:1C:9F:D3/pincodes and add a line
with "00:0D:44:4F:37:72 0000" this will make the need of a passkey agent
for that specific remote device obsolete.

> I am very confused by the configuration of all this. I have seen documentation 
> that states that i need:
> 
> 1. passkey "0000" in my hcid.conf file

No. This PIN code is only for incoming connections.

> 2. a /etc/bluetooth/passkeys/default file.

This is Debian specific crap and has to go away anyway.

> 3. A script to be called in the config file

No longer supported as of 3.x releases.

> 4. and now a passkey agent.

That is of course the preferred way and the distribution should make it
work nicely for you. Especially since bluez-gnome now contains a really
good example for a passkey agent.

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
