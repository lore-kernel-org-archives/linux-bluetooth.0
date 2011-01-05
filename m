Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Jan 2011 14:10:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Change security level on demand when reading
 characteristic value
Message-ID: <20110105121005.GB18929@jh-x301>
References: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293744130-21124-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Dec 30, 2010, Claudio Takahasi wrote:
> If a characteristic requires a higher security level, change it on
> demand and re-send the GATT Charateristic Value Read. Request will not
> be sent until the SMP negotiation finishes. This change doesn't affect
> GATT over BR/EDR, since encryption is mandatory for BR/EDR.
> ---
>  attrib/client.c  |   11 +++++++++++
>  attrib/gattrib.c |    8 ++++++++
>  attrib/gattrib.h |    2 ++
>  3 files changed, 21 insertions(+), 0 deletions(-)

I went ahead and pushed these two patches upstream, but like I said it'd
be nice to get some proper BtIO abstraction for all this including also
BR/EDR support. And even before that I wouldn't mind a patch to add a
proper code comment that explains how this works (with the POLLOUT).

Johan
