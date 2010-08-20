Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Aug 2010 15:26:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Add handling of ORG contact's fields handled in
 VCARD structure
Message-ID: <20100820122618.GB15506@jh-x301>
References: <AANLkTimU5SnF1D0xJ=qEKsqgJSWNmv+USpViaaUV+bQ0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimU5SnF1D0xJ=qEKsqgJSWNmv+USpViaaUV+bQ0@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Aug 20, 2010, Rafał Michalski wrote:
> From 44a30279e45df82ae4ceed254a7f895331073414 Mon Sep 17 00:00:00 2001
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Fri, 20 Aug 2010 09:01:29 +0200
> Subject: [PATCH 2/2] Add handling of ORG contact's fields handled in VCARD structure
> 
> After pulling contacts these fields weren't present in downloaded
> VCARD structure in spite of that these fields existed (not empty).
> 
> This patch adds handling of fields grouped under ORG tag.
> To solve this problem extending number of columns and queries of database
> was needed especially. Of course fields mentioned above were added to
> phonebook_contact structure as char * type to save gained data.
> ---
>  plugins/phonebook-tracker.c |   38 +++++++++++++++++++++++++++-----------
>  plugins/vcard.c             |   30 ++++++++++++++++++++++++++++++
>  plugins/vcard.h             |    3 +++
>  3 files changed, 60 insertions(+), 11 deletions(-)

And this one is also upstream. Thanks.

Johan
