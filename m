Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Aug 2010 14:20:41 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix issues with emails category
Message-ID: <20100823122041.GB8018@pengutronix.de>
References: <AANLkTik_S1g==mJKEQHpKGbFiQALj2nE=UboDBiNfVYY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTik_S1g==mJKEQHpKGbFiQALj2nE=UboDBiNfVYY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hallo Lukasz,

On Mon, Aug 23, 2010 at 01:18:11PM +0200, Lukasz Pawlik wrote:
> From a537ade2e108a91552e0d9a6c4ff71ca35388e10 Mon Sep 17 00:00:00 2001
> From: Lukasz Pawlik <lucas.pawlik@gmail.com>
> Date: Mon, 23 Aug 2010 12:57:40 +0200
> Subject: [PATCH] Fix issues with emails category
> 
> Previously all emails sent during phonebook pull had the same
> category INTERNET. Now email are sent with valid category name
> (INTERNET;HOME or INTERNET;WORK)
> ---
>  plugins/phonebook-tracker.c |   30 +++++++++++++++++-------
>  plugins/vcard.c             |   53 ++++++++++++++++++++++++++++++++++---------
>  plugins/vcard.h             |   11 +++++++++
>  3 files changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 3f63dcb..069e324 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -687,27 +687,39 @@ static void add_phone_number(struct phonebook_contact *contact,
>  	contact->numbers = g_slist_append(contact->numbers, number);
>  }
>  
> -static gchar *find_email(GSList *emails, const char *email)
> +static struct phonebook_email *find_email(GSList *emails, const char *email,
> +										int type)
I assume your tabsize is < 8, because for me "int type" is after the
comma on the preceeding line.  I don't know for sure, but I assume bluez
uses the same convention as the kernel, so tabsize is 8.  (The functions
below need the same fix.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
