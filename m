Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288344619-18133-1-git-send-email-lucas.pawlik@gmail.com>
References: <1288344619-18133-1-git-send-email-lucas.pawlik@gmail.com>
Date: Fri, 29 Oct 2010 08:46:51 -0400
Message-ID: <AANLkTinMEBCiPoW+Za1PTywapG+0qwR1+OZoeyBbvxrU@mail.gmail.com>
Subject: Re: [PATCH] Fix handling nco affiliation fields
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 29, 2010 at 5:30 AM, Lukasz Pawlik <lucas.pawlik@gmail.com> wrote:
> Previously when contact record was divided into separate replies,
> phonebook-tracker would use first reply and merge only phone numbers,
> addresses and emails from next. Now it's merging all fields dependent on the
> nco:hasAffiliation as well.
> ---
>  plugins/phonebook-tracker.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 96290a4..f37ed5a 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -982,6 +982,14 @@ static void add_phone_number(struct phonebook_contact *contact,
>        contact->numbers = g_slist_append(contact->numbers, number);
>  }
>
> +static void add_affiliation(char **field, const char *value)
> +{
> +        if(strlen(*field) != 0 || value == NULL || strlen(value) == 0)
> +                return;

Is *field always non-NULL ? If yes, then the next g_strdup() will leak
one byte (the "\0"). If not, strlen() will segfault on a NULL pointer.

> +
> +        *field = g_strdup(value);
> +}
> +
>  static struct phonebook_email *find_email(GSList *emails, const char *address,
>                                                                int type)
>  {
> @@ -1196,6 +1204,13 @@ add_numbers:
>        g_free(home_addr);
>        g_free(work_addr);
>
> +        /* Adding fields connected by nco:hasAffiliation - they may be in
> +         * separate replies */
> +        add_affiliation(&contact->title, reply[33]);
> +        add_affiliation(&contact->company, reply[22]);
> +        add_affiliation(&contact->department, reply[23]);
> +        add_affiliation(&contact->role, reply[24]);
> +
>        DBG("contact %p", contact);
>
>        /* Adding contacts data to wrapper struct - this data will be used to
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
