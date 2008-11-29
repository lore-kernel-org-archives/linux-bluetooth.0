Return-Path: <cyrus@holtmann.org>
Message-ID: <49317C95.7060808@powercraft.nl>
Date: Sat, 29 Nov 2008 18:32:05 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] More PIN quirks
References: <1227976757.26649.2692.camel@cookie.hadess.net>
In-Reply-To: <1227976757.26649.2692.camel@cookie.hadess.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> This builds on top of the move to a PIN database.
> 
> This fixes all but one bug filed against the wizard in the GNOME
> bugzilla.
> 
> I hope it shows that the PIN database is workable.
> 
> Cheers
> 

Thank you Bastien for your hard work!

I have a few questions about these kind of patches, would it not be
easer to maintainable and more usefull to add this kind of information
separate from gnome related packages, and move them to a desktop
independent configuration?

Of course there is nothing wrong with using gnome bugreports or using
gnome applications with the data. However I have seen a lot of patches
that apply to the gnome wizard application and the commandline tools or
kde tools do not use this information, but it would really like the same
functionality in the command line tools so it does work platform
independent.

I know there is not much priority on fixing a commandline tool but, it
can be smart to move device specific info into a general system that all
user frontend systems can use. This will make it a lot easer of other
developers to create new frontends that do not need to reverse engineer
the gnome apps and create duplicated hard to maintain code....

Does this make any sense? Or is there just no time or do we not care
about other users then gnome?

Best regards,

Jelle
