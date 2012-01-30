Return-Path: <cyrus@holtmann.org>
Message-ID: <1327961335.1955.188.camel@aeonflux>
Subject: Re: [PATCHv2 0/4] Add support for bonding callbacks and retrying
From: Marcel Holtmann <marcel@holtmann.org>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 30 Jan 2012 14:08:55 -0800
In-Reply-To: <CA+bD78iUaG2Kmjn6k+x=MqUcdQaG=-w4dQTVEmvEA_LW1QRzcQ@mail.gmail.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
	 <1327952480.1955.154.camel@aeonflux>
	 <CA+bD78it1S40KTRA+F9QX0KCVG3jDQsS=VdvEjuRdyxUPN4qhw@mail.gmail.com>
	 <1327960292.1955.177.camel@aeonflux>
	 <CA+bD78iUaG2Kmjn6k+x=MqUcdQaG=-w4dQTVEmvEA_LW1QRzcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> >> > We have to also ensure that we do not disconnect the ACL in between the
> >> > retry attempts. Otherwise some car kits might cancel their pairing
> >> > procedure and you have to have user interaction to get it back into
> >> > pairing mode. So if the ACL gets disconnect, then we should just fail
> >> > and cancel the bonding.
> >> >
> >> In my testing, OS X/iOS drop the ACL between retry attempts - so we
> >> wouldn't be any worse than they are. I'm not sure whether it's even
> >> possible in bluez to avoid dropping the ACL?
> >
> > Is Apple doing retried pairing (or auto-pairing) as well?
> >
> They are; they send 0000 to the device, and then if it fails, it
> retries after about 3s.

if possible get us some hcidump traces so we can see which side is
actually dropping the link. I am curious about the timing.

> Android does the same (from the bluez Agent, ick)
> 
> > Strictly speaking the ACL disconnect is host stack triggered. So you
> > have HCI_Authentication_Requested and you can just execute that again
> > with the same link. We also do have a ACL disconnect timeout handling of
> > 2 seconds that will allow sockets to re-use the same ACL link. Can you
> > provide some hcidump traces from your test cases?
> >
> Sure, probably will be a few days though. I may have a play and see if
> I can get it to avoid dropping the ACL link too.

If everybody else is fine with dropping the ACL link in between, then so
should we. We just might need a blacklist for some stupid carkits.

Regards

Marcel


