Return-Path: <cyrus@holtmann.org>
Message-ID: <1328022578.1955.215.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: fix RFCOMM session reference counting issue
From: Marcel Holtmann <marcel@holtmann.org>
To: "Purdila, Octavian" <octavian.purdila@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 31 Jan 2012 07:09:38 -0800
In-Reply-To: <CAE1zotLDkVKnmDsOKbf6P9bxxLRsOcpvEtz6cm=_+avOYNZVbw@mail.gmail.com>
References: <1327504207-18275-1-git-send-email-octavian.purdila@intel.com>
	 <1327961101.1955.186.camel@aeonflux>
	 <CAE1zotLmJ8DNX5x5=XwYbR3mEJL_G8GtY56YzeGf6dY=bc+gsQ@mail.gmail.com>
	 <CAE1zotLDkVKnmDsOKbf6P9bxxLRsOcpvEtz6cm=_+avOYNZVbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Octavian,

> > I can follow your argumentation and seems reasonable to me.
> >
> > Have we run this against the BITE tester just to double check that not
> > by some stupid coincident it breaks qualification?
> >
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> >
>
> Thanks for the review.  I have ask around but we don't have a BITE
> tester available at our site. Is there any software tool we can use
> instead?

unfortunately there is nothing else when it comes to GAP, SDP and
RFCOMM.

Regards

Marcel


