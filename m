Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Patch for L2CAP (kernel<->userspace)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <loom.20050413T154320-783@post.gmane.org>
References: <loom.20050413T154320-783@post.gmane.org>
Content-Type: text/plain
Message-Id: <1113401980.9061.34.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Apr 2005 16:19:40 +0200

Hi Matthias,

> The solution is, that "a patch for that problem is needed so that for commands  
> from the RAW socket no responses are send."  ("However I looked at the code  
> and it seems that the the kernel respond to packets with all idents. It should  
> not do that, because they are shared between the kernel and the userspace.")  
>   
> Since iam a noob programmer i want to ask, if the problem is already fixed in  
> a newer patch or is the problem still existent.  

I thought about fixing this, but at the moment it isn't done. Feel free
to send in a patch for it, because I am busy with other stuff and the
whole SCM/Bitkeeper/GIT thing is not really helping right now.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
