Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334668699-18194-1-git-send-email-luiz.dentz@gmail.com>
References: <1334668699-18194-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 17 Apr 2012 15:51:47 +0200
Message-ID: <CANT-zCUwerRVk4YJ2E58B8p-YvO2qUhBRV=WbMTp+o9Nz3_WEQ@mail.gmail.com>
Subject: Re: [PATCH obexd v2] client: Remove buffer based transfer
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Apr 17, 2012 at 3:18 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Simplify the code by using temporary files and eliminates reallocations.
> ---
> v2: Remove DEFAULT_BUFFER_SIZE define
>
>  client/ftp.c      |    8 +-
>  client/manager.c  |   18 +++-
>  client/map.c      |    9 +-
>  client/pbap.c     |   43 ++++++---
>  client/session.c  |   60 +++++++++----
>  client/session.h  |    5 +-
>  client/sync.c     |   35 +++++---
>  client/transfer.c |  247 +++++++++++++++++------------------------------------

Would it be possible to split this cleanup in transfer.c into a separate patch?

>  client/transfer.h |    5 +-
>  9 files changed, 202 insertions(+), 228 deletions(-)
>
> diff --git a/client/ftp.c b/client/ftp.c
> index 9be5d69..f415f2f 100644
> --- a/client/ftp.c
> +++ b/client/ftp.c
> @@ -196,13 +196,12 @@ static void list_folder_callback(struct obc_session *session,
>        GMarkupParseContext *ctxt;
>        DBusMessage *reply;
>        DBusMessageIter iter, array;
> -       const char *buf;
> +       char *contents;
>        size_t size;
>
>        reply = dbus_message_new_method_return(msg);
>
> -       buf = obc_session_get_buffer(session, &size);
> -       if (size == 0)
> +       if (obc_session_get_contents(session, &contents, &size) < 0)
>                goto done;
>
>        dbus_message_iter_init_append(reply, &iter);
> @@ -212,9 +211,10 @@ static void list_folder_callback(struct obc_session *session,
>                        DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
>                        DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
>        ctxt = g_markup_parse_context_new(&parser, 0, &array, NULL);
> -       g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
> +       g_markup_parse_context_parse(ctxt, contents, size, NULL);

Is this exactly equivalent or are we fixing a bug here?

>        g_markup_parse_context_free(ctxt);
>        dbus_message_iter_close_container(&iter, &array);
> +       g_free(contents);
>
>  done:
>        g_dbus_send_message(conn, reply);
> diff --git a/client/manager.c b/client/manager.c
> index 2e01e54..4f0b750 100644
> --- a/client/manager.c
> +++ b/client/manager.c
> @@ -442,8 +442,9 @@ static void capabilities_complete_callback(struct obc_session *session,
>                                                GError *err, void *user_data)
>  {
>        struct send_data *data = user_data;
> -       const char *capabilities;
> +       char *contents;
>        size_t size;
> +       int perr;
>
>        if (err != NULL) {
>                DBusMessage *error = g_dbus_create_error(data->message,
> @@ -453,13 +454,20 @@ static void capabilities_complete_callback(struct obc_session *session,
>                goto done;
>        }
>
> -       capabilities = obc_session_get_buffer(session, &size);
> -       if (size == 0)
> -               capabilities = "";
> +       perr = obc_session_get_contents(session, &contents, &size);

I propose we rename this function to obc_session_read_contents(). This
makes it clearer what's going on, and it's less confusing when you
free the memory some lines later.

> +       if (perr < 0) {
> +               DBusMessage *error = g_dbus_create_error(data->message,
> +                                               "org.openobex.Error.Failed",
> +                                               "Error reading contents: %s",
> +                                               strerror(-perr));
> +               g_dbus_send_message(data->connection, error);
> +               goto done;
> +       }
>
>        g_dbus_send_reply(data->connection, data->message,
> -                       DBUS_TYPE_STRING, &capabilities,
> +                       DBUS_TYPE_STRING, &contents,
>                        DBUS_TYPE_INVALID);
> +       g_free(contents);
>
>  done:
>
> diff --git a/client/map.c b/client/map.c
> index 68b1fbc..fe4ea4b 100644
> --- a/client/map.c
> +++ b/client/map.c
> @@ -98,7 +98,7 @@ static void buffer_cb(struct obc_session *session, GError *err,
>  {
>        struct map_data *map = user_data;
>        DBusMessage *reply;
> -       const char *buf;
> +       char *contents;
>        size_t size;
>
>        if (err != NULL) {
> @@ -108,13 +108,12 @@ static void buffer_cb(struct obc_session *session, GError *err,
>                goto done;
>        }
>
> -       buf = obc_session_get_buffer(session, &size);
> -       if (size == 0)
> -               buf = "";
> +       obc_session_get_contents(session, &contents, &size);

We need to check for errors here.

>
> -       reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &buf,
> +       reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &contents,
>                                                        DBUS_TYPE_INVALID);
>
> +       g_free(contents);
>  done:
>        g_dbus_send_message(conn, reply);
>        dbus_message_unref(map->msg);
> diff --git a/client/pbap.c b/client/pbap.c
> index 53a608e..3084dd9 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -343,8 +343,9 @@ static void pull_phonebook_callback(struct obc_session *session,
>  {
>        struct pending_request *request = user_data;
>        DBusMessage *reply;
> -       const char *buf;
> +       char *contents;
>        size_t size;
> +       int perr;
>
>        if (err) {
>                reply = g_dbus_create_error(request->msg,
> @@ -353,16 +354,23 @@ static void pull_phonebook_callback(struct obc_session *session,
>                goto send;
>        }
>
> -       reply = dbus_message_new_method_return(request->msg);
> +       perr = obc_session_get_contents(session, &contents, &size);
> +       if (perr < 0) {
> +               reply = g_dbus_create_error(request->msg,
> +                                               "org.openobex.Error.Failed",
> +                                               "Error reading contents: %s",
> +                                               strerror(-perr));
> +               goto send;
> +       }
>
> -       buf = obc_session_get_buffer(session, &size);
> -       if (size == 0)
> -               buf = "";
> +       reply = dbus_message_new_method_return(request->msg);
>
>        dbus_message_append_args(reply,
> -                       DBUS_TYPE_STRING, &buf,
> +                       DBUS_TYPE_STRING, &contents,
>                        DBUS_TYPE_INVALID);
>
> +       g_free(contents);
> +
>  send:
>        g_dbus_send_message(conn, reply);
>        pending_request_free(request);
> @@ -403,8 +411,9 @@ static void pull_vcard_listing_callback(struct obc_session *session,
>        GMarkupParseContext *ctxt;
>        DBusMessage *reply;
>        DBusMessageIter iter, array;
> -       const char *buf;
> +       char *contents;
>        size_t size;
> +       int perr;
>
>        if (err) {
>                reply = g_dbus_create_error(request->msg,
> @@ -413,11 +422,16 @@ static void pull_vcard_listing_callback(struct obc_session *session,
>                goto send;
>        }
>
> -       reply = dbus_message_new_method_return(request->msg);
> +       perr = obc_session_get_contents(session, &contents, &size);
> +       if (perr < 0) {
> +               reply = g_dbus_create_error(request->msg,
> +                                               "org.openobex.Error.Failed",
> +                                               "Error reading contents: %s",
> +                                               strerror(-perr));
> +               goto send;
> +       }
>
> -       buf = obc_session_get_buffer(session, &size);
> -       if (size == 0)
> -               buf = "";
> +       reply = dbus_message_new_method_return(request->msg);
>
>        dbus_message_iter_init_append(reply, &iter);
>        dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> @@ -425,9 +439,10 @@ static void pull_vcard_listing_callback(struct obc_session *session,
>                        DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_STRING_AS_STRING
>                        DBUS_STRUCT_END_CHAR_AS_STRING, &array);
>        ctxt = g_markup_parse_context_new(&listing_parser, 0, &array, NULL);
> -       g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
> +       g_markup_parse_context_parse(ctxt, contents, size, NULL);

Same as pointed out previously: is this equivalent?

>        g_markup_parse_context_free(ctxt);
>        dbus_message_iter_close_container(&iter, &array);
> +       g_free(contents);
>
>  send:
>        g_dbus_send_message(conn, reply);
> @@ -775,7 +790,7 @@ static DBusMessage *pbap_list(DBusConnection *connection,
>                return g_dbus_create_error(message,
>                                ERROR_INF ".Forbidden", "Call Select first of all");
>
> -       return pull_vcard_listing(pbap, message, "", pbap->order, "",
> +       return pull_vcard_listing(pbap, message, NULL, pbap->order, "",
>                                ATTRIB_NAME, DEFAULT_COUNT, DEFAULT_OFFSET);

How does this change relate to the patch?

>  }
>
> @@ -809,7 +824,7 @@ static DBusMessage *pbap_search(DBusConnection *connection,
>                return g_dbus_create_error(message,
>                                ERROR_INF ".InvalidArguments", NULL);
>
> -       return pull_vcard_listing(pbap, message, "", pbap->order, value,
> +       return pull_vcard_listing(pbap, message, NULL, pbap->order, value,
>                                        attrib, DEFAULT_COUNT, DEFAULT_OFFSET);

Same here.

>  }
>
> diff --git a/client/session.c b/client/session.c
> index 868eb9f..0ff7e0a 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -25,6 +25,8 @@
>  #include <config.h>
>  #endif
>
> +#include <stdlib.h>
> +#include <stdio.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -1059,31 +1061,59 @@ static void session_prepare_put(gpointer data, gpointer user_data)
>        DBG("Transfer(%p) started", transfer);
>  }
>
> -int obc_session_put(struct obc_session *session, char *buf, const char *name)
> +int obc_session_put(struct obc_session *session, const char *buf, const char *name)
>  {
> +       char tmpname[] = { '/', 't', 'm', 'p', '/', 'o', 'b', 'e', 'x', '-',
> +                       'c', 'l', 'i', 'e', 'n', 't', 'X', 'X', 'X', 'X', 'X',
> +                       'X', '\0' };

Is this a common approach? I would rather g_strdup from a #define.

>        struct obc_transfer *transfer;
>        const char *agent;
> +       int fd, err;
>
> -       if (session->obex == NULL) {
> -               g_free(buf);
> +       if (session->obex == NULL)
>                return -ENOTCONN;
> +
> +       fd = mkstemp(tmpname);
> +       if (fd < 0) {
> +               error("mkstemp(): %s(%d)", strerror(errno), errno);
> +               return -errno;
> +       }

Can't we move this whole temporary-file creating code to transfer.c? I
would propose that, if an empty name is given to a transfer, it
automatically creates a file. Otherwise we have code duplication.

Furthermore, the "empty name" approach can also be exposed in the
upcoming D-Bus API. Many clients would not care about the name of the
destination file, for example when doing PBAP.

> +
> +       err = write(fd, buf, strlen(buf));
> +       if (err < 0) {
> +               error("write(): %s(%d)", strerror(errno), errno);
> +               err = -errno;
> +               goto done;
>        }
>
>        agent = obc_agent_get_name(session->agent);
>
>        transfer = obc_transfer_register(session->conn, session->obex,
> -                                                       agent, NULL,
> +                                                       agent, tmpname,
>                                                        name, NULL,
>                                                        NULL);
>        if (transfer == NULL) {
> -               g_free(buf);
> -               return -EIO;
> +               err = -EIO;
> +               goto done;
>        }
>
> -       obc_transfer_set_buffer(transfer, buf);
> +       err = obc_transfer_set_file(transfer);
> +       if (err < 0) {
> +               obc_transfer_unregister(transfer);
> +               goto done;
> +       }
>
> -       return session_request(session, transfer, session_prepare_put,
> -                                                               NULL, NULL);
> +       err = session_request(session, transfer, session_prepare_put, NULL,
> +                                                                       NULL);
> +       if (err < 0) {
> +               obc_transfer_unregister(transfer);
> +               goto done;
> +       }
> +
> +done:
> +       close(fd);
> +       remove(tmpname);
> +       return err;
>  }
>
>  static void agent_destroy(gpointer data, gpointer user_data)
> @@ -1156,24 +1186,20 @@ static struct obc_transfer *obc_session_get_transfer(
>        return session->p->transfer;
>  }
>
> -const char *obc_session_get_buffer(struct obc_session *session, size_t *size)
> +int obc_session_get_contents(struct obc_session *session, char **contents,
> +                                                               size_t *size)
>  {
>        struct obc_transfer *transfer;
> -       const char *buf;
>
>        transfer = obc_session_get_transfer(session);
>        if (transfer == NULL) {
>                if (size != NULL)
>                        *size = 0;
>
> -               return NULL;
> +               return -EINVAL;
>        }
>
> -       buf = obc_transfer_get_buffer(transfer, size);
> -
> -       obc_transfer_clear_buffer(transfer);
> -
> -       return buf;
> +       return obc_transfer_get_contents(transfer, contents, size);

Same as before, I would rename the function to obc_transfer_read_contents().

<snip>

>
> -void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer)
> -{
> -       transfer->size = strlen(buffer);
> -       transfer->buffer = buffer;
> +       if (lseek(transfer->fd, 0, SEEK_SET) < 0) {
> +               error("lseek(): %s(%d)", strerror(errno), errno);
> +               return -errno;
> +       }
> +
> +       *contents = g_malloc0(st.st_size + 1);

Better use g_malloc instead and then manually add the final 0. Why
waste CPU cycles.

> +
> +       if (read(transfer->fd, *contents, st.st_size) < 0) {
> +               error("read(): %s(%d)", strerror(errno), errno);
> +               g_free(*contents);
> +               return -errno;
> +       }

It would be safer to check if all bytes have been read.

> +
> +       if (size)
> +               *size = st.st_size;
> +
> +       return 0;
>  }
>
>  void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
> diff --git a/client/transfer.h b/client/transfer.h
> index da7d151..7759296 100644
> --- a/client/transfer.h
> +++ b/client/transfer.h
> @@ -51,9 +51,8 @@ int obc_transfer_put(struct obc_transfer *transfer);
>
>  int obc_transfer_get_params(struct obc_transfer *transfer,
>                                        struct obc_transfer_params *params);
> -const char *obc_transfer_get_buffer(struct obc_transfer *transfer, size_t *size);
> -void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
> -void obc_transfer_clear_buffer(struct obc_transfer *transfer);
> +int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
> +                                                               gsize *size);

We should use size_t here instead of gsize, to be consistent with
obc_session_get_contents().

Cheers,
Mikel
