Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 29 Aug 2014 11:18:00 +0300
Message-ID: <CABBYNZJXj7TDEQ8nhDt8bwSZurZXnNxxPnpWGtpjP=aamCeUJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] obexd/client: Allow suspending transfer while
 they are queued
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 27, 2014 at 7:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Transfer may be created by different processes so it make sense to allow
> them to be suspended even if they are not active.
> ---
>  obexd/client/transfer.c | 47 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
> index bd2b1ab..0b5735b 100644
> --- a/obexd/client/transfer.c
> +++ b/obexd/client/transfer.c
> @@ -62,6 +62,7 @@ enum {
>         TRANSFER_STATUS_ACTIVE,
>         TRANSFER_STATUS_SUSPENDED,
>         TRANSFER_STATUS_COMPLETE,
> +       TRANSFER_STATUS_SUSPENDED_QUEUED,
>         TRANSFER_STATUS_ERROR
>  };
>
> @@ -213,6 +214,7 @@ static DBusMessage *obc_transfer_suspend(DBusConnection *connection,
>  {
>         struct obc_transfer *transfer = user_data;
>         const char *sender;
> +       uint8_t status;
>
>         sender = dbus_message_get_sender(message);
>         if (g_strcmp0(transfer->owner, sender) != 0)
> @@ -220,14 +222,22 @@ static DBusMessage *obc_transfer_suspend(DBusConnection *connection,
>                                 ERROR_INTERFACE ".NotAuthorized",
>                                 "Not Authorized");
>
> -       if (transfer->xfer == 0)
> +       switch (transfer->status) {
> +       case TRANSFER_STATUS_QUEUED:
> +               status = TRANSFER_STATUS_SUSPENDED_QUEUED;
> +               break;
> +       case TRANSFER_STATUS_ACTIVE:
> +               if (transfer->xfer)
> +                       g_obex_suspend(transfer->obex);
> +               status = TRANSFER_STATUS_SUSPENDED;
> +               break;
> +       default:
>                 return g_dbus_create_error(message,
>                                 ERROR_INTERFACE ".NotInProgress",
>                                 "Not in progress");
> +       }
>
> -       g_obex_suspend(transfer->obex);
> -
> -       transfer_set_status(transfer, TRANSFER_STATUS_SUSPENDED);
> +       transfer_set_status(transfer, status);
>
>         return g_dbus_create_reply(message, DBUS_TYPE_INVALID);
>  }
> @@ -237,6 +247,7 @@ static DBusMessage *obc_transfer_resume(DBusConnection *connection,
>  {
>         struct obc_transfer *transfer = user_data;
>         const char *sender;
> +       uint8_t status;
>
>         sender = dbus_message_get_sender(message);
>         if (g_strcmp0(transfer->owner, sender) != 0)
> @@ -244,14 +255,24 @@ static DBusMessage *obc_transfer_resume(DBusConnection *connection,
>                                 ERROR_INTERFACE ".NotAuthorized",
>                                 "Not Authorized");
>
> -       if (transfer->xfer == 0)
> +       switch (transfer->status) {
> +       case TRANSFER_STATUS_SUSPENDED_QUEUED:
> +               status = TRANSFER_STATUS_QUEUED;
> +               break;
> +       case TRANSFER_STATUS_SUSPENDED:
> +               if (transfer->xfer)
> +                       g_obex_resume(transfer->obex);
> +               else
> +                       obc_transfer_start(transfer, NULL, NULL);
> +               status = TRANSFER_STATUS_ACTIVE;
> +               break;
> +       default:
>                 return g_dbus_create_error(message,
>                                 ERROR_INTERFACE ".NotInProgress",
>                                 "Not in progress");
> +       }
>
> -       g_obex_resume(transfer->obex);
> -
> -       transfer_set_status(transfer, TRANSFER_STATUS_ACTIVE);
> +       transfer_set_status(transfer, status);
>
>         return g_dbus_create_reply(message, DBUS_TYPE_INVALID);
>  }
> @@ -338,6 +359,7 @@ static const char *status2str(uint8_t status)
>                 return "queued";
>         case TRANSFER_STATUS_ACTIVE:
>                 return "active";
> +       case TRANSFER_STATUS_SUSPENDED_QUEUED:
>         case TRANSFER_STATUS_SUSPENDED:
>                 return "suspended";
>         case TRANSFER_STATUS_COMPLETE:
> @@ -861,7 +883,14 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
>  gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
>                                                                 GError **err)
>  {
> -       transfer->obex = g_obex_ref(obex);
> +       if (!transfer->obex)
> +               transfer->obex = g_obex_ref(obex);
> +
> +       if (transfer->status == TRANSFER_STATUS_SUSPENDED_QUEUED) {
> +               /* Reset status so the transfer can be resumed */
> +               transfer->status = TRANSFER_STATUS_SUSPENDED;
> +               return TRUE;
> +       }
>
>         switch (transfer->op) {
>         case G_OBEX_OP_GET:
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
