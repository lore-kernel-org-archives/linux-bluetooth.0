Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 May 2013 11:26:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: Paired devices in discovery mode
Message-ID: <20130514082618.GA11514@x220.ger.corp.intel.com>
References: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com>
 <20130430072335.GA31159@x220.ger.corp.intel.com>
 <CAGd9gwg5ucupbzz5DoQNO0XNB5t_QgTB+Z-R0ZrvRGtV9hRz6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwg5ucupbzz5DoQNO0XNB5t_QgTB+Z-R0ZrvRGtV9hRz6Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, May 10, 2013, Alex Deymo wrote:
> On Tue, Apr 30, 2013 at 12:23 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > This has been discussed many times in the past but nothing concrete has
> > been done about it so far. The core spec essentially gives us two
> > options: either to reject the link or to ask the user if it's ok to
> > repair (and loose the old key) and then proceed with repairing. We've so
> > far only implemented the first option.
> 
> I think that in that the first option is ok if the connection is
> initiated by the device, since it could be a malicious device with a
> fake key trying to spam us. But if we reject and ignore the key
> provided by the device (or the devices doesn't know it), we still need
> to give the user a way to re-pair the device.

Agreed.

> I don't like the idea of extending the Device1.Connect() method with
> pairing related stuff,

We wouldn't really be extending it. Connect() has always had the
capability of triggering General Bonding, and that's what it'll e.g. do
if you call it without calling Pair() first.

> since some devices (mostly mice) are not normally-connectable and we
> should not expect the Connect() to work for those devices.

If the other device requires some action to make it connectable/pairable
then there's no difference between Connect() or Pair() - you still need
to take that action on the remote device. The only difference is that
Connect() will trigger General Bonding whereas Pair() will trigger
Dedicated Bonding.

> Also, if the device supports encryption but don't require it (like
> keyboards), the way I have to tell BlueZ that I want an encrypted
> connection is to Pair the device first, and make sure the
> device is Paired before Connect.

True, though it should be noted here that this is only applicable for
older pre-2.1 devices doing legacy pairing.

> Mac OS have done a good job here, displaying already paired devices in
> the Bluetooth Setup Assistant when they are in discovery mode. If you
> attempt to pair to one of those devices it will ask you about
> un-pairing and re-pairing with that device, and loosing the previous
> linkkey there (see screenshot here http://goo.gl/fGJ2U ). Only the
> paired devices that are in discovery are shown there in the list.

I'm not completely convinced that this is the most user friendly
approach (requiring the user to go through a pairing wizard instead of
just selecting to connect to the device and having that trigger
pairing).

> The problem is that I can't implement such a nice interface with the
> current BlueZ API, since I don't known when a paired device is
> replying to the inquiry request or not. BlueZ knows that, but I don't
> know that from the dbus API. That's why I want to introduce the
> "Discovering" property.

If we're really going to introduce something like this I'd rather have a
"LastSeen" property with the time that the device was last seen. This
could potentially be useful for sorting the devices in the UI (something
that a simple "Discovering" boolean doesn't allow).

> It will be also handy if Device1.Pair() allows me to re-pair the
> device and only replaces the linkkey if the pairing works. Right now,
> if the user wants to re-pair a device it has to remove it, wait
> several seconds until it appears in a discovery session and then call
> Pair in that new device. This possible, but not as user-friendly as it
> could be, and the change I'm proposing is backward compatible with the
> existing users since the only changed behavior is when trying to Pair
> an already Paired device.

I agree that we should consider allowing multiple calls to Pair(). If we
have an existing link key the procedure would just drop the old one as
soon as repairing has succeeded.

Johan
