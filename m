Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352372578-18252-1-git-send-email-sunil.behera@samsung.com>
References: <1352372578-18252-1-git-send-email-sunil.behera@samsung.com>
Date: Mon, 12 Nov 2012 12:35:12 +0200
Message-ID: <CABBYNZLgL6Pcuz1RpMTiG_qHumjy3xePeDKWMG36qjenUg6YeQ@mail.gmail.com>
Subject: Re: [PATCH obexd v1 1/3] MAP: Add get_next_header() in message listing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Thu, Nov 8, 2012 at 1:02 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> In case of message listing we need to send application
> parameters in response and also it is required for sending
> response to message listing size request.
> ---
>  plugins/mas.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index 186d267..319c87f 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -810,6 +810,7 @@ static struct obex_mime_type_driver mime_msg_listing = {
>         .target = MAS_TARGET,
>         .target_size = TARGET_SIZE,
>         .mimetype = "x-bt/MAP-msg-listing",
> +       .get_next_header = any_get_next_header,
>         .open = msg_listing_open,
>         .close = any_close,
>         .read = any_read,
> --
> 1.7.9.5

Pushed upstream, thanks.


-- 
Luiz Augusto von Dentz
