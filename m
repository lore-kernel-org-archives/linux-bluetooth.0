Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fixed empty 'N:' parameter handling for VCARDs
From: Marcel Holtmann <marcel@holtmann.org>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1278670762-10119-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1278670762-10119-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 10:00:40 -0300
Message-ID: <1278680440.10421.103.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

> Bluetooth PBAP specification expects for call history listing,
> that parameter N: shall be empty when we cannot retrieve personal data
> from PSE phone book.
> Some devices(by example BH-903) are having problems when after N: parameter
>  unnecessary characters occurs. List of dialed/incoming calls on carkit
> then is useless - carkit shows only blank lines and it's impossible to
> determine who made call.
> 
> In previous version unnecessary semicolons were added after N:("N:;;;;")
> to represent empty name.
> Now if none of the contact fields is available, then adding real empty "N:"
> parameter (without semicolons).
> ---
>  plugins/vcard.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/plugins/vcard.c b/plugins/vcard.c
> index 5948a4a..8c7147b 100644
> --- a/plugins/vcard.c
> +++ b/plugins/vcard.c
> @@ -123,6 +123,27 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
>  	return;
>  }
>  
> +/* checks if there is at least one present contact field with personal data */
> +static gboolean contact_fields_present(struct phonebook_contact * contact)
> +{
> +	if (contact->family && strlen(contact->family))
> +		return TRUE;

I asked to use strlen(...) > 0 as test here. Please fix this.

> +
> +	if (contact->given && strlen(contact->given))
> +		return TRUE;
> +	if (contact->additional && strlen(contact->additional))
> +		return TRUE;

Why are these two tight together. Use an extra empty line.

> +	if (contact->prefix && strlen(contact->prefix))
> +		return TRUE;
> +
> +	if (contact->suffix && strlen(contact->suffix))
> +		return TRUE;
> +
> +	/* none of the personal data fields is present*/
> +	return FALSE;
> +}
> +
>  static void vcard_printf_begin(GString *vcards, uint8_t format)
>  {
>  	vcard_printf(vcards, "BEGIN:VCARD");
> @@ -136,6 +157,12 @@ static void vcard_printf_begin(GString *vcards, uint8_t format)
>  static void vcard_printf_name(GString *vcards,
>  					struct phonebook_contact *contact)
>  {
> +	if (contact_fields_present(contact) == FALSE) {
> +		/* if all fields are empty we need to have empty N: parameter */
> +		vcard_printf(vcards, "N:");

I would be good to add a bit more extra text here why we are doing this.
You should mention the broken headset and what is expect outcome.

Also please sort the contact_fields_resent() function about
vcard_printf_name to keep them close together.

Regards

Marcel


