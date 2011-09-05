Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to
 mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 05 Sep 2011 11:03:34 +0200
In-Reply-To: <A943531F-02F0-4809-A45F-03FE4923B6EF@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
	 <1312984225.3373.118.camel@aeonflux>
	 <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com>
	 <1312989466.3373.126.camel@aeonflux>
	 <7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org>
	 <CAJdJm_Mg4e1bLqYFmQxSctWT6y+GMg2xtJLwavtYoM5yWYJPcw@mail.gmail.com>
	 <1313022419.3373.137.camel@aeonflux>
	 <A943531F-02F0-4809-A45F-03FE4923B6EF@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315213416.1979.16.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >>> The advertising report event has the 'Length' field to inform the
> >>> 'Data' field length, so I believe it has a variable length.
> >>> According to its description, the 'Length' field may vary from 0x00
> >>> to 0x1F (31) bytes.
> >>
> >> You are right. Although the section 11 gives the impression the size
> >> is always 31, this is not what happens on actual hardware, which
> >> usually sends only the significant bytes (and the length is know from
> >> the "Length" field.
> >>
> >>> The only drawback I see so far is copying extra ~200 bytes each time
> >>> we get a advertising report data.
> >>
> >> I agree. If this event is being sent on each adv. data report event,
> >> it will be more than 6 times the amount of data (with non-significant
> >> bytes containing only zeroes) sent to userspace.
> >
> > if we wanna save bytes copied and send to userspace, then we might  
> > even
> > fix this for BR/EDR. Since while it is fixed there only a fraction is
> > used there most of the times.
> 
> IMO changing the struct device_found is another issue (this would
> require userspace changes too).

personally I break this one now, instead of later.

> The point in adding the eir_len parameter is to avoid:
>      * preparing (memset and copy EIR from adv report) a 240-bytes
>        temporary buffer to pass to mgmt_device_found()
>      * to memcpy() ~200 useless bytes to ev.eir in mgmt_device_found()
> 
> For each advertising data we gather from the LE scan (which can be
> a lot) we would need to do that.

And the same applies to BR/EDR actually. It is just that we never really
encounter lot of inquiry results (except UPF), but it is the same
problem that we end up copying data around for no good reason.

If we wanna optimize this, then we better do it for both. So we have the
same handling towards userspace.

Regards

Marcel


