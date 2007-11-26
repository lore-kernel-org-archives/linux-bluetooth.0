Return-Path: <fabchevalier@free.fr>
Message-ID: <474AF05D.70404@free.fr>
Date: Mon, 26 Nov 2007 17:12:13 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@nokia.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Bluez exceptions refactoring updated patch
References: <4749E9DB.3020801@free.fr> <1196056051.4217.51.camel@aeonflux>
In-Reply-To: <1196056051.4217.51.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Please some comments below...

> Two comments on your patch itself. The copyright on common/error.[ch] is
> not only yours. Keep the original copyright of the files.

Well, that file didn't exit beforehand, so as far as nobody else but me 
has touched it, what's the point in putting everybody's copyright in it?
(OK, this is not true anymore as Johan made some changes you requested 
to it :-) )

> 
> It is great that you added comments for each function, but they belong
> inside the *.c files. The rule is that they should be placed where the
> actual function body is defined.

Marcel, i don't know where from you got this idea, but i find it pretty 
dumb. The whole point in having the documentation in the header file is 
that as a user of a function you're not interested in how it works (the 
c file), but what it does, which is what the documentation is for.

I don't know of *any* project that has it's function level documentation 
in the C files.
But there are numerous counter-examples:
   - The Linux Kernel (have a look at the USB stack file 
include/linux/usb.h for instance).
   - glib
   - libsig++
   - Qt
   - STL
   - ... ==> Do i need to find more ?

So, is there any good reason we should do differently from everybody 
else ? :-)

Cheers,

Fabien
