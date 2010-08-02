Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 23:06:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] ebook backend: return all TEL attribs from vcard
 in string
Message-ID: <20100802200640.GA525@jh-x301>
References: <201007281324.o6SDO9YB010621@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201007281324.o6SDO9YB010621@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 28, 2010, Marcel Mol wrote:
> evcard_to_string() only took one TEL attrib from a vcard. But
> multiple TEL attribs are supported. This patch will convert
> all TEL attribs to strings.
> ---
>  plugins/phonebook-ebook.c |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
> index 089b956..04b7900 100644
> --- a/plugins/phonebook-ebook.c
> +++ b/plugins/phonebook-ebook.c
> @@ -97,6 +97,7 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
>  							uint64_t filter)
>  {
>  	EVCard *evcard2;
> +	GList *l;
>  	char *vcard;
>  	unsigned int i;
>  
> @@ -109,18 +110,19 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
>  	 */
>  	filter = format == EVC_FORMAT_VCARD_30 ? filter | 0x87: filter | 0x85;
>  
> +	l = e_vcard_get_attributes(evcard);
>  	evcard2 = e_vcard_new();
> -	for (i = 0; i < 29; i++) {
> -		EVCardAttribute *attrib;
> -
> -		if (!(filter & (1 << i)))
> -			continue;
> -
> -		attrib = e_vcard_get_attribute(evcard, attribute_mask[i]);
> -		if (!attrib)
> -			continue;
> -
> -		e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));
> +	for (; l; l = g_list_next(l)) {
> +		EVCardAttribute *attrib = l->data;
> +		if (attrib) {
> +			const char *name = e_vcard_attribute_get_name(attrib);
> +			for (i = 0; i < 29; i++) {
> +				if (!(filter & (1 << i)))
> +					continue;
> +				if (!strcmp(name, attribute_mask[i]))
> +					e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));
> +			}
> +		}
>  	}

This needs to be cleaned up a bit in order not to be so deeply nested
which additionally causes you problems with producing over 80-character
long lines. You can avoid that with keeping the same
	if (!attrib)
		continue;
trick as the original code had as well as
	if (g_strcmp0(name, attribute_mask[i]) != 0)
		continue;

Johan
