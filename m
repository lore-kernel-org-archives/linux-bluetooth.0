Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <486A6392.6080008@access-company.com>
References: <48075B6A.2060308@access-company.com>
	<1209058941.12684.37.camel@violet.holtmann.net>
	<48355289.7070906@access-company.com>
	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
	<48357D9C.9080009@access-company.com>
	<486A6392.6080008@access-company.com>
Date: Fri, 08 Aug 2008 00:34:23 +0200
Message-Id: <1218148463.7819.44.camel@californication>
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

> I'm working at making this easier to integrate but it will makes a bunch 
> of patches.
> Let's start with the small and self contained.
> 
> Resend patch for bluez-utils, and network service timeout  (after 
> SETUP_CONN_REQ is sent and no answer for  30 sec, disconnect)

I applied the bluez-utils patches to our 4.x repository.

> Other patch adds a parameter to bnep module for disabling header 
> compression.

I am going through that one know.

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
