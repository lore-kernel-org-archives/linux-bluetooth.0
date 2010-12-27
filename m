Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
	<1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
Date: Mon, 27 Dec 2010 16:14:15 +0200
Message-ID: <AANLkTikcZRjC2KwOpHSqS_6wMcT8skKBMbhMzs=ugK+F@mail.gmail.com>
Subject: Re: [PATCH 2/4] Use stored device name (if any) instead of EIR data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 27, 2010 at 3:21 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> The stored device name comes from either name resolution or from a
> "complete" EIR name. If available, use it and ignore any further name
> present on EIR data.
> ---
>  src/event.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/src/event.c b/src/event.c
> index 6598e37..f445dd1 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -549,22 +549,14 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>        } else
>                legacy = TRUE;
>
> -       if (eir_data.name) {
> +       if (name == NULL && eir_data.name != NULL) {
>                if (eir_data.name_complete) {
>                        write_device_name(local, peer, eir_data.name);
>                        name_status = NAME_NOT_REQUIRED;
> -
> -                       if (name)
> -                               g_free(name);
> -
> -                       name = eir_data.name;
> -               } else {
> -                       if (name)
> -                               free(eir_data.name);
> -                       else
> -                               name = eir_data.name;
>                }
> -       }
> +               name = eir_data.name;
> +       } else if (eir_data.name != NULL)
> +               g_free(eir_data.name);
>
>        adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
>                                        legacy, eir_data.services, name_status);

It seems your path changes more than just ignore the shortened names,
which I believed was the purpose here, if the variable name is set
than your could would skip eir name completely while the code did
actually use the eir name, probably the eir name is updated more
frequently so it is probably the most updated one and we should in
fact update the storage if they don't match.

Now about the shortened, Im not completely sure if we should ignore it
or just append something to it, like e.g. ... or ~1, in case the spec
say it is always the prefix we can at least use it as an hint if the
name we have resolved does have changed.

-- 
Luiz Augusto von Dentz
Computer Engineer
