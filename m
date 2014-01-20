Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390239558-6384-1-git-send-email-linux@hschmitt.de>
References: <1390239558-6384-1-git-send-email-linux@hschmitt.de>
Date: Mon, 20 Jan 2014 21:29:47 +0200
Message-ID: <CABBYNZLDtvMzbZN8Ju+VpAnFwQc2vVnqkgAeyM73XC8af3XeGw@mail.gmail.com>
Subject: Re: [PATCH] obexd/irmc: Fix folder for LUID requests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harald,

On Mon, Jan 20, 2014 at 7:39 PM, Harald Schmitt <linux@hschmitt.de> wrote:
> The old macro PB_LUID_FOLDER had the folder luid on the second level:
> /telecom/luid. But the luid folder occurs per IrMC spec on level three e.g.
> /telecom/pb/luid. On the second level the object store e.g. pb is specified.
> This bug was introduced with commit 62ebf8d0f345e7722334d852cf7a010b202647e7.
> ---
>  obexd/plugins/irmc.c      | 6 +++---
>  obexd/plugins/phonebook.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
> index d343977..d0e98b4 100644
> --- a/obexd/plugins/irmc.c
> +++ b/obexd/plugins/irmc.c
> @@ -326,7 +326,7 @@ static int irmc_open_nt(struct irmc_session *irmc)
>         return 0;
>  }
>
> -static int irmc_open_luid(struct irmc_session *irmc)
> +static int irmc_open_pb_luid(struct irmc_session *irmc)
>  {
>         if (irmc->buffer == NULL)
>                 irmc->buffer = g_string_new("");
> @@ -381,8 +381,8 @@ static void *irmc_open(const char *name, int oflag, mode_t mode, void *context,
>                 ret = irmc_open_cal(irmc);
>         else if (g_str_has_prefix(path, PB_NOTES_FOLDER))
>                 ret = irmc_open_nt(irmc);
> -       else if (g_str_has_prefix(path, PB_LUID_FOLDER))
> -               ret = irmc_open_luid(irmc);
> +       else if (g_str_has_prefix(path, PB_CONTACTS_LUID_FOLDER))
> +               ret = irmc_open_pb_luid(irmc);
>         else
>                 ret = -EBADR;
>
> diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
> index 441cff2..015c9a3 100644
> --- a/obexd/plugins/phonebook.h
> +++ b/obexd/plugins/phonebook.h
> @@ -37,7 +37,7 @@
>  #define PB_CALLS_INCOMING_FOLDER "/telecom/ich"
>  #define PB_CALLS_MISSED_FOLDER "/telecom/mch"
>  #define PB_CALLS_OUTGOING_FOLDER "/telecom/och"
> -#define PB_LUID_FOLDER "/telecom/luid"
> +#define PB_CONTACTS_LUID_FOLDER "/telecom/pb/luid"
>
>  #define PB_CONTACTS "/telecom/pb.vcf"
>  #define PB_CALLS_COMBINED "/telecom/cch.vcf"
> --
> 1.8.3.2

I went ahead and pushed this one, but I preserve much of the define
and function names used before since I did not see any reason to
change those.


-- 
Luiz Augusto von Dentz
