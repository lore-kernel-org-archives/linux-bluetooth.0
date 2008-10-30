Return-Path: <cyrus@holtmann.org>
Message-Id: <FF3DF936-BA45-4C47-9943-B0FD94903747@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <006e01c939fe$19bf65a0$4d3e30e0$@hoene@gmx.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Thu, 30 Oct 2008 19:06:26 +0100
References: <003001c939b5$d685da50$83918ef0$@de>
	<3DECBAF9-9FFA-4267-AA41-9D2DB1EDA0C3@holtmann.org>
	<006e01c939fe$19bf65a0$4d3e30e0$@hoene@gmx.net>
Cc: ekiga-devel-list@gnome.org
Subject: Re: [Bluez-devel] Common file "sbc.c" in Ekiga/Opal and Bluez
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

Hi Christian,

>> can we first talk about you statically linking MPL and LGPL code
>> together. This doesn't look like a good idea to me.
>
> Actually, it is the SBC codec plugin for Opal that is loaded  
> dynamically.
> Does this make things better or worse?

that should be fine, but you need to put LGPL on the parts you wrote  
to include the SBC routines and make them work.

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
