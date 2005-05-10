Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4280D256.1000804@xmission.com>
References: <1115722824.8949.242.camel@pegasus>
	 <4280D256.1000804@xmission.com>
Content-Type: text/plain
Message-Id: <1115739962.12058.19.camel@pegasus>
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
Date: Tue, 10 May 2005 17:46:02 +0200

Hi Brad,

> > So lets talk about the other packages we need and use. The first one is
> > the USB library that we need. It is used by hid2hci
> ...
> > really needed for all of you using HID Proxy dongles. So do you think a
> > general dependency on the USB library is fine for a bluez-utils binary
> > package?
> 
> yes, this seems unavoidable unless you wanted to move hid2hci into a new 
> package or make it an optional build. it seems best where it is now.

I agree and creating an own package for it sounds like too much
overhead.

So keeping the USB library dependency for a binary package is ok. The
embedded people need to recompile with USB support.

> on a related note, what is happening with utils2 and libs2 in cvs?

They are meant to be the next generation, but then I started to backport
features and we still have the 2.x generation. The API breakage is too
big and I will only work on it again, when we get clarification about
LGPL for the Bluetooth library from Qualcomm.

> > enable it. The bluez-utils binary package then simply depends on the
> > D-Bus library?
> 
> some of the hcid pin stuff would have to be rewritten around no d-bus, 
> right? but that seems like a low priority.

All the PIN stuff is also working without D-Bus support.

> > With configure we also check for OpenOBEX and ALSA. The OpenOBEX part is
> > not ready at the moment and still part of its own in the CVS. For ALSA
> > we now have the first draft of an A2DP plugin. However I think most
> > packages maintainers will create a bluez-alsa package for it and this
> > looks like a sane thing to me.
> 
> right, so it's not a core dependency.

However the ALSA library 1.0.9 must be released first.

> > PIN helper will add the GTK+ libraries. Also the KDE Bluetooth project
> > has its own PIN helper. I personal like to go with the SuSE idea to
> > provide a general PIN helper script that checks the installed tools
> 
> the helper script sounds reasonable. would the gnome folks be willing to 
> maintain the gtk helper like kde does their own? It seems like kde is 
> doing more to make bluez easy to use--gnome devels should take this as a 
> challenge.
> 
> bluez could have a package that contains just the gtk pin tool just for 
> gnome users with the idea that gnome should adopt it.

It is already an own package called bluez-pin and not maintained by me.
The problem is that for example the Debian bluez-utils package depends
on bluez-pin and thus the dependency chain increases.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
