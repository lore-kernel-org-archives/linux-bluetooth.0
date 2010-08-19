Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 16:36:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add handling of single contact's fields handled in
 VCARD structure
Message-ID: <20100819133614.GA15424@jh-x301>
References: <1282218500-18458-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1282218500-18458-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Aug 19, 2010, Rafal Michalski wrote:
> After pulling contacts these fields weren't present in downloaded
> VCARD structure in spite of that these fields existed (not empty).
> 
> This patch adds handling of fields: BDAY, NICKNAME, URL, PHOTO
> To solve this problem extending number of columns and queries of database
> was needed especially. Displaying these fields is done by genaral
> functions: vcard_printf_slash_tag, vcard_printf_slash_slash_tag.
> Of course fields mentioned above were added to phonebook_contact structure
> as char * type to save gained data.
> ---
>  plugins/phonebook-tracker.c |   29 +++++++++++++++----
>  plugins/vcard.c             |   66 +++++++++++++++++++++++++++++++++++++++++++
>  plugins/vcard.h             |    4 ++
>  3 files changed, 93 insertions(+), 6 deletions(-)

Please always check that your patches compile cleanly with
./bootstrap-configure before submitting upstream. I get this when
compiling your patch:

plugins/vcard.c: In function ‘vcard_printf_tag’:
plugins/vcard.c:268: error: ISO C90 forbids mixed declarations and code
plugins/vcard.c: In function ‘vcard_printf_slash_tag’:
plugins/vcard.c:292: error: ISO C90 forbids mixed declarations and code
plugins/vcard.c:302: error: ISO C90 forbids mixed declarations and code
make[1]: *** [plugins/vcard.o] Error 1

Furthermore, there were the following issues I spotted:

> +static void vcard_printf_tag(GString *vcards, const char *tag,
> +					const char* category, const char *fld)

That should be "char *category" and not "char* category"

> +	char separator = '\0', *type = "";
> +	char buf[LEN_MAX];
> +
> +	if (category && strlen(category)) {
> +		separator = ';';
> +		type = "TYPE=";
> +	}
> +
> +	snprintf(buf, sizeof(buf), "%s%c%s%s", tag, separator, type, category);

sprintf("...%c...", '\0'); will embed a null-byte into the string which
I'm sure is something that you don't want. Just use a normal string and
%s instead, i.e. "".

> +static void vcard_printf_slash_tag(GString *vcards, const char *tag,
> +					const char* category, const char *fld)

Again, char *foo instead of char* foo.

> +	char separator = '\0', *type = "";
> +	char buf[LEN_MAX];
> +
> +	if (category && strlen(category)) {
> +		separator = ';';
> +		type = "TYPE=";
> +	}
> +
> +	snprintf(buf, sizeof(buf), "%s%c%s%s", tag, separator, type, category);

And the same problem with the null-byte.

Johan
