Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417615733-7350-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1417615733-7350-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 3 Dec 2014 23:32:07 +0200
Message-ID: <CABBYNZLb-EFiw5fVNVx-fWQS8h2XHKRfq3PLgt17M39z24Kj8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] obexd: Fix comparing array to 0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 3, 2014 at 4:08 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Comparing an arrays to 0 is not useful.

I guess you mean this should never fail so it dead code in practice
since the array will never be NULL, we should probably fix the message
then.

> ---
>  obexd/client/pbap.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 57632b4..28203a8 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1111,9 +1111,6 @@ static gboolean get_databaseid(const GDBusPropertyTable *property,
>         char value[33];
>         const char *pvalue = value;
>
> -       if (!pbap->databaseid)
> -               return FALSE;
> -
>         if (u128_to_string(pbap->databaseid, value, sizeof(value)) < 0)
>                 return FALSE;
>
> @@ -1137,9 +1134,6 @@ static gboolean get_primary(const GDBusPropertyTable *property,
>         char value[33];
>         const char *pvalue = value;
>
> -       if (!pbap->primary)
> -               return FALSE;
> -
>         if (u128_to_string(pbap->primary, value, sizeof(value)) < 0)
>                 return FALSE;
>
> @@ -1155,9 +1149,6 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
>         char value[33];
>         const char *pvalue = value;
>
> -       if (!pbap->secondary)
> -               return FALSE;
> -
>         if (u128_to_string(pbap->secondary, value, sizeof(value)) < 0)
>                 return FALSE;
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
