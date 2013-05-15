Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: Paired devices in discovery mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130514082618.GA11514@x220.ger.corp.intel.com>
Date: Wed, 15 May 2013 14:22:30 +0200
Cc: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <4AADBC01-6149-4422-AA3B-6BF1B0E3D744@holtmann.org>
References: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com> <20130430072335.GA31159@x220.ger.corp.intel.com> <CAGd9gwg5ucupbzz5DoQNO0XNB5t_QgTB+Z-R0ZrvRGtV9hRz6Q@mail.gmail.com> <20130514082618.GA11514@x220.ger.corp.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Mac OS have done a good job here, displaying already paired devices in
>> the Bluetooth Setup Assistant when they are in discovery mode. If you
>> attempt to pair to one of those devices it will ask you about
>> un-pairing and re-pairing with that device, and loosing the previous
>> linkkey there (see screenshot here http://goo.gl/fGJ2U ). Only the
>> paired devices that are in discovery are shown there in the list.
> 
> I'm not completely convinced that this is the most user friendly
> approach (requiring the user to go through a pairing wizard instead of
> just selecting to connect to the device and having that trigger
> pairing).

yes, back in the days MacOS has done an awesome job to make Bluetooth more user accessible. However these days I would rather look towards iOS if you want to get inspiration.

If I would have to write a desktop UI for Bluetooth right now, I would not go with a pairing wizard at all. I would go with a device menu/list like iOS does.

>> The problem is that I can't implement such a nice interface with the
>> current BlueZ API, since I don't known when a paired device is
>> replying to the inquiry request or not. BlueZ knows that, but I don't
>> know that from the dbus API. That's why I want to introduce the
>> "Discovering" property.
> 
> If we're really going to introduce something like this I'd rather have a
> "LastSeen" property with the time that the device was last seen. This
> could potentially be useful for sorting the devices in the UI (something
> that a simple "Discovering" boolean doesn't allow).

What would a last seen improve here? Maybe I am missing a bit of context. How many devices are we expecting to have paired. In a normal day use you have around 3-4. And even power users don't get easily over 10. I do understand that with LE this potentially can change, but so far I have not seen that. Users just don't have that many devices.

>> It will be also handy if Device1.Pair() allows me to re-pair the
>> device and only replaces the linkkey if the pairing works. Right now,
>> if the user wants to re-pair a device it has to remove it, wait
>> several seconds until it appears in a discovery session and then call
>> Pair in that new device. This possible, but not as user-friendly as it
>> could be, and the change I'm proposing is backward compatible with the
>> existing users since the only changed behavior is when trying to Pair
>> an already Paired device.
> 
> I agree that we should consider allowing multiple calls to Pair(). If we
> have an existing link key the procedure would just drop the old one as
> soon as repairing has succeeded.

I am fine with Device1.Pair() triggering a repairing. We could just ask via the agent the user to confirm that he/she wants to drop the previous link and be done with it. Simple, intuitive and exactly a user interaction we want do see. And more important a question that the user can answer at that point in time since he/she pressed the pairing button. And in addition, the user can abort the pairing attempt if it was an accident. If any UI system wants to outsmart us or the user, it can hook into the agent to do so.

Regards

Marcel

