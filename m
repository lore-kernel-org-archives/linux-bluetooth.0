Return-Path: <hadess@hadess.net>
Message-ID: <1504799797.6911.73.camel@hadess.net>
Subject: Re: Bluetooth LE battery reporting?
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Szymon Janc
 <szymon.janc@codecoup.pl>,  Bluez mailing list
 <linux-bluetooth@vger.kernel.org>
Date: Thu, 07 Sep 2017 17:56:37 +0200
In-Reply-To: <CABBYNZLOCkKnPU0HBkDSwJgus7fwXV80yreET1zG+qF7-oy+rg@mail.gmail.com>
References: <1504627402.6911.48.camel@hadess.net>
	 <CAAEJBh+bjNrjSvTD-F1LBTKnO36kvDZmavJaRR8ZWhR6pTwz9g@mail.gmail.com>
	 <9D01587F-3821-46CF-B8CE-2311BE8E8592@holtmann.org>
	 <CABBYNZLDGJTj+jeKUuRAmm_FznUzAy--zE1YVto2t5Fb4zOQ6w@mail.gmail.com>
	 <9713FF9C-7E23-448F-AC8B-755F32C461C7@holtmann.org>
	 <1504708668.6911.56.camel@hadess.net> <1504739780.6911.60.camel@hadess.net>
	 <1504793016.6911.70.camel@hadess.net>
	 <CABBYNZLOCkKnPU0HBkDSwJgus7fwXV80yreET1zG+qF7-oy+rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-09-07 at 17:15 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, Sep 7, 2017 at 5:03 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Thu, 2017-09-07 at 01:16 +0200, Bastien Nocera wrote:
> > > On Wed, 2017-09-06 at 16:37 +0200, Bastien Nocera wrote:
> > > > On Wed, 2017-09-06 at 10:40 +0200, Marcel Holtmann wrote:
> > > > > 
> > > > 
> > > > <snip>
> > > > > I assumed that it is forbidden to include HID battery
> > > > > reporting
> > > > > events via the GATT HID descriptors. I think the standard
> > > > > clearly
> > > > > says these have to come via battery service and not via HID.
> > > > 
> > > > So we're back to implementing battery reporting as a separate
> > > > profile.
> > > > What would be a good example/skeleton to use to implement this?
> > > 
> > > This is what I managed to do so far:
> > > https://github.com/hadess/bluez/commits/ble-battery
> > > 
> > > A first (gentle) pass at a review would be nice, especially if
> > > there's
> > > a better way to get notifications on both the attributes in one
> > > go.
> > 
> > Obviously, the reworked code I wrote at 1 AM didn't work correctly.
> > I've fixed the copy/paste bugs and pushed it.
> > 
> > > The second question is how I would export this.
> > > 
> > > I'm currently thinking that exporting a new interface on the
> > > device
> > > itself might be the best idea, and I'll monitor devices directly
> > > in
> > > UPower to export them to desktops. Would that be a good way?
> > 
> > Still unsure about this, comments welcome.
> > 
> > > And as UPower will be the likely consumer of this data, I think
> > > I'll
> > > try mapping this set of flags:
> > > https://www.bluetooth.com/specifications/gatt/viewer?attributeXml
> > > File
> > > =org.bluetooth.characteristic.battery_power_state.xml
> > > to UPower properties rather than trying to export it as-is.
> > 
> > I've written parsing code for this. Does anyone know of a device
> > which
> > would use the Battery Power State characteristic so I could try it
> > out?
> > 
> > Finally, I've realised that my code replicates a lot of the code in
> > bas.[ch], which is only used by the hog profile plugin. Seeing as
> > this
> > does nothing (the Battery Level is at the same level as the HoG
> > characteristics, not a child of it), I've removed it.
> 
> We should probably make similar changes to what was done in dis.c so
> it can operate with gatt_db directly instead of doing its own
> discovery.

battery.c does use gatt_db already to do the initial discovery:
https://github.com/hadess/bluez/blob/ble-battery/profiles/battery/battery.c#L362

Or did you mean something else? dis.c might not be a great example, as
it doesn't use notifications.
