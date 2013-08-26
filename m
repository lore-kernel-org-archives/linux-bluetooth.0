Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1377187721-3758-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1377187721-3758-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1377187721-3758-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Mon, 26 Aug 2013 15:08:09 +0300
Message-ID: <CABBYNZ+5viOEhXeaGzvO7ZtjCaNrxeFX+c01eqbyURg2_XAdZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] obexd: Add property changed signals for 'org.bluez.obex.Message1'
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Thu, Aug 22, 2013 at 7:08 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This patch adds property changed signal emissions in case message properties
> change on the server.
> ---
>  obexd/client/map.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 8864a54..a9a9bcd 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -792,121 +792,211 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
>
>  static void parse_subject(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->subject, value) == 0)
> +               return;
> +
>         g_free(msg->subject);
>         msg->subject = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Subject");
>  }
>
>  static void parse_datetime(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->timestamp, value) == 0)
> +               return;
> +
>         g_free(msg->timestamp);
>         msg->timestamp = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Timestamp");
>  }
>
>  static void parse_sender(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->sender, value) == 0)
> +               return;
> +
>         g_free(msg->sender);
>         msg->sender = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Sender");
>  }
>
>  static void parse_sender_address(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->sender_address, value) == 0)
> +               return;
> +
>         g_free(msg->sender_address);
>         msg->sender_address = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                       MAP_MSG_INTERFACE, "SenderAddress");
>  }
>
>  static void parse_replyto(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->replyto, value) == 0)
> +               return;
> +
>         g_free(msg->replyto);
>         msg->replyto = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "ReplyTo");
>  }
>
>  static void parse_recipient(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->recipient, value) == 0)
> +               return;
> +
>         g_free(msg->recipient);
>         msg->recipient = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Recipient");
>  }
>
>  static void parse_recipient_address(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->recipient_address, value) == 0)
> +               return;
> +
>         g_free(msg->recipient_address);
>         msg->recipient_address = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                       MAP_MSG_INTERFACE, "RecipientAddress");
>  }
>
>  static void parse_type(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->type, value) == 0)
> +               return;
> +
>         g_free(msg->type);
>         msg->type = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Type");
>  }
>
>  static void parse_size(struct map_msg *msg, const char *value)
>  {
> -       msg->size = g_ascii_strtoll(value, NULL, 10);
> +       uint64_t size = g_ascii_strtoll(value, NULL, 10);
> +
> +       if (msg->size == size)
> +               return;
> +
> +       msg->size = size;
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Size");
>  }
>
>  static void parse_text(struct map_msg *msg, const char *value)
>  {
>         gboolean flag = strcasecmp(value, "no") != 0;
>
> +       uint8_t oldflags = msg->flags;
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_TEXT;
>         else
>                 msg->flags &= ~MAP_MSG_FLAG_TEXT;
>
> +       if (msg->flags != oldflags)
> +               g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Text");
>  }
>
>  static void parse_status(struct map_msg *msg, const char *value)
>  {
> +       if (g_strcmp0(msg->status, value) == 0)
> +               return;
> +
>         g_free(msg->status);
>         msg->status = g_strdup(value);
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Status");
>  }
>
>  static void parse_attachment_size(struct map_msg *msg, const char *value)
>  {
> -       msg->attachment_size = g_ascii_strtoll(value, NULL, 10);
> +       uint64_t attachment_size = g_ascii_strtoll(value, NULL, 10);
> +
> +       if (msg->attachment_size == attachment_size)
> +               return;
> +
> +       msg->attachment_size = attachment_size;
> +
> +       g_dbus_emit_property_changed(conn, msg->path,
> +                                       MAP_MSG_INTERFACE, "AttachmentSize");
>  }
>
>  static void parse_priority(struct map_msg *msg, const char *value)
>  {
>         gboolean flag = strcasecmp(value, "no") != 0;
>
> +       uint8_t oldflags = msg->flags;
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_PRIORITY;
>         else
>                 msg->flags &= ~MAP_MSG_FLAG_PRIORITY;
>
> +       if (msg->flags != oldflags)
> +               g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Priority");
>  }
>
>  static void parse_read(struct map_msg *msg, const char *value)
>  {
>         gboolean flag = strcasecmp(value, "no") != 0;
>
> +       uint8_t oldflags = msg->flags;
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_READ;
>         else
>                 msg->flags &= ~MAP_MSG_FLAG_READ;
>
> +       if (msg->flags != oldflags)
> +               g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Read");
>  }
>
>  static void parse_sent(struct map_msg *msg, const char *value)
>  {
>         gboolean flag = strcasecmp(value, "no") != 0;
>
> +       uint8_t oldflags = msg->flags;
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_SENT;
>         else
>                 msg->flags &= ~MAP_MSG_FLAG_SENT;
>
> +       if (msg->flags != oldflags)
> +               g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Sent");
>  }
>
>  static void parse_protected(struct map_msg *msg, const char *value)
>  {
>         gboolean flag = strcasecmp(value, "no") != 0;
>
> +       uint8_t oldflags = msg->flags;
>         if (flag)
>                 msg->flags |= MAP_MSG_FLAG_PROTECTED;
>         else
>                 msg->flags &= ~MAP_MSG_FLAG_PROTECTED;
>
> +       if (msg->flags != oldflags)
> +               g_dbus_emit_property_changed(conn, msg->path,
> +                                               MAP_MSG_INTERFACE, "Protected");
>  }
>
>  static struct map_msg_parser {
> --
> 1.8.3.4

Does this make us emit signals when creating the objects? That should
probably not be necessary, only emit signals once the value really
changes.


-- 
Luiz Augusto von Dentz
