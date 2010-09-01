Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 13:36:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Merging address fields to single field
Message-ID: <20100901103655.GA11705@jh-x301>
References: <AANLkTikL2mskaXPygeWvmdy6zjiRDExiq-yW+PaXoVsU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikL2mskaXPygeWvmdy6zjiRDExiq-yW+PaXoVsU@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Sep 01, 2010, Rafał Michalski wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Wed, 1 Sep 2010 11:49:28 +0200
> Subject: [PATCH 1/2] Merging address fields to single field
> 
> So far in code all seven address fields (pobox, extended, street,
> locality, region, postal, country) was represented separately.
> In vCard structure address is represented by one field so all
> mentioned above fields are merged to single field.
> ---
>  plugins/phonebook-tracker.c |   10 +++-------
>  plugins/vcard.c             |   41 ++++++++++++++++-------------------------
>  plugins/vcard.h             |    8 +-------
>  3 files changed, 20 insertions(+), 39 deletions(-)

Thanks. This patch is now upstream.

Johan
