Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Aug 2010 10:01:31 -0400
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix multiple phone number problem in pull vcard
Message-ID: <20100809140131.GB10150@jh-x301>
References: <1281352651-30943-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281352651-30943-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Aug 09, 2010, Radoslaw Jablonski wrote:
> This fixes problem with pull vcard when contact has more than one home or
> work number defined in tracker - more than one VCARD was generated in
> response for pull vcard request. This was caused by nature of the data
> retrieved from tracker - contact with multiple numbers set was returned as
> many entries with identical id. Previously VCARDs was generated on the fly
> - now added contact-data caching and checking for contact id. VCARD is now
> generated when all responses of tracker were processed - and only one vcard
> is returned for one contact entry.
> ---
>  plugins/phonebook-tracker.c |  134 ++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 112 insertions(+), 22 deletions(-)

Some coding style issue that need fixing:

> +struct contact_data
> +{

The { shouldn't go on it's own line, i.e. put it in the above line.

> +static struct phonebook_contact *find_contact (GSList *contacts,char *id)
> +{

Remove the space after "find_contact", add a space after ",". Since
you're not modifying id in the function it should probably be const char *
instead of char *.

> +	GSList *it;

Usually simple list iterators are called just "l".

> +	for(it = contacts; it; it = it->next) {

Space between for and (

> +	for(it = numbers; it; it = it->next) {

Same here, and call the list variable "l".

> +static GString * gen_vcards(GSList *contacts,
> +			const struct apparam_field *params)

No space between * and gen_vcards.

> +	GSList *it;

Again, call it "l".

> +	for(it = contacts; it; it = it->next) {

Space between for and (

> +	if (!cdata_present) {
> +		contact_data = g_new0(struct contact_data, 1);
> +		contact_data->contact = contact;
> +		contact_data->id = g_strdup(reply[CONTACTS_ID_COL]);
> +		data->contacts = g_slist_append(data->contacts, contact_data);
> +	}
>  	return;

Add an empty line before the return

>  	data = g_new0(struct phonebook_data, 1);
> -	data->vcards = g_string_new(NULL);
>  	data->params = params;
>  	data->user_data = user_data;
>  	data->cb = cb;
> +	data->contacts = NULL;

Since you used g_new0 setting to NULL seems redundant.

Johan
