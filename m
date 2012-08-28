Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Aug 2012 18:17:08 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
Message-ID: <20120828011708.GA11305@x220.sheraton.com>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
 <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Aug 24, 2012, Luiz Augusto von Dentz wrote:
> ---
>  doc/client-api.txt | 180 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 145 insertions(+), 35 deletions(-)

I had a chat with Marcel about this API which resulted with the
following change proposals:

> +				string Order:
> +
> +					Items order
> +
> +					Possible values: "indexed" (default),
> +					"alphanumeric" or "phonetic"
> +
> +				uint16 Offset:
> +
> +					Offset of the first item, default is 0
> +
> +				uint16 Items:
> +
> +					Maximum number of items, default is
> +					unlimited (65535)

Call this MaxCount or Count to make it clearer.

> +
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

Make these lower case (I know it's upper case in the spec. but let's
keep the consistency with the rest of the D-Bus API).

> @@ -244,8 +325,54 @@ Methods		void Select(string location, string phonebook)
>  			The properties of this transfer are also returned along
>  			with the object path, to avoid a call to GetProperties.
>  
> +			filters:
> +
> +				string Format:
> +
> +					Items vcard format
> +
> +					Possible values: "vcard21" (default) or
> +					"vcard30"
> +
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

Is this a duplicate of the previous section. Maybe just move this out to
a common section and the refer to it from the places that need it.

Johan
