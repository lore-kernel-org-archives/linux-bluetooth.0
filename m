Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 15:22:49 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Split pull_contacts to smaller functions
Message-ID: <20101116152249.GA2221@jh-x301>
References: <1289915995-2749-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289915995-2749-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Nov 16, 2010, Bartosz Szatkowski wrote:
> +static void contact_init(struct phonebook_contact **contact, char **reply)
> +{
> +	if (*contact == NULL)
> +		*contact = g_new0(struct phonebook_contact, 1);

Could you do this initialization before calling this function and pass
just a simple pointer to it. I think it'd be a cleaner approach.

> +static void contact_add_numbers(struct phonebook_contact **contact, char **reply)

Over 79 column line. Please split it.

> +	if ((g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) != 0) &&
> +			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) != 0) &&
> +			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) != 0))
> +		add_phone_number(*contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
> +}

Same here. However, I think you can make it considerably more readable
with something like:

        if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) == 0)
                return;

        if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) == 0)
                return;

        if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) == 0)
                return;

        add_phone_number(*contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);

> +static void contact_add_emails(struct phonebook_contact **contact, char **reply)

Over 79 column line.

> +{
> +	add_email(*contact, reply[COL_HOME_EMAIL], EMAIL_TYPE_HOME);
> +	add_email(*contact, reply[COL_WORK_EMAIL], EMAIL_TYPE_WORK);
> +	add_email(*contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
> +}

Why does the function take a pointer to pointer when a simple pointer
would be enough?

> +static void contact_add_addresses(struct phonebook_contact **contact, char **reply)

Over 79 columns and unnecessary ** pointer again.

> +	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
> +				reply[COL_HOME_ADDR_POBOX], reply[COL_HOME_ADDR_EXT],
> +				reply[COL_HOME_ADDR_STREET], reply[COL_HOME_ADDR_LOCALITY],
> +				reply[COL_HOME_ADDR_REGION], reply[COL_HOME_ADDR_CODE],
> +				reply[COL_HOME_ADDR_COUNTRY]);
> +
> +	work_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
> +				reply[COL_WORK_ADDR_POBOX], reply[COL_WORK_ADDR_EXT],
> +				reply[COL_WORK_ADDR_STREET], reply[COL_WORK_ADDR_LOCALITY],
> +				reply[COL_WORK_ADDR_REGION], reply[COL_WORK_ADDR_CODE],
> +				reply[COL_WORK_ADDR_COUNTRY]);
> +
> +	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
> +				reply[COL_OTHER_ADDR_POBOX], reply[COL_OTHER_ADDR_EXT],
> +				reply[COL_OTHER_ADDR_STREET], reply[COL_OTHER_ADDR_LOCALITY],
> +				reply[COL_OTHER_ADDR_REGION], reply[COL_OTHER_ADDR_CODE],
> +				reply[COL_OTHER_ADDR_COUNTRY]);

All of these are over 79 columns.

> +static void contact_add_organization(struct phonebook_contact **contact, char **reply)

Same here. And a simple * pointer is enough.

Johan
