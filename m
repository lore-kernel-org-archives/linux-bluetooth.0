Return-Path: <cyrus@holtmann.org>
Subject: Re: Persisting power state when set via rfkill directly
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ross Burton <ross@linux.intel.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1257268607.3420.119.camel@localhost.localdomain>
References: <1257263702.8893.101.camel@flashheart.burtonini.com>
	 <1257267138.3420.114.camel@localhost.localdomain>
	 <1257267896.23167.129.camel@localhost.localdomain>
	 <1257268607.3420.119.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 05 Nov 2009 12:37:37 +0000
Message-ID: <1257424657.23167.164.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-11-04 at 02:16 +0900, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > I see that bluez has support for saving the current power state to disk
> > > > (in /var/lib/bluetooth/[id]/config) when the Powered adaptor property is
> > > > toggled, so that the same state can be restored when restarted.
> > > > However, this only works if the powered state is toggled via the Bluez
> > > > DBus API, applications which directly touch rfkill (such as
> > > > gnome-bluetooth) don't cause the current mode to be persisted.
> > > > 
> > > > From a quick look at the code I'd say that rfkill_event() shouldn't
> > > > return early if the adaptor was powered down and instead get the adaptor
> > > > pointer and write the new mode state.  Does this sound reasonable?
> > > 
> > > I explained a couple of times that gnome-bluetooth should not use RFKILL
> > > as a way to toggle Powered state. Use the D-Bus interface to do so and
> > > not go behind its back. RFKILL states are not persistent and we will not
> > > take RFKILL as an input for this.
> > 
> > Funny that. I was telling Ross I already knew what your answer would be.
> > 
> > Except that means handling both rfkill switches from the kernel, ignore
> > the soft killswitches that'll only change the powered state of adapters,
> > and then poke bluetoothd directly about those.
> > 
> > That means gnome-bluetooth handling 2 types of killswitches. Which is
> > the type of problems that having a decent kernel rfkill subsystem is
> > trying to avoid.
> > 
> > I'll also note that setting the Powered state on the adapter on the
> > bluetoothd side won't be updating the rfkill state to soft killed.
> > 
> > So there's a few holes in your theory there.
> 
> you are trying to use RFKILL for something that it is not. What you want
> is to power your Bluetooth adapter on or off. And we do hciconfig down
> for that adapter when Powered=false. This is as effective as using
> RFKILL and hope you hit the special platform one that takes it off the
> bus. We have a kernel with proper USB power saving for btusb now and it
> does the right thing when hciconfig down. The USB device will be powered
> down since all URBs are killed and the port will be switched off after
> some idle time. What else do you want.

For the little light to go off, for us to be able to tell the user that
there's no Bluetooth adapters because the hardware killswitch is on.

Even if we had a UI to handle killswitches (say, press button, dialogue
pops up and asks you which devices you want to disable), we'd need
special handling just for Bluetooth devices because of the original
problem Ross mentioned.

> The RFKILL support is for a third entity that has to kill a radio
> technology for some reasons. Like policy, flight mode or because it is
> just a hardware button. And RFKILL itself is not persistent. You need
> something that makes it persistent and this will not be bluetoothd nor
> should it be the UI.

I know, and I still think it should be bluetoothd. What else knows that
the device was rfkill'ed as opposed to just being plugged in?
