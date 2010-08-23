Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Aug 2010 14:42:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix issues with emails category
Message-ID: <20100823114244.GA28080@jh-x301>
References: <AANLkTik_S1g==mJKEQHpKGbFiQALj2nE=UboDBiNfVYY@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTik_S1g==mJKEQHpKGbFiQALj2nE=UboDBiNfVYY@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Aug 23, 2010, Lukasz Pawlik wrote:
> +	struct phonebook_email *email_addr;
> +
> +	for (l = emails; l; l = l->next) {
> +		email_addr = l->data;

Please always define variables in the smallest possible scope. In this
case email_addr can be defined in the beginning of the for-loop instead
of the beginning of the function.

> +		if (g_strcmp0(email_addr->email, email) == 0
> +			&& email_addr->type == type)
> +			return email_addr;

Continuation lines should be indented by at least two tabs more than the
original so that they stand out clearly from the actual code that's part
of the subsection. Also, the && goes on the preceeding line.


> -static void add_email(struct phonebook_contact *contact, const char *email)
> +static void add_email(struct phonebook_contact *contact, const char *email,
> +					int type)
>  {
> +	struct phonebook_email *email_addr;
>  	if (email == NULL || strlen(email) == 0)
>  		return;
>  
>  	/* Not adding email if there is already added with the same value */
> -	if (find_email(contact->emails, email))
> +	if (find_email(contact->emails, email, type))
>  		return;
>  
> -	contact->emails = g_slist_append(contact->emails, g_strdup(email));
> +	email_addr = g_new0(struct phonebook_email, 1);
> +	email_addr->email = g_strdup(email);
> +	email_addr->type = type;
> +
> +	contact->emails = g_slist_append(contact->emails, email_addr);

I'd do some renaming of variables here to make it more readable:

s/email/address/
s/email_address/email/
s/email->email/email->address/

> +struct phonebook_email {
> +	char *email;

As mentioned above I'd do a s/email/address/ here.

Johan
