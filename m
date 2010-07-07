Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Added empty VCARD N: parameter handling
From: Marcel Holtmann <marcel@holtmann.org>
To: ext-jablonski.radoslaw@nokia.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <090FE800A758CA439B2752C082AC3DEF037828C921@NOK-EUMSG-06.mgdnok.nokia.com>
References: <090FE800A758CA439B2752C082AC3DEF037828C920@NOK-EUMSG-06.mgdnok.nokia.com>
	 ,<1278508613.2789.114.camel@localhost.localdomain>
	 <090FE800A758CA439B2752C082AC3DEF037828C921@NOK-EUMSG-06.mgdnok.nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Jul 2010 17:25:04 -0300
Message-ID: <1278534304.10421.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I've made necessary changes to the code. Now it should look much better:)
> New version of patch is inserted below.

and please use git send-email. Otherwise we can't apply it with git am.

> From 45dfcf8f9dfacd8937a1a1d14146bd0da04eca25 Mon Sep 17 00:00:00 2001
> From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
> Date: Wed, 7 Jul 2010 17:18:31 +0300
> Subject: [PATCH] Added empty VCARD N: parameter handling
> 
> Some of the devices are expecting that N: parameter in VCARD is always filled (by example Nokia BH-903)
> When this field is empty (N:;;;;) then list of dialed/incoming calls on carkit is useless - carkit then shows only blank lines and it's impossible to determine who made call ( phone number are invisible too in this case)
> 
> If none of the contact fields is available, then setting telephone number as the first attribute for "N:" parameter.
> Carkit will see that number as contact name - it is only used in case when none of more detailed contact information is available on the phone.
> ---
>  plugins/vcard.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/plugins/vcard.c b/plugins/vcard.c
> index 5948a4a..ab1349c 100644
> --- a/plugins/vcard.c
> +++ b/plugins/vcard.c
> @@ -123,6 +123,20 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
>  	return;
>  }
>  
> +/* checks if there is at least one present contact field with personal data */
> +static gboolean contact_fields_present( struct phonebook_contact * contact)
> +{

It is (struct ... contact *contact). See other code for proper placement
of whitespaces.

> +	if ((contact->family && strlen(contact->family)) ||
> +			(contact->given && strlen(contact->given)) ||
> +			(contact->additional && strlen(contact->additional)) ||
> +			(contact->prefix && strlen(contact->prefix)) ||
> +			(contact->suffix && strlen(contact->suffix)))
> +		return TRUE;
> +
> +	/* none of the personal data fields is present*/
> +	return FALSE;
> +}

	if (contact->family && strlen(contact->family) > 0)
		return TRUE;

	if (contact->given && strlen(contact->given) > 0)
		return TRUE;

	...

	return FALSE;

That is a more readable version of this function.

> +
>  static void vcard_printf_begin(GString *vcards, uint8_t format)
>  {
>  	vcard_printf(vcards, "BEGIN:VCARD");
> @@ -136,6 +150,13 @@ static void vcard_printf_begin(GString *vcards, uint8_t format)
>  static void vcard_printf_name(GString *vcards,
>  					struct phonebook_contact *contact)
>  {
> +	if (contact_fields_present(contact) == FALSE) {
> +		/* if all fields are empty we're using first phone number as name */
> +		struct phonebook_number *number = contact->numbers->data;
> +		vcard_printf(vcards, "N:%s;;;;", number->tel);
> +		return;
> +	}
> +
>  	vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
>  				contact->given, contact->additional,
>  				contact->prefix, contact->suffix);

Regards

Marcel


