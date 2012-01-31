Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE1zotLmJ8DNX5x5=XwYbR3mEJL_G8GtY56YzeGf6dY=bc+gsQ@mail.gmail.com>
References: <1327504207-18275-1-git-send-email-octavian.purdila@intel.com>
	<1327961101.1955.186.camel@aeonflux>
	<CAE1zotLmJ8DNX5x5=XwYbR3mEJL_G8GtY56YzeGf6dY=bc+gsQ@mail.gmail.com>
Date: Tue, 31 Jan 2012 12:21:57 +0200
Message-ID: <CAE1zotLDkVKnmDsOKbf6P9bxxLRsOcpvEtz6cm=_+avOYNZVbw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix RFCOMM session reference counting issue
From: "Purdila, Octavian" <octavian.purdila@intel.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 31, 2012 at 12:05 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> I can follow your argumentation and seems reasonable to me.
>
> Have we run this against the BITE tester just to double check that not
> by some stupid coincident it breaks qualification?
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>

Hi Marcel,

Thanks for the review.  I have ask around but we don't have a BITE
tester available at our site. Is there any software tool we can use
instead?

Thanks!
Tavi
