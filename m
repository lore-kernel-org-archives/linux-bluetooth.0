Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1115722824.8949.242.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Dealing with the bluez-utils dependencies
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
Date: Tue, 10 May 2005 13:00:24 +0200

Hi Folks,

the dependency list of bluez-utils is going to be crazy and I think we
need to work on some parts. I can't be possible that if you install
bluez-utils that GTK+ and Python will be installed in some cases.

The base dependency is the C library and bluez-libs or libbluetooth and
this will not change of course ;)

So lets talk about the other packages we need and use. The first one is
the USB library that we need. It is used by hid2hci, bcm203x and dfutool
programs. While bcm203x is only needed for the 2.4 kernel series and
should be always kept as a separate package, I don't consider this a
problem. Most modern distributions won't need this tool. The dfutool is
only needed by developers and people that play with firmware upgrades.
However it might be handy to create a bluez-devel packages that depends
on the Bluetooth library header files and gives you special tools for
the developers. Such a package may also contain the *test applications.
However I think that people who wants to play with firmware upgrades
should maybe better compile dfutool by themself. So at least it is not
that easy to screw a Bluetooth device and then try to blame others. My
only problematic tool left with USB dependency is hid2hci and this is
really needed for all of you using HID Proxy dongles. So do you think a
general dependency on the USB library is fine for a bluez-utils binary
package?

Next big thing is the D-Bus library. We use D-Bus in hcid and it seems
that people are working on D-Bus support for pand. Personal I am not a
big believer in D-Bus anymore, but it gets used and so we can't avoid
it. So should we leave that a compile time option and by default we
enable it. The bluez-utils binary package then simply depends on the
D-Bus library?

With configure we also check for OpenOBEX and ALSA. The OpenOBEX part is
not ready at the moment and still part of its own in the CVS. For ALSA
we now have the first draft of an A2DP plugin. However I think most
packages maintainers will create a bluez-alsa package for it and this
looks like a sane thing to me.

And now the really ugly part. The PIN helper support. This is the real
pain and we should find a nice solution for it. The original Python
script is not an option, because it depends on Python and even the GTK
PIN helper will add the GTK+ libraries. Also the KDE Bluetooth project
has its own PIN helper. I personal like to go with the SuSE idea to
provide a general PIN helper script that checks the installed tools and
then executes the right PIN helper or provides a default PIN (or no PIN)
if nothing has been setup. We can also add more config options, where we
provide a list of PIN helpers that will tried one after the other. Maybe
also a default PIN option would be a good idea. Comments please.

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
