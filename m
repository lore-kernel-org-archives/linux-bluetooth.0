Return-Path: <cyrus@holtmann.org>
Message-Id: <5DB8F782-A06D-4818-9064-BFDFE371036E@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <490A4B92.1050505@postincrement.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Fri, 31 Oct 2008 08:09:17 +0100
References: <003001c939b5$d685da50$83918ef0$@de>	<3DECBAF9-9FFA-4267-AA41-9D2DB1EDA0C3@holtmann.org>	<006e01c939fe$19bf65a0$4d3e30e0$@hoene@gmx.net>
	<FF3DF936-BA45-4C47-9943-B0FD94903747@holtmann.org>
	<490A4B92.1050505@postincrement.com>
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

Hi Craig,

>>>> can we first talk about you statically linking MPL and LGPL code
>>>> together. This doesn't look like a good idea to me.
>>> Actually, it is the SBC codec plugin for Opal that is loaded
>>> dynamically.
>>> Does this make things better or worse?
>>
>> that should be fine, but you need to put LGPL on the parts you wrote
>> to include the SBC routines and make them work.
>
> Is there a library that contains the SBC functions that we can link
> against ?

not at the moment. We might do this at some point, but first we have  
to make sure we are not touching the API anymore.

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
