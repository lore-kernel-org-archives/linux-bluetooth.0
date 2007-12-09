Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <475B2922.5090001@aircable.net>
References: <1197153708.12292.247.camel@violet>
	<475B263E.4060801@aircable.net> <1197156509.12292.251.camel@violet>
	<475B2922.5090001@aircable.net>
Date: Sun, 09 Dec 2007 01:42:00 +0100
Message-Id: <1197160920.12292.253.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] [BlueZ-Announce] Release of
	bluez-libs-3.23	and	bluez-utils-3.23
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Manuel,

> > the bluez-utils is not installing any libraries. Never has been and
> > never will be.
> >   
> You are right, but it install the services inside the lib folder, and
> that's making conflicts. If you don't get those to the right folder
> (lib64) in this case, then when you want to use any of those services
> (serial service for example) via dbus you get an error telling that the
> elf version is not right (even though it is, it's elf64)

you can use --libdir here as well.

> > For the bluez-libs this is on purpose and you can overwrite it with
> > --libdir when calling configure. All distros are different and
> > especially with the new multi-arch stuff
> >   
> Ok, isn't there a way to know this from autotools? Actually this is the
> only project that I had faced with such problems.

There is no simple solution. In case of multi-arch systems you wanna
build a 32-bit and a 64-bit version.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
