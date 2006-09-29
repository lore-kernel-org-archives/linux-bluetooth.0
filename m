Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean-Jacques Brucker <jjbrucker@free.fr>
In-Reply-To: <200609292208.33700.jjbrucker@free.fr>
References: <17692.1030.64904.774688@altoids.csail.mit.edu>
	<1159530640.6131.31.camel@localhost>
	<200609292208.33700.jjbrucker@free.fr>
Date: Sat, 30 Sep 2006 01:09:22 +0200
Message-Id: <1159571362.29673.34.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid pairing bug when security is auto
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jean-Jacques,

>  There was a bug in hcid when pairing and security is in auto mode.

that is not a bug. It is a feature.

> The code watched if the connection was out or in , but in any case the remote 
> device can ask or not for authentication (and encryption).
> 
> By example Sagem and Ericsson mobile phones ask for authentication/encryption 
> with new devices, whithout watching who is trying to connect first ... !
> 
>  Then the code was looking for pincodes in a file 
> "/var/lib/<local_bdaddr>/pincodes" but that wasn't write by any know 
> applications. (and it is not a place to make file to be write by users...).

This is for debugging purpose and really special use cases.

> Then the code was trying to give the hand to dbus applications ("hey, what 
> this f... i have ask for auto mode !!").

Read the hcid.conf and then you understand what auto means.

>  As i didn't know if there was some software that use the 
> "/var/lib/<local_bdaddr>/pincodes" file i let this file as a first base to 
> search and i have add a config file with the same name (but without the same 
> syntax) in the bluez config directory.

PIN codes are not configuration. They are state file and thus they are
placed under /var/lib.

> Note: Using dbus is a good idea, but it would better to activate it or not 
> with a flag. Because dbus is very big to be embedded on small (and embedded) 
> systems...

No. See other discussion about this topic. I made my decision. People
can still use the 2.x generation or fork or whatever. The upstream BlueZ
goes with D-Bus support. And once you used the D-Bus based API you are
not going back. You can trust me on this. It solves a lot of problems.

> Note2: I have watch in CVS that bluez used a file named pin in confdir... What 
> i have done is not really a regression. In fact we could insert the content 
> of the pincodes file inside the hcid.conf file .... but I don't really know 
> how to do it with bison (and i dislike bisons !-). At the end the syntax of 
> my pincodes file is simple and is read on each HCI "PIN code request" command 
> (when security is set to auto)  and could be more easily manage by extern 
> software (that doesn't use dbus).
> 
> PS: I have make the hcid.conf more explicit but I don't  have patch man pages 
> for now, but if my patch is used, i'll obviously update them. (and with our 
> without my patch, its already need some updates..).

The default mode for the security manager is now user and it will stay
this way. No additional hacks around PIN codes are needed. The passkey
agent interface is the way to go. There exists no argument that can
convince me otherwise. Try using the passkey agent interface and you
will see what I mean. We spent a lot of time getting this right and it
is really nice and handy.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
