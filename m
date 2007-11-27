Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <474AF05D.70404@free.fr>
References: <4749E9DB.3020801@free.fr> <1196056051.4217.51.camel@aeonflux>
	<474AF05D.70404@free.fr>
Date: Tue, 27 Nov 2007 21:54:57 +0100
Message-Id: <1196196897.17196.56.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>
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

Hi Fabien,

> > Two comments on your patch itself. The copyright on common/error.[ch] is
> > not only yours. Keep the original copyright of the files.
> 
> Well, that file didn't exit beforehand, so as far as nobody else but me 
> has touched it, what's the point in putting everybody's copyright in it?
> (OK, this is not true anymore as Johan made some changes you requested 
> to it :-) )

and the origin is from the other error.[ch] files. So the copyright
still prevails. Copying content from one file to another one doesn't
change the copyright.
 
> > It is great that you added comments for each function, but they belong
> > inside the *.c files. The rule is that they should be placed where the
> > actual function body is defined.
> 
> Marcel, i don't know where from you got this idea, but i find it pretty 
> dumb. The whole point in having the documentation in the header file is 
> that as a user of a function you're not interested in how it works (the 
> c file), but what it does, which is what the documentation is for.
> 
> I don't know of *any* project that has it's function level documentation 
> in the C files.
> But there are numerous counter-examples:
>    - The Linux Kernel (have a look at the USB stack file 
> include/linux/usb.h for instance).

And check drivers/usb/core/urb.c for another example. The documentation
comment are not for reading the *.h. They are for creating automated API
documentation. The that structs are document in the header file is
right, because they are defined there. The actual function are defined
in the *.c files and thus the comment belongs there.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
