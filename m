Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030624102040.0de55858@unixmail.qualcomm.com>
To: Stephen Crane <steve.crane@rococosoft.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Version 3 libs/utils (was: Re: [Bluez-devel] patch for d-bus
	support in hcid)
Cc: Philip Blundell <pb@nexus.co.uk>, bluez-devel@lists.sourceforge.net
In-Reply-To: <1056463255.2009.151.camel@baroque.rococosoft.com>
References: <5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Date: Tue, 24 Jun 2003 10:31:25 -0700

At 07:00 AM 6/24/2003, Stephen Crane wrote:
>How do you want to start version 3?  We'll need to keep the old utils
>and libs around for a while. However I'd like to merge SDP in early:
>there's a lot of duplicated effort (lists, etc.) which can be stripped
>out.
>
>I have the first-cut at this merge in my local tree. However I don't
>want to check it in on top of the old utils and libs --- unless you
>think that's OK.
>
>So maybe the best way to proceed is to start a new branch in CVS?

I think branch is CVS branch is probably a bad idea. Because we want
to change a lot of things like command names, etc. Which means lots 
of file renames, CVS does not handle that.

How about creating completely new modules
        libs2 
        utils2
and start with the clean history.
We'll keep old ones around for a while but will only make minor fixes
to them.

Comments ?

Max



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
