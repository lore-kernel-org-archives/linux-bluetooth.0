Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: Paired devices in discovery mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yC=J8mNDH54HqNu1odCcJX7C1TRPfTxqWZi4ear84ubc9A@mail.gmail.com>
Date: Fri, 17 May 2013 07:07:24 +0200
Cc: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <32EFB8C4-6875-4B7B-8968-6088AD1A5FF5@holtmann.org>
References: <CAGd9gwjbOFpaYrZt=4Pn4VLUNX-uq-Ap=pPaWt9snV_Gmiwmtg@mail.gmail.com> <20130430072335.GA31159@x220.ger.corp.intel.com> <CAGd9gwg5ucupbzz5DoQNO0XNB5t_QgTB+Z-R0ZrvRGtV9hRz6Q@mail.gmail.com> <20130514082618.GA11514@x220.ger.corp.intel.com> <CAHZ1yC=J8mNDH54HqNu1odCcJX7C1TRPfTxqWZi4ear84ubc9A@mail.gmail.com>
To: Scott James Remnant <keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>>> Mac OS have done a good job here, displaying already paired devices in
>>> the Bluetooth Setup Assistant when they are in discovery mode. If you
>>> attempt to pair to one of those devices it will ask you about
>>> un-pairing and re-pairing with that device, and loosing the previous
>>> linkkey there (see screenshot here http://goo.gl/fGJ2U ). Only the
>>> paired devices that are in discovery are shown there in the list.
>> 
>> I'm not completely convinced that this is the most user friendly
>> approach (requiring the user to go through a pairing wizard instead of
>> just selecting to connect to the device and having that trigger
>> pairing).
>> 
> 
> Part of the problem we're seeing is that users instinctively go
> through the pairing wizard each time, and expect to find the device
> there.
> 
> I think this is a side-effect of the documentation that comes with
> devices, they tell the user to hold down the connect button when
> turning it on, and then go to the pairing wizard each time.
> 
> Because the device is paired, we don't show it in the pairing wizard,
> and BlueZ doesn't give us a hint that it's responding to Inquiry Scans
> so _should_ appear in the pairing wizard again.

that is why I like the iOS approach here. You just get one list about YOUR devices and then it just starts scanning to see if there are other around it might want you to see additionally.

Adding a LastSeen property is mostly useless since device will not go that often visible anyway. So a lot of information for nothing. Maybe a boolean for Discovered could help us to differentiate here. I am though not 100% convinced.

Regards

Marcel

