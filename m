Return-Path: <cyrus@holtmann.org>
Message-ID: <1346137014.9800.19.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 Aug 2012 08:56:54 +0200
In-Reply-To: <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
	 <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-08-24 at 16:59 +0300, Luiz Augusto von Dentz wrote:
> +				array{string} Fields:
> +
> +					Item vcard fields, default is all
> +					values.
> +
> +					Possible values:
> +
> +						"VERSION",
> +						"FN",
> +						"N",
> +						"PHOTO",
> +						"BDAY",
> +						"ADR",
> +						"LABEL",
> +						"TEL",
> +						"EMAIL",
> +						"MAILER",
> +						"TZ",
> +						"GEO",
> +						"TITLE",
> +						"ROLE",
> +						"LOGO",
> +						"AGENT",
> +						"ORG",
> +						"NOTE",
> +						"REV",
> +						"SOUND",
> +						"URL",
> +						"UID",
> +						"KEY",
> +						"NICKNAME",
> +						"CATEGORIES",
> +						"PROID",
> +						"CLASS",
> +						"SORT-STRING",
> +						"X-IRMC-CALL-DATETIME"

What about selecting the bits which don't have a named property
associated with them? They are reported by ListFilterFields() and thus
seem to be supported.

Should the API spec really specify the full list? IMHO the documentation
should make it clear that the list is not exhaustive - more fields might
be added in future releases of the PBAP standard and obexd, without
changing the obexd API.

In SyncEvolution, I use ListFilterFields() to a) do sanity checks on
user input and to b) build a list of all fields from which the user can
exclude specific fields. Because the field list is not hard-coded, that
will work for fields which are not defined yet.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


