Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4280D256.1000804@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <1115722824.8949.242.camel@pegasus>
In-Reply-To: <1115722824.8949.242.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
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
Date: Tue, 10 May 2005 09:25:10 -0600

Marcel

> So lets talk about the other packages we need and use. The first one is
> the USB library that we need. It is used by hid2hci
...
> really needed for all of you using HID Proxy dongles. So do you think a
> general dependency on the USB library is fine for a bluez-utils binary
> package?

yes, this seems unavoidable unless you wanted to move hid2hci into a new 
package or make it an optional build. it seems best where it is now.

on a related note, what is happening with utils2 and libs2 in cvs?

> enable it. The bluez-utils binary package then simply depends on the
> D-Bus library?

some of the hcid pin stuff would have to be rewritten around no d-bus, 
right? but that seems like a low priority.

> With configure we also check for OpenOBEX and ALSA. The OpenOBEX part is
> not ready at the moment and still part of its own in the CVS. For ALSA
> we now have the first draft of an A2DP plugin. However I think most
> packages maintainers will create a bluez-alsa package for it and this
> looks like a sane thing to me.

right, so it's not a core dependency.

> PIN helper will add the GTK+ libraries. Also the KDE Bluetooth project
> has its own PIN helper. I personal like to go with the SuSE idea to
> provide a general PIN helper script that checks the installed tools

the helper script sounds reasonable. would the gnome folks be willing to 
maintain the gtk helper like kde does their own? It seems like kde is 
doing more to make bluez easy to use--gnome devels should take this as a 
challenge.

bluez could have a package that contains just the gtk pin tool just for 
gnome users with the idea that gnome should adopt it.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
