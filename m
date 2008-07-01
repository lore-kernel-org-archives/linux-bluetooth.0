Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214840891.6764.27.camel@bongo>
References: <1214593557.6131.26.camel@bongo>
	<1214605438.11537.0.camel@violet.holtmann.net>
	<1214840891.6764.27.camel@bongo>
Date: Tue, 01 Jul 2008 03:24:00 +0200
Message-Id: <1214875440.11537.83.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
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

Hi Michael,

> > looks nice. However you have to break this up into pieces for. Sent
> > small patches and I can quickly review and commit them.
> 
> And here's the actual wizard UI patch.  It's a bit large, but not
> terribly break-down-able.

first of all the bluetooth_client_get_name part should be a separate
patch.

Then the modification to the applet code to show the extra entry can be
a separate patch, too.

Same goes for the part where you actually enable the installation of the
bluetooth-wizard program.

Leave these all out, because I don't bother and we will apply them once
the UI change is committed.

> It adds the passkey code for the UI and modifies the UI a bit, as I
> mentioned in previous emails.

Lets do the UI changes without the passkey stuff. We should get the
wizard working. If no device specific passkey is provided, it will fall
back to the applet anyway and that is fine for the first step.

I also don't like that you copy the agent.[ch] files. This needs some
extra thinking and hence first the UI and then the agent part.

> Bastien suggested that the applet label to launch the wizard should
> continue to be "Setup" and not "Connect" because we may want to do more
> setup for certain device types in the future.  That may be true, but
> some of that would be automatic (like the SyncML example he cited) and
> so wouldn't be visible from the user's perspective.

I am for "Setup. Using "Connect" is wrong here. If you wanna connect to
a previously setup device, then we have to add shortcuts to the applet
menu to do so.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
