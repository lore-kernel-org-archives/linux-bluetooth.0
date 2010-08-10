Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 10:04:25 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix multiple phone number problem in pull vcard
Message-ID: <20100810140425.GA19661@jh-x301>
References: <1281425000-2029-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281425000-2029-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Aug 10, 2010, Radoslaw Jablonski wrote:
> This fixes problem with pull vcard when contact has more than one home or
> work number defined in tracker - more than one VCARD was generated in
> response for pull vcard request. This was caused by nature of the data
> retrieved from tracker - contact with multiple numbers set was returned as
> many entries with identical id. Previously VCARDs was generated on the fly
> - now added contact-data caching and checking for contact id. VCARD is now
> generated when all responses of tracker were processed - and only one vcard
> is returned for one contact entry.
> ---
>  plugins/phonebook-tracker.c |  130 ++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 109 insertions(+), 21 deletions(-)

The patch is now merged upstream. Thanks.

Johan
