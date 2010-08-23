Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Aug 2010 23:50:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix issues with emails category
Message-ID: <20100823205044.GA10600@jh-x301>
References: <AANLkTi=KpD_dtVVe7tSBT-+Kv11QsXf-WbtanAe3ur9-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=KpD_dtVVe7tSBT-+Kv11QsXf-WbtanAe3ur9-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Aug 23, 2010, Lukasz Pawlik wrote:
> From: Lukasz Pawlik <lucas.pawlik@gmail.com>
> Date: Mon, 23 Aug 2010 15:25:20 +0200
> Subject: [PATCH] Fix issues with emails category
> 
> Previously all emails sent during phonebook pull had the same
> category INTERNET. Now email are sent with valid category name
> (INTERNET;HOME or INTERNET;WORK)
> ---
>  plugins/phonebook-tracker.c |   31 +++++++++++++++++--------
>  plugins/vcard.c             |   53 ++++++++++++++++++++++++++++++++++---------
>  plugins/vcard.h             |   11 +++++++++
>  3 files changed, 74 insertions(+), 21 deletions(-)

Thanks. The patch is now pushed upstream, but I had to make a few coding
style fixes before that:

> +static struct phonebook_email *find_email(GSList *emails, const char *address,
> +										int type)

Over 80 column line.

> +	for (l = emails; l; l = l->next) {
> +		struct phonebook_email *email;
> +		email = l->data;

You don't really need the variable definition and assignment on
different lines here.

> +static void add_email(struct phonebook_contact *contact, const char *address,
> +						int type)

The continuation line should be indented as much as possible as long as
you don't go beyond 80 columns. (not sure if this is a kernel coding
style thingie but at least Marcel wants it that way).

> +static void vcard_printf_email(GString *vcards, uint8_t format,
> +								const char *address,
> +								enum phonebook_email_type category)

Way over 80 column lines. Are you using some other tab-width than 8?

Johan
