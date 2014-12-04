Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Dec 2014 16:26:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
Message-ID: <20141204142617.GA645@t440s.P-661HNU-F1>
References: <1417684441-103825-1-git-send-email-marcel@holtmann.org>
 <1611731.nCHCGk9HKZ@uw000953>
 <20141204120804.GA14367@t440s.lan>
 <4332080.UklC07rX7K@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4332080.UklC07rX7K@uw000953>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 04, 2014, Szymon Janc wrote:
> On Thursday 04 of December 2014 14:08:04 Johan Hedberg wrote:
> > Hi Szymon,
> > 
> > On Thu, Dec 04, 2014, Szymon Janc wrote:
> > > On Thursday 04 of December 2014 11:38:35 Marcel Holtmann wrote:
> > > > Hi Szymon,
> > > > 
> > > > >>>>> The Bluetooth core specification defines the value 127 as invalid for
> > > > >>>>> RSSI values. So instead of hard coding it, lets add a constant for it.
> > > > >>>>> 
> > > > >>>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > > >>>>> ---
> > > > >>>>> include/net/bluetooth/hci.h | 1 +
> > > > >>>>> 1 file changed, 1 insertion(+)
> > > > >>>>> 
> > > > >>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > > >>>>> index 569c077778b6..b6f7be1eb919 100644
> > > > >>>>> --- a/include/net/bluetooth/hci.h
> > > > >>>>> +++ b/include/net/bluetooth/hci.h
> > > > >>>>> @@ -412,6 +412,7 @@ enum {
> > > > >>>>> 
> > > > >>>>> /* The core spec defines 127 as the "not available" value */
> > > > >>>>> #define HCI_TX_POWER_INVALID	127
> > > > >>>>> +#define HCI_RSSI_INVALID	127
> > > > >>>> 
> > > > >>>> Isn't that value depending on command, event, link and controller type?
> > > > >>> 
> > > > >>> we use it for the mgmt side of things and there it is whatever we want it to be.
> > > > >> 
> > > > >> At least for inquiry result (no RSSI) 0 is passed to mgmt_device_found() and that seems
> > > > >> to be used by userspace as RSSI unavailable.
> > > > > 
> > > > > Which is strange btw, since both for LE and BR/EDR this is legal RSSI value...
> > > > 
> > > > I checked for LE. There is clearly says 127 means RSSI not available.
> > > 
> > > I meant that 0 RSSI is legal for both LE and BR/EDR but it is used in mgmt device
> > > found event as 'RSSI not available'.
> > 
> > On adapters that generate such events you will never see any other type
> > of discovery results (because the HW isn't capable of it), so what the
> > value is doesn't really matter if all the events have the same one. For
> > consistency however we could change this from 0 to 127.
> 
> Wouldn't that affect on how daemon invalidate RSSI after discovery is finished?
> ie RSSI would change from 127 back to 0? At least on daemon side 0 RSSI was
> treated as special case.

That's a good point - I'd forgotten about that. It's fixable for future
user space versions but changing the kernel behavior would break old
user space versions.

Johan
