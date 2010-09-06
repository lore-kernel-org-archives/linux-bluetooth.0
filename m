Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 10:04:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling of UID contact's field in vCARD
Message-ID: <20100906070411.GA11931@jh-x301>
References: <AANLkTimXoJfN_Tsa-pMp3KemnnrhGbFTb0yJNGAy7bQe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimXoJfN_Tsa-pMp3KemnnrhGbFTb0yJNGAy7bQe@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Sep 03, 2010, Rafał Michalski wrote:
> From: Rafal Michalski <michalski.raf@gmail.com>
> Date: Fri, 3 Sep 2010 12:24:03 +0200
> Subject: [PATCH] Fix handling of UID contact's field in vCARD
> 
> Previously invalid field was assigned to uid data. To solve this
> problem extending number of columns and queries of database was needed
> especially (one field in database query was added).
> ---
>  plugins/phonebook-tracker.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)

Thanks for the patch. It's now upstream.

Johan
