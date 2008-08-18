Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <eba8281a0807260826w7e695b6elfeeee5f7c4c3ec47@mail.gmail.com>
References: <eba8281a0807260826w7e695b6elfeeee5f7c4c3ec47@mail.gmail.com>
Date: Mon, 18 Aug 2008 07:16:55 +0200
Message-Id: <1219036615.7591.23.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] PassKey Agent question
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Valerio,

> I'm doing a program that use bluetooth for  the OpenMoko phones, I
> need a passkey agent to allow paring from some devices that resquest
> that, after I wrote the a passKey agent I notice that by default the
> hcid.conf file in the OpenMoko file system have the security mode set
> to "auto", so my passkey agent don't get called, if I change it to
> "user" everything works fine.
> After some search I found a lot of confusing information so my
> questions are :
> 
> - the Bluez-pin helper in no longer supported right ?
> - By default the security mode is set to "auto" ?
> - Is possible to change it with some bluez util or command ?

the security mode should be user by default. Maybe you have an old
hcid.conf on your system.

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
