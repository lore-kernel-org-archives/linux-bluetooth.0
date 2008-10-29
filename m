Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
References: <003001c939b5$d685da50$83918ef0$@de>
	<3DECBAF9-9FFA-4267-AA41-9D2DB1EDA0C3@holtmann.org>
In-Reply-To: <3DECBAF9-9FFA-4267-AA41-9D2DB1EDA0C3@holtmann.org>
Date: Wed, 29 Oct 2008 20:39:36 +0100
Message-ID: <006e01c939fe$19bf65a0$4d3e30e0$@hoene@gmx.net>
MIME-Version: 1.0
Cc: ekiga-devel-list@gnome.org
Subject: Re: [Bluez-devel] Common file "sbc.c" in Ekiga/Opal and Bluez
Reply-To: hoene@uni-tuebingen.de,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

> can we first talk about you statically linking MPL and LGPL code
> together. This doesn't look like a good idea to me.

Actually, it is the SBC codec plugin for Opal that is loaded dynamically.
Does this make things better or worse?

Regards, 
 Christian




> 
> Regards
> 
> Marcel
> 
> 
> -----------------------------------------------------------------------
> --
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the
> world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
