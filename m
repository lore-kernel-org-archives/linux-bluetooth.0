Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 13:48:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?utf-8?B?UmFmYcWC?= Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Add handling for more than one address in vCard
Message-ID: <20100901104838.GA11813@jh-x301>
References: <AANLkTikGen9zKWdi=J558PXOBKhreu=WJ9_KCrQ=n_sx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikGen9zKWdi=J558PXOBKhreu=WJ9_KCrQ=n_sx@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Sep 01, 2010, Rafał Michalski wrote:
> +static struct phonebook_address *find_address(GSList *addresses,
> +					const char *address, int type)
> +{
> +	GSList *l = addresses;
> +
> +	for (; l; l = l->next) {

Please avoid initialization upon declaration of variables when possible.
The first part of the for-statement is where you should usually
initialize the iterator, i.e. in this case do the l = addresses there.

> +static gboolean address_fields_present(const char *address)
> +{
> +	gchar **address_fields = g_strsplit(address, ";",
> +							ADDR_FIELD_AMOUNT);
> +	int i = 0;
> +
> +	for (; i < ADDR_FIELD_AMOUNT; ++i) {

Same here for i. Additionally you could rename address_fields to simply
fields since the function is short and the context pretty obvious.
You'll also avoid the split line that way (another thing I wouldn't
object to is to move the initialization separate from the variable
declaration).

> -static gboolean address_fields_present(struct phonebook_contact *contact)
> +static gboolean address_fields_present(const char *address)
>  {
> -	gchar **address_fields = g_strsplit(contact->address, ";",
> +	gchar **address_fields = g_strsplit(address, ";",
>  							ADDR_FIELD_AMOUNT);
>  	int i = 0;

Hmm, it seems you have the same function in vcard.c and
phonebook-tracker.c? Why not remove the phonebook-tracker.c one and
export the vcard.c version through vcard.h?

Johan
