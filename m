Return-Path: <cyrus@holtmann.org>
Subject: Re: Persisting power state when set via rfkill directly
From: Marcel Holtmann <marcel@holtmann.org>
To: Ross Burton <ross@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1257263702.8893.101.camel@flashheart.burtonini.com>
References: <1257263702.8893.101.camel@flashheart.burtonini.com>
Content-Type: text/plain
Date: Wed, 04 Nov 2009 01:52:18 +0900
Message-Id: <1257267138.3420.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ross,

> I see that bluez has support for saving the current power state to disk
> (in /var/lib/bluetooth/[id]/config) when the Powered adaptor property is
> toggled, so that the same state can be restored when restarted.
> However, this only works if the powered state is toggled via the Bluez
> DBus API, applications which directly touch rfkill (such as
> gnome-bluetooth) don't cause the current mode to be persisted.
> 
> From a quick look at the code I'd say that rfkill_event() shouldn't
> return early if the adaptor was powered down and instead get the adaptor
> pointer and write the new mode state.  Does this sound reasonable?

I explained a couple of times that gnome-bluetooth should not use RFKILL
as a way to toggle Powered state. Use the D-Bus interface to do so and
not go behind its back. RFKILL states are not persistent and we will not
take RFKILL as an input for this.

Regards

Marcel


