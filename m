Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313698203-13201-4-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-2-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-3-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-4-git-send-email-padovan@profusion.mobi>
Date: Fri, 19 Aug 2011 10:20:17 +0300
Message-ID: <CABBYNZJtkjoP3mJF8mpswCMqu1JgzuLxw68VLAzZXaCFBRNkeQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] serial: Add port->sender
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Aug 18, 2011 at 11:10 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>
> Now that port->msg is freed we need a field to track the owner of the
> rfcomm connection.
> ---
>  serial/port.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/serial/port.c b/serial/port.c
> index bc4b4ea..784febd 100644
> --- a/serial/port.c
> +++ b/serial/port.c
> @@ -85,6 +85,7 @@ struct serial_port {
>        GIOChannel      *io;            /* BtIO channel */
>        guint           listener_id;
>        gboolean        fd_passing;
> +       char            *sender;
>        struct serial_device *device;
>  };
>
> @@ -210,6 +211,7 @@ static void serial_port_free(void *data)
>        }
>
>        g_free(port->uuid);
> +       g_free(port->sender);
>        g_free(port);
>  }
>
> @@ -235,6 +237,7 @@ static void port_owner_exited(DBusConnection *conn, void *user_data)
>        }
>
>        port->listener_id = 0;
> +       g_free(port->sender);
>  }
>
>  static void path_unregister(void *data)
> @@ -386,6 +389,8 @@ fail:
>        port->msg = NULL;
>        g_dbus_remove_watch(device->conn, port->listener_id);
>        port->listener_id = 0;
> +       g_free(port->sender);
> +       port->sender = NULL;
>  }
>
>  static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
> @@ -531,6 +536,7 @@ static DBusMessage *_port_connect(DBusConnection *conn, DBusMessage *msg,
>                                                port_owner_exited, port,
>                                                NULL);
>        port->msg = dbus_message_ref(msg);
> +       port->sender = g_strdup(dbus_message_get_sender(port->msg));
>
>        if (fd)
>                port->fd_passing = TRUE;
> @@ -567,7 +573,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
>  {
>        struct serial_device *device = user_data;
>        struct serial_port *port;
> -       const char *dev, *owner, *caller;
> +       const char *dev, *caller;
>
>        if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &dev,
>                                                DBUS_TYPE_INVALID) == FALSE)
> @@ -580,15 +586,16 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
>        if (!port->listener_id)
>                return btd_error_not_connected(msg);
>
> -       owner = dbus_message_get_sender(port->msg);
>        caller = dbus_message_get_sender(msg);
> -       if (!g_str_equal(owner, caller))
> +       if (!g_str_equal(port->sender, caller))
>                return btd_error_not_authorized(msg);
>
>        port_release(port);
>
>        g_dbus_remove_watch(conn, port->listener_id);
>        port->listener_id = 0;
> +       g_free(port->sender);
> +       port->sender = NULL;
>
>        return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
> --
> 1.7.6

So port->msg wasn't leaking, well it was when we do port_free, we use
it for checking the sender, what you probably want to do is to remove
the need of port->msg by just storing its sender, in this case I would
merge the patches so we don't break the code while doing the change.

-- 
Luiz Augusto von Dentz
