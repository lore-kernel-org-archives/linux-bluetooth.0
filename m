Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Version 3 libs/utils (was: Re: [Bluez-devel] patch for d-bus
	support in hcid)
From: Stephen Crane <steve.crane@rococosoft.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Philip Blundell <pb@nexus.co.uk>, bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030620171218.0db953a8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1056463255.2009.151.camel@baroque.rococosoft.com>
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
Date: 24 Jun 2003 15:00:55 +0100

On Sat, 2003-06-21 at 01:13, Max Krasnyansky wrote:
> We should really start working on 3.x libs and utils. There are so 
> many things and ideas that we want to put in.

I've backed out the unwanted changes to SDP in CVS. 

How do you want to start version 3?  We'll need to keep the old utils
and libs around for a while. However I'd like to merge SDP in early:
there's a lot of duplicated effort (lists, etc.) which can be stripped
out.

I have the first-cut at this merge in my local tree. However I don't
want to check it in on top of the old utils and libs --- unless you
think that's OK.

So maybe the best way to proceed is to start a new branch in CVS?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
