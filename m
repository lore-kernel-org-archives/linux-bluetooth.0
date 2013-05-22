Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369259474-19536-1-git-send-email-hdante@profusion.mobi>
References: <1369259474-19536-1-git-send-email-hdante@profusion.mobi>
Date: Wed, 22 May 2013 18:52:27 -0300
Message-ID: <CAFAvTnNgKg_1h+QVnuRmPq0p_+13n1de7qaVbdcnmg1ftCNF3A@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Remove proxies when client disconnects
From: Henrique Dante <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 22, 2013 at 6:51 PM, Henrique Dante de Almeida
<hdante@profusion.mobi> wrote:
> Remove proxies and generate proxy_removed callbacks even when there are
> no corresponding InterfaceRemoved signals.
>
> Change-Id: I4fe534cd152f98db00d3462f4d7eaaa41b69bdf3

 gerrit hook, sending again

> ---
>  gdbus/client.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index f700b7e..d80e252 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -1153,6 +1153,10 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>
>                 if (*new == '\0' && client->unique_name != NULL &&
>                                 g_str_equal(old, client->unique_name) == TRUE) {
> +
> +                       g_list_free_full(client->proxy_list, proxy_free);
> +                       client->proxy_list = NULL;
> +
>                         if (client->disconn_func)
>                                 client->disconn_func(client->dbus_conn,
>                                                         client->disconn_data);
> --
> 1.8.2.3
>
