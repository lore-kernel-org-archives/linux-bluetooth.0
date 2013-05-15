Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130514082618.GA11514@x220.ger.corp.intel.com>
References: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com>
	<20130430072335.GA31159@x220.ger.corp.intel.com>
	<CAGd9gwg5ucupbzz5DoQNO0XNB5t_QgTB+Z-R0ZrvRGtV9hRz6Q@mail.gmail.com>
	<20130514082618.GA11514@x220.ger.corp.intel.com>
Date: Wed, 15 May 2013 09:20:23 -0700
Message-ID: <CAHZ1yC=J8mNDH54HqNu1odCcJX7C1TRPfTxqWZi4ear84ubc9A@mail.gmail.com>
Subject: Re: Paired devices in discovery mode
From: Scott James Remnant <keybuk@chromium.org>
To: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 14, 2013 at 1:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:

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
>

Part of the problem we're seeing is that users instinctively go
through the pairing wizard each time, and expect to find the device
there.

I think this is a side-effect of the documentation that comes with
devices, they tell the user to hold down the connect button when
turning it on, and then go to the pairing wizard each time.

Because the device is paired, we don't show it in the pairing wizard,
and BlueZ doesn't give us a hint that it's responding to Inquiry Scans
so _should_ appear in the pairing wizard again.

Scott
