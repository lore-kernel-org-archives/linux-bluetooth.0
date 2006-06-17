Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Zeuthen <davidz@redhat.com>
In-Reply-To: <1150401413.15545.64.camel@daxter.boston.redhat.com>
References: <20060611204551.GA19920@srcf.ucam.org>
	<1150401413.15545.64.camel@daxter.boston.redhat.com>
Date: Sat, 17 Jun 2006 13:02:53 +0200
Message-Id: <1150542173.17539.62.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, bluez-devel@lists.sourceforge.net,
        hal@lists.freedesktop.org, networkmanager-list@gnome.org
Subject: Re: [Bluez-devel] [RFC] HAL/Bluez integration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> > 2) Bluetooth devices support "Pair" and "Browse" methods. Calling the 
> > first will attempt to initiate a pairing interaction - the second will 
> > populate the tree with any services found on the device via SDP.
> 
> Shouldn't Pair() take the pin?

be careful with this. The new Simple Pairing will come at some point and
then alternate authentication methods like NFC and other OOB stuff might
have to be considered.

The application should take by itself to register a passkey agent if the
default one is not the preferred one. For example in case of a wizard.

> > 1) I'm not sure about the pairing interface. Right now, calling the pair 
> > method prompts hcid to attempt to send a message to a registered pairing 
> > agent via bluetooth. This strikes me as a mild security problem, since 
> > there's no mechanism for ensuring that it's the current user who has 
> > registered a pairing agent. 
> 
> Right.

We left out the multiple user interaction consideration out of it for
now. The reason was to establish a usable API first. All user specific
checks (and settings) should be done by hcid and they should be fully
transparent for the actual user. For the next releases we need to
integrate this kind of checking.

> It sounds like we want Pair() to take the pin and pass it on to hcid and
> propagate errors back as appropriate. Intermittently we might want to
> register a pairing agent with our hal stuff to pretend this just works.
> But CreateBonding() on org.bluez.Adapter really ought to (optionally)
> take the pincode too. Can Bluez be tweaked to support this?

Because of upcoming Simple Pairing this is not an option. See comment
above.

> Some questions:
> 
>  1. What other API do we need? I suspect that we want
> 
>   1a. Some way of setting the device ID of an adapter (equiv to device {
>       name "foo"} in hcid.conf)
> 
>   1b. Some way of setting the pin of the adapter
> 
>     I guess both 1a and 1b falls under replacing hcid.conf (<insert rant
>     about why text-based configuration files are bad>)

It is possible to have a presistent storage for the device name. The
value in hcid.conf is only the default value. It will be overwritten by
the saved value. Set the name through the BlueZ D-Bus API and your
device will use it next time.

>   1c. A way to pair well-known devices that are not yet in your
>       vicinity?
> 
>     This is just thinking out loud, I suspect you have a much better
>     idea about this than I do. I guess it naturally falls out once one
>     starts thinking about the UI.

Not a good idea. Pair them once needed. Otherwise don't even care.

>  2. We probably need a way to make hal device objects disappear when the
>     parent disappears. Would setting info.reap_when_parent_dies=TRUE be
>     sufficient? If so, I can quickly implement this.

Sounds enough too me.

>  3. Probably need to delete devices not being reported when doing a
>     Scan()

Not a good idea. A device can become invisible, but still in range. You
need to keep track of last seen and last used. And paired or trusted
device should always be available.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
