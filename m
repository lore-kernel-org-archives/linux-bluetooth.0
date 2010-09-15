Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 15:49:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add handling of TITLE contact's field in vCard
Message-ID: <20100915124937.GA27399@jh-x301>
References: <AANLkTikjKRY_ZBjNeyJrsSObb4qVNfNgdpdUzghmYrD8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikjKRY_ZBjNeyJrsSObb4qVNfNgdpdUzghmYrD8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Sep 15, 2010, Rafał Michalski wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Wed, 15 Sep 2010 09:16:11 +0200
> Subject: [PATCH] Add handling of TITLE contact's field in vCard
> 
> After pulling contacts this field wasn't presented in downloaded vCard
> structure in spite of that it existed (not empty). Now it shows downloaded
> TITLE field (using database query).
> ---
>  plugins/phonebook-tracker.c |   23 ++++++++++++-----------
>  plugins/vcard.c             |    4 ++++
>  plugins/vcard.h             |    1 +
>  3 files changed, 17 insertions(+), 11 deletions(-)

Thanks for the patch. It's now upstream.

Johan
