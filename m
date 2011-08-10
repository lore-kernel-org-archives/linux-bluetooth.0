Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to
 mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 08:17:44 -0700
In-Reply-To: <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
	 <1312984225.3373.118.camel@aeonflux>
	 <CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312989466.3373.126.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >> This patch adds a new parameter to mgmt_device_found() to inform
> >> the length of 'eir' pointer.
> >>
> >> EIR data from LE advertising report event doesn't have a fixed length
> >> as EIR data from extended inquiry result event does. We needed to
> >> change mgmt_device_found() so it copies 'eir_len' bytes instead of
> >> HCI_MAX_EIR_LENGTH.
> >
> > what is the max EIR length for LE? Is it more than with BR/EDR. Or is it
> > just variable length?
> 
> From page 1735:
> 
> "The data consists of a significant part and a non-significant part.
> [...] The non-significant part extends the Advertising and Scan
> Response data to 31 octets and shall contain all-zero octets."
> 
> So actually it is not variable length, it has 31 octets, with the
> non-significant part zero padded. BR/EDR EIR, on the other hand is 240
> bytes (with zero padding for non-significant part as well)

do we have a deep impact (memory wise) if we always pad this up to 240.
If we do, then we might wanna be smarter here anyway.

Regards

Marcel


