Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Version 3 libs/utils (was: Re: [Bluez-devel] patch for d-bus
	support in hcid)
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030624102040.0de55858@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030624102040.0de55858@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1056543354.10001.136.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 25 Jun 2003 14:15:47 +0200

Hi Max,
Hi Stephen,

> I think branch is CVS branch is probably a bad idea. Because we want
> to change a lot of things like command names, etc. Which means lots 
> of file renames, CVS does not handle that.
> 
> How about creating completely new modules
>         libs2 
>         utils2
> and start with the clean history.
> We'll keep old ones around for a while but will only make minor fixes
> to them.

we have already discussed this and starting with new modules seemed to
be the cleanest way. But we shouldn't name them libs2 and utils2,
because we are already at version 2.x with the others. We should use
libs3 and utils3 or maybe an unrelated to the version number suffix like
"-ng".

If we agree on the new name, I will start to create the framework for
the new modules.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
