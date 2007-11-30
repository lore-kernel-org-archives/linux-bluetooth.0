Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474FD172.3090109@free.fr>
Date: Fri, 30 Nov 2007 10:01:38 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4749E9DB.3020801@free.fr>
	<1196056051.4217.51.camel@aeonflux>	<474AF05D.70404@free.fr>
	<1196196897.17196.56.camel@aeonflux>
In-Reply-To: <1196196897.17196.56.camel@aeonflux>
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [Bluez-devel] [PATCH] Bluez exceptions refactoring updated patch
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


Hi Marcel,

> 
> and the origin is from the other error.[ch] files. So the copyright
> still prevails. Copying content from one file to another one doesn't
> change the copyright.

If this is the case i should have a couple of copyrights in the 
pcm_bluetooth and ctl_bluetooth files, as if i remember well they both 
started as a copy& past from plugz project ;-)
I will surely send a patch to fix that one of those days.

>  
>>> It is great that you added comments for each function, but they belong
>>> inside the *.c files. The rule is that they should be placed where the
>>> actual function body is defined.
>> Marcel, i don't know where from you got this idea, but i find it pretty 
>> dumb. The whole point in having the documentation in the header file is 
>> that as a user of a function you're not interested in how it works (the 
>> c file), but what it does, which is what the documentation is for.
>>
>> I don't know of *any* project that has it's function level documentation 
>> in the C files.
>> But there are numerous counter-examples:
>>    - The Linux Kernel (have a look at the USB stack file 
>> include/linux/usb.h for instance).
> 
> And check drivers/usb/core/urb.c for another example. The documentation
> comment are not for reading the *.h. They are for creating automated API
> documentation. The that structs are document in the header file is
> right, because they are defined there. The actual function are defined
> in the *.c files and thus the comment belongs there.
> 

If you wish to follow kernel documenting style, then so be it. We're 
clearly sitting in the minority side however ;-)

Cheers,

Fabien

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
