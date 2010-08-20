Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Aug 2010 15:25:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add handling of single contact's fields handled in
 VCARD structure
Message-ID: <20100820122556.GA15506@jh-x301>
References: <AANLkTin5i+qBUga7sjMQFMCxHgafP8H4Lbd1+zfM1Jcf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTin5i+qBUga7sjMQFMCxHgafP8H4Lbd1+zfM1Jcf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Aug 20, 2010, Rafał Michalski wrote:
> From 09a00e743a8aa8f11b88f9fc440029970b030e04 Mon Sep 17 00:00:00 2001
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Fri, 20 Aug 2010 09:00:33 +0200
> Subject: [PATCH 1/2] Add handling of single contact's fields handled in VCARD structure
> 
> After pulling contacts these fields weren't present in downloaded
> VCARD structure in spite of that these fields existed (not empty).
> 
> This patch adds handling of fields: BDAY, NICKNAME, URL, PHOTO
> To solve this problem extending number of columns and queries of database
> was needed especially. Displaying these fields is done by genaral
> functions: vcard_printf_tag, vcard_printf_slash_tag.
> Of course fields mentioned above were added to phonebook_contact structure
> as char * type to save gained data.
> ---
>  plugins/phonebook-tracker.c |   29 ++++++++++++++----
>  plugins/vcard.c             |   68 +++++++++++++++++++++++++++++++++++++++++++
>  plugins/vcard.h             |    4 ++
>  3 files changed, 95 insertions(+), 6 deletions(-)

Thanks. This patch has now been pushed upstream.

Johan
