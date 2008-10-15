Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1224083365.5268.3130.camel@cookie.hadess.net>
References: <48F1F7C0.4040705@powercraft.nl>
	<1223819361.31961.1763.camel@cookie.hadess.net>
	<48F5E741.7020907@powercraft.nl>
	<1224078893.5268.2962.camel@cookie.hadess.net>
	<1224083365.5268.3130.camel@cookie.hadess.net>
Date: Wed, 15 Oct 2008 17:16:42 +0200
Message-Id: <1224083803.4764.8.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Re:  Sony Bluetooth BD Remote Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > > I have been working hard to get the bluetooth remote working, but
> > > without success. I build new non official debian packages of the latest
> > > git. I installed them with success. Loaded the new daemon tried to
> > > connect with the bluetooth-wizard but it will not pair/connect. With the
> > > hidd system is does connect but the situation is exactly the same as
> > > with the ordinal report.
> > > 
> > > What commands are needed to get the device working? I would like to be
> > > able to use xbindings --key to attach commands/keybindings to the keys.
> > > 
> > > See the attachment for all the steps I did, the new trials are on the
> > > end of the documents.
> > 
> > I mentioned it in the past, I'll mention it again: DO NOT USE HIDD.
> > 
> > It doesn't have support for the PS3 BD remote. Make sure you have the
> > latest git, I fixed the input event generation for the remote yesterday.
> 
> As it's just the pairing that doesn't work, the bug was in the wizard.
> The code to restrict the PS3 detection to a particular OUI was causing
> problems.

I added the extra OUI. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
