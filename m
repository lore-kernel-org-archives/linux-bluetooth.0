Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 12:15:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Additional contact's field handled in VCARD structure
Message-ID: <20100818091540.GA30383@jh-x301>
References: <1282117176-28912-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282117176-28912-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Aug 18, 2010, Rafal Michalski wrote:
> After pulling contacts some fields weren't present in downloaded
> VCARD structure in spite of that these fields existed (not empty).
> 
> I added handling fields: BDAY, NICKNAME, URL, PHOTO and three fields
> grouped under ORG tag (Company, Department, Job Title).
> To solve this problem extending number of columns and queries of database
> was needed especially. Of course fields mentioned above were added to
> phonebook_contact structure as char * type to save gained data

First of all, could we try to get the commit message format consistent
with the rest of the git tree. I.e. keep the summary line as "Add
handling of ..." and don't speak in the first person, i.e. instead of "I
added ..." write "This patch adds ...". Just look at the commit history
of bluez and obexd if you need examples.

It's a rather small patch, but if possible could you still split it into
smaller chunks. When your commit message says "This patch adds X and Y
and Z" it's a good hint that there should be a separate patch for each
feature, epecially if the features arent interdependent.

> +	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) " 	\

There's an extra space before the tab at the end of the line.

> +	"nmo:receivedDate(?call) nmo:isSent(?call) " 			\

Same here.

> +	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) " 	\

And here.

> +	"nmo:receivedDate(?call) nmo:isSent(?call) " 			\

And here.

Enable whitespace visualisation in your editor to catch these. If you
need hints for how to do this in vim (which I use myself) let me know.

> +static void vcard_printf_bday(GString *vcards, const char *birthday)
> +{
> +	int len = 0;
> +
> +	if (birthday)
> +		len = strlen(birthday);
> +
> +	if (len)
> +		vcard_printf(vcards, "BDAY:%s", birthday);
> +}

Instead of structuring the logic like this, could you simply do:

	if (birthday == NULL || strlen(birthday) == 0)
		return;

	vcard_printf(...);

The same applies for your other printf functions (though in some of them
you'll need to preserve the len variable for calling the add_slash
function).

> +static void vcard_printf_nickname(GString *vcards, const char *nickname)
> +{
> +	int len = 0;
> +
> +	if (nickname)
> +		len = strlen(nickname);
> +
> +	if (len) {
> +		char field[LEN_MAX];
> +		add_slash(field, nickname, LEN_MAX, len);
> +		vcard_printf(vcards, "NICKNAME:%s", field);
> +	}
> +}
> +
> +static void vcard_printf_url(GString *vcards, const char *website)
> +{
> +	int len = 0;
> +
> +	if (website)
> +		len = strlen(website);
> +
> +	if (len) {
> +		char field[LEN_MAX];
> +		add_slash(field, website, LEN_MAX, len);
> +		vcard_printf(vcards, "URL;TYPE=INTERNET:%s", field);
> +	}
> +}

These functions look very similar in logic. Are there others in the
existing code too? If so, you might want to consider creating a
generalized function which takes the type and value as input parameters
instead of having a separate function for each type.

Johan
