Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Apr 2012 17:08:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/3] Current status of playstation-peripheral
 plugin
Message-ID: <20120420140825.GA19909@x220.P-661HNU-F1>
References: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
 <1334748297.8818.121.camel@novo.hadess.net>
 <20120420143625.7e8c2a9d8e73b18211bc1ca4@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120420143625.7e8c2a9d8e73b18211bc1ca4@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Fri, Apr 20, 2012, Antonio Ospite wrote:
> I'll add this information as a comment in the code.
> 
> > > Bastien, please check if I am forgetting anything :)
> > > 
> > > WHAT we need the plugin to do:
> > > 
> > >   - When a device is connected via USB:
> > >     + Fetch the (default) adapter bdaddr (from BlueZ) and store it into
> > >       the device
> > >     + Fetch the device bdaddr (from the device via USB/HID) and make the
> > >       device _trusted_ by the adapter (is "trusted" the correct term
> > >       here?
> > 
> > Setting it as trusted isn't the only thing you're doing. You're making
> > it known (meaning that you fill in details such as its SDP record,
> > including name), then adding it as trusted so that BlueZ doesn't ask the
> > user whether this device is allowed to connect.
> > 
> > You need a separate function to make it "known" and insert it into
> > BlueZ's database. _set_trusted() should be a function that takes a
> > single device and a value (whether to trust or untrust), that's it.
> > 
> > So you need to split it in 2 separate functions.
> 
> OK, so the operations we are doing are:
> 	- Make the device "known" (add its details to the database of
>           devices known by a given adapter)
> 	- Make the device trusted (enable its connection)
> 
> Has the first operation a more official name? How does it relate to
> the "association" operation? Is it a device operation, in the sense
> that we are adding a device, or rather an adapter operation, in the
> sense that we are filling the database of a given adapter?

I'd make it an adapter operation and I'd also suggest to explore the
option of using the same API that devices get added to storage during
"normal" device discovery: btd_event_device_found(). After all you are
discovering a device in this use case. The only speciality is that it
happens over USB instead of traditional Bluetooth inquiry. That way you
would only need to add the set_trusted function and nothing else.

Johan
