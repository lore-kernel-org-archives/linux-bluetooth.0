Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
References: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 12 Aug 2013 13:53:52 +0300
Message-ID: <CABBYNZLZhZwEH1JNdWGKKogwToQvjfjdwLADzGjJkQcsVN2rdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gobex: Add proper message to transfer errors
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 8, 2013 at 4:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This improve the error message when a transfer fails by using
> g_obex_strerror to decode the response code to a human readable string.
> ---
>  gobex/gobex-transfer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index ac8836c..4203fec 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -207,8 +207,8 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
>
>         rspcode = g_obex_packet_get_operation(rsp, &final);
>         if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
> -               err = g_error_new(G_OBEX_ERROR, rspcode,
> -                                       "Transfer failed (0x%02x)", rspcode);
> +               err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
> +                                               g_obex_strerror(rspcode));
>                 goto failed;
>         }
>
> --
> 1.8.3.1

I went ahead and applied patches 1 and 3, for patch 2 I will wait for
feedback as the filler byte is something Bluetooth specific it can be
controversial.



-- 
Luiz Augusto von Dentz
