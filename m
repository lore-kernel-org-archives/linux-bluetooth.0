Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
References: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Feb 2018 08:24:34 -0200
Message-ID: <CABBYNZJGfBP5YoRx_phB-ayMpOx420fw4pQhR8Yy0N05hXnKwA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/4] obexd: Use emitting function wrapped for transfer
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Feb 9, 2018 at 7:10 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Also replaces emit_transfer_progress() with the new wrapper function
> because the total/transferred arguments have not been used since commit
> a5c2b6e8 ("obexd: Align client and server spec of org.bluez.obex.Transfer1")
> and g_dbus_emit_property_changed_full() checks if the path argument is
> NULL.
> ---
>  obexd/src/manager.c | 26 ++++++++++----------------
>  obexd/src/manager.h |  2 ++
>  2 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 70265e445..7ae8d7f83 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -533,12 +533,18 @@ void manager_cleanup(void)
>         dbus_connection_unref(connection);
>  }
>
> +void manager_emit_transfer_property(struct obex_transfer *transfer,
> +                                                               char *name)
> +{
> +       g_dbus_emit_property_changed(connection, transfer->path,
> +                                       TRANSFER_INTERFACE, name);
> +}

We better put a check if the transfer->path is not NULL, otherwise looks good.

>  void manager_emit_transfer_started(struct obex_transfer *transfer)
>  {
>         transfer->status = TRANSFER_STATUS_ACTIVE;
>
> -       g_dbus_emit_property_changed(connection, transfer->path,
> -                                       TRANSFER_INTERFACE, "Status");
> +       manager_emit_transfer_property(transfer, "Status");
>  }
>
>  static void emit_transfer_completed(struct obex_transfer *transfer,
> @@ -550,18 +556,7 @@ static void emit_transfer_completed(struct obex_transfer *transfer,
>         transfer->status = success ? TRANSFER_STATUS_COMPLETE :
>                                                 TRANSFER_STATUS_ERROR;
>
> -       g_dbus_emit_property_changed(connection, transfer->path,
> -                                       TRANSFER_INTERFACE, "Status");
> -}
> -
> -static void emit_transfer_progress(struct obex_transfer *transfer,
> -                                       uint32_t total, uint32_t transferred)
> -{
> -       if (transfer->path == NULL)
> -               return;
> -
> -       g_dbus_emit_property_changed(connection, transfer->path,
> -                                       TRANSFER_INTERFACE, "Transferred");
> +       manager_emit_transfer_property(transfer, "Status");
>  }
>
>  static void transfer_free(struct obex_transfer *transfer)
> @@ -783,8 +778,7 @@ void manager_unregister_session(struct obex_session *os)
>
>  void manager_emit_transfer_progress(struct obex_transfer *transfer)
>  {
> -       emit_transfer_progress(transfer, transfer->session->size,
> -                                               transfer->session->offset);
> +       manager_emit_transfer_property(transfer, "Transferred");
>  }
>
>  void manager_emit_transfer_completed(struct obex_transfer *transfer)
> diff --git a/obexd/src/manager.h b/obexd/src/manager.h
> index d9781b201..d709af5a8 100644
> --- a/obexd/src/manager.h
> +++ b/obexd/src/manager.h
> @@ -33,6 +33,8 @@ void manager_unregister_session(struct obex_session *os);
>
>  struct obex_transfer *manager_register_transfer(struct obex_session *os);
>  void manager_unregister_transfer(struct obex_transfer *transfer);
> +void manager_emit_transfer_property(struct obex_transfer *transfer,
> +                                                               char *name);
>  void manager_emit_transfer_started(struct obex_transfer *transfer);
>  void manager_emit_transfer_progress(struct obex_transfer *transfer);
>  void manager_emit_transfer_completed(struct obex_transfer *transfer);
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
