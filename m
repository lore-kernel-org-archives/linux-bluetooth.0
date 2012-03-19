Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331559165-28367-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 19 Mar 2012 09:59:37 -0300
Message-ID: <CABBYNZLaMoMuCQ9vY6oiUMa5P0dW-WZLvhWQ19AtmgyZezms1Q@mail.gmail.com>
Subject: Re: [PATCH obexd v0 03/11] client: refactor transfer callback use
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Mar 12, 2012 at 10:32 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Separated internal functions are used to report success, failure, and
> progress, instead of using the callback directly.
>
> This makes the code more readable.
> ---
>  client/transfer.c |   86 ++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index a609aa9..f2a153c 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -138,10 +138,47 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
>        return reply;
>  }
>
> -static void obc_transfer_abort(struct obc_transfer *transfer)
> +static void transfer_notify_progress(struct obc_transfer *transfer)
> +{
> +       struct transfer_callback *callback = transfer->callback;
> +
> +       DBG("%p", transfer);
> +
> +       if ((callback != NULL) && (transfer->transferred != transfer->size))
> +               callback->func(transfer, transfer->transferred, NULL,
> +                                                               callback->data);
> +}

Usually we use early returns and simple statements to be more
readable, so if (callback == NULL) return would have been better. Also
I guess we don't really need this check for transferred != size since
gobex has a complete callback and latter you set it to NULL.


-- 
Luiz Augusto von Dentz
