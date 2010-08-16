Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Aug 2010 18:16:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with filling ADR with unneeded semicolons
Message-ID: <20100816151606.GA20356@jh-x301>
References: <1281969490-22315-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281969490-22315-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucasz,

On Mon, Aug 16, 2010, Lukasz Pawlik wrote:
> Previously in a phonebook pull request ADR was filled with six
> semicolons when contact address entry was empty in phonebook. This
> patch fixes this problem. Address is send as an empty string.
> ---
>  plugins/vcard.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)

Thanks for the patch, but it'll need some coding style cleanup before
going upstream:

> +static gboolean address_fields_present(struct phonebook_contact * contact)

No space after *

> +	if (contact->country && strlen(contact->country))
> +		return TRUE;
> +	

The last line isn't really empty byt has an extra tab. Please remove it.

> +	if (address_fields_present(contact) == FALSE) {
> +		vcard_printf(vcards, "ADR:");
> +		return;		

There's an extra tab at the end of the line. Please remove it.

> +	}
> +	

Same here.

Johan
