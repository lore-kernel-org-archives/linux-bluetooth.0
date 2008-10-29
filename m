Return-Path: <cyrus@holtmann.org>
Message-Id: <3DECBAF9-9FFA-4267-AA41-9D2DB1EDA0C3@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003001c939b5$d685da50$83918ef0$@de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Wed, 29 Oct 2008 19:41:16 +0100
References: <003001c939b5$d685da50$83918ef0$@de>
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

> I just want to hint to the fact that the file in "sbc.c" containing  
> the
> Bluetooth audio codec appears twice in the repository of Ekiga/Opal
>> svn co https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/opal/trunk
> opal/plugins/audio/SBC/sbc.c
> and as file "bluez/sbc/sbc.c" in
> git://git.kernel.org/pub/scm/bluetooth/bluez.git.
>
> Maybe, somebody has an idea to keep both versions in sync if one is
> changing? Or is it not necessary?

can we first talk about you statically linking MPL and LGPL code  
together. This doesn't look like a good idea to me.

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
