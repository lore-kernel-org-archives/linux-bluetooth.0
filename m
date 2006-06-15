Return-Path: <davidz@redhat.com>
Subject: Re: [RFC] HAL/Bluez integration
From: David Zeuthen <davidz@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: bluez-devel@lists.sourceforge.net, hal@lists.freedesktop.org,
        networkmanager-list@gnome.org, Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20060611204551.GA19920@srcf.ucam.org>
References: <20060611204551.GA19920@srcf.ucam.org>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 15:56:53 -0400
Message-Id: <1150401413.15545.64.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 2006-06-11 at 21:45 +0100, Matthew Garrett wrote:
> I've put a tarball up at 
> http://www.codon.org.uk/~mjg59/tmp/hal-bluetooth.tar.gz as a first 
> attempt at some degree of integration. 

Cool.

> The current interface is 
> basically:
> 
> 1) Bluetooth HCIs support a "Scan" method. Calling this will populate 
> the tree with any located bluetooth devices.
> 2) Bluetooth devices support "Pair" and "Browse" methods. Calling the 
> first will attempt to initiate a pairing interaction - the second will 
> populate the tree with any services found on the device via SDP.

Shouldn't Pair() take the pin?

> So it's fairly simple at the moment. The obvious next step is to allow 
> services to provide rfcomm-binding methods and the like, and to ensure 
> that relevant pieces of service information are provided via sdp.
> 
> Now, there's a couple of issues:
> 
> 1) I'm not sure about the pairing interface. Right now, calling the pair 
> method prompts hcid to attempt to send a message to a registered pairing 
> agent via bluetooth. This strikes me as a mild security problem, since 
> there's no mechanism for ensuring that it's the current user who has 
> registered a pairing agent. 

Right.

> The best that can be done is to attempt to 
> register an agent, notice that the registration has failed and then bail 
> before attempting to make the connection (setting an appropriate error). 
> This isn't entirely ideal. David, can you see any way that PolicyKit can 
> help us here?

Not really, sorry. 

It sounds like we want Pair() to take the pin and pass it on to hcid and
propagate errors back as appropriate. Intermittently we might want to
register a pairing agent with our hal stuff to pretend this just works.
But CreateBonding() on org.bluez.Adapter really ought to (optionally)
take the pincode too. Can Bluez be tweaked to support this?

Also, can we determine what devices are paired already? E.g. can we have
useful properties on the hal device objects such as
bluetooth_device.paired = TRUE|FALSE.

> 2) The SDP interface in bluez is currently labelled "experimental" and 
> is fairly limited in functionality. I tried going back through the 
> mailing list archives, but the sourceforge interface makes me cry - has 
> there been discussion of what this interface should look like and the 
> technical problems involved?

Some questions:

 1. What other API do we need? I suspect that we want

  1a. Some way of setting the device ID of an adapter (equiv to device {
      name "foo"} in hcid.conf)

  1b. Some way of setting the pin of the adapter

    I guess both 1a and 1b falls under replacing hcid.conf (<insert rant
    about why text-based configuration files are bad>)

  1c. A way to pair well-known devices that are not yet in your
      vicinity?

    This is just thinking out loud, I suspect you have a much better
    idea about this than I do. I guess it naturally falls out once one
    starts thinking about the UI.

 2. We probably need a way to make hal device objects disappear when the
    parent disappears. Would setting info.reap_when_parent_dies=TRUE be
    sufficient? If so, I can quickly implement this.

 3. Probably need to delete devices not being reported when doing a
    Scan()

> Obligatory screenshot - http://www.codon.org.uk/~mjg59/tmp/bluetooth.png

Cool.

    David
