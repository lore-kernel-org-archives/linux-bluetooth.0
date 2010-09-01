Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 16:44:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add handling for more than one address in vCard
Message-ID: <20100901134449.GA15306@jh-x301>
References: <AANLkTinHqG2Vbfr5qyEX0v8dAxATWy3nO_r25TkY8io3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinHqG2Vbfr5qyEX0v8dAxATWy3nO_r25TkY8io3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Sep 01, 2010, Rafał Michalski wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Wed, 1 Sep 2010 13:07:12 +0200
> Subject: [PATCH] Add handling for more than one address in vCard
> 
> After pulling contacts only fields (pobox, extended, street, locality,
> region, postal, country) of one address were present in downloaded vCard
> structure (under ADR tag) in spite of that there can be more adresses
> stored on phonebook. To solve this problem extending number of columns and
> queries of database was needed especially. Distinguish between two types
> of address (HOME and WORK) is supported.
> ---
>  plugins/phonebook-tracker.c |   93 ++++++++++++++++++++++++++++++++++++------
>  plugins/vcard.c             |   89 ++++++++++++++++++++++++++++++++++-------
>  plugins/vcard.h             |   15 ++++++-
>  3 files changed, 167 insertions(+), 30 deletions(-)

Thanks. This patch is now upstream.

Johan
