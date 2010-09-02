Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 11:10:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add handling of UID contact's field in vCard
Message-ID: <20100902081028.GA4806@jh-x301>
References: <AANLkTi=nEVCDx3L3B5d0Xet7uJU0XXpBqgCYf0AQ5fz9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTi=nEVCDx3L3B5d0Xet7uJU0XXpBqgCYf0AQ5fz9@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Sep 02, 2010, Rafał Michalski wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Wed, 1 Sep 2010 16:08:35 +0200
> Subject: [PATCH] Add handling of UID contact's field in vCard
> 
> After pulling contacts this field wasn't presented in downloaded vCard
> structure in spite of that it existed (not empty). Now it shows downloaded
> UID (using database query).
> ---
>  plugins/phonebook-tracker.c |    1 +
>  plugins/vcard.c             |    4 ++++
>  plugins/vcard.h             |    1 +
>  3 files changed, 6 insertions(+), 0 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
