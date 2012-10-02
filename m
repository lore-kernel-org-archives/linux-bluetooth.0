Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
References: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 2 Oct 2012 01:10:28 -0300
Message-ID: <CAMOw1v4RBGKBq2kxsGh=ki2hbk8zcbR30NMPv84L-ZRX3wV2KA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/10] gdbus: Fix not freeing list node by using g_slist_delete_link
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 1, 2012 at 2:53 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> g_slist_remove_link does not free the node which can cause leaks so
> replace that with g_slist_delete_link which does free memory properly.
> ---
>  gdbus/watch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index a402ca9..07feb61 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -574,7 +574,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
>                         continue;
>
>                 remove_match(data);
> -               listeners = g_slist_remove_link(listeners, l);
> +               listeners = g_slist_delete_link(listeners, l);
>
>                 filter_data_free(data);
>         }
> --

Ack,

Lucas De Marchi
