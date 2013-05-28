Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369674934-28204-1-git-send-email-hdante@profusion.mobi>
References: <1369674934-28204-1-git-send-email-hdante@profusion.mobi>
Date: Tue, 28 May 2013 06:23:53 -0700
Message-ID: <CABBYNZ+dWxJ=-Z62E_GVe2YeZr+YPRhy0n4bnx+L1vP1tyDZHw@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Remove proxies when client disconnects
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

On Mon, May 27, 2013 at 10:15 AM, Henrique Dante de Almeida
<hdante@profusion.mobi> wrote:
> Remove proxies and generate proxy_removed callbacks even when there are
> no corresponding InterfaceRemoved signals.
>
> This patch fixes having zombie gdbus proxy object when a server
> disconnects without sending InterfaceRemoved signals. These objects
> may interact with new server instances, for example, making
> InterfaceAdded signals of new objects with the same name be filtered
> out as duplicated, or staying allocated, but unused, if the new server
> doesn't reuse the object paths. Note that as a side-effect, the
> lifetime of a gdbus proxy becomes stricter: it lives at most for the
> duration of a single connection to a single instance of a server
> process.
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

Pushed, thanks.


--
Luiz Augusto von Dentz
