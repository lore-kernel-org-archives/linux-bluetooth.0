Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48C4E8E6.7090906@access-company.com>
References: <48075B6A.2060308@access-company.com>
	<1209058941.12684.37.camel@violet.holtmann.net>
	<48355289.7070906@access-company.com>
	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
	<48357D9C.9080009@access-company.com>	<486A6392.6080008@access-company.com>
	<1218148463.7819.44.camel@californication>
	<48C4E8E6.7090906@access-company.com>
Date: Mon, 08 Sep 2008 11:32:14 +0200
Message-Id: <1220866334.6714.142.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
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

Hi Frederic,

> Great you could start integrating.
> Please find attached the remaining patches.

the 0001 patch contains an extra setup variable that is not used in the
patch at all. Remove it from it.

The 0002 patch mixes the non-understood changes with the setup changes.
Also can we just use flags variable in the session instead of setup. The
UUID handling could be done a little bit more elegant.

What is the point behind 0003 patch?

I think 0004 patch needs some cleanup. It looks too hackish.

The 0006 patch is not how we handle this. Either use the exported
version number of the BNEP module or we have to add an ioctl for it.

Please don't hijack a thread for this and send these patches one by one
to linux-bluetooth@vger.kernel.org.

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
