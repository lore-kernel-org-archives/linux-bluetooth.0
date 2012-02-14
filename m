Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329143945-4934-6-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329143945-4934-6-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 14 Feb 2012 11:24:55 +0200
Message-ID: <CABBYNZKtLn1gSbxrxuCcwHh6BVw=5RnZ+3VDqm_J94OCC3ZpWQ@mail.gmail.com>
Subject: Re: [PATCH obexd 6/6] client: queue transfers in pbap sessions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 13, 2012 at 4:39 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Previous implementation reported busy when trying to queue several
> operations in the same session.
> ---
>  client/pbap.c |  127 +++++++++++++++++++++++++++++---------------------------
>  1 files changed, 66 insertions(+), 61 deletions(-)
>
> diff --git a/client/pbap.c b/client/pbap.c
> index c4b14a2..eed7fa6 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -127,12 +127,16 @@ static const char *filter_list[] = {
>  struct pbap_data {
>        struct obc_session *session;
>        char *path;
> -       DBusMessage *msg;
>        guint8 format;
>        guint8 order;
>        uint64_t filter;
>  };
>
> +struct pending_request {
> +       struct pbap_data *pbap;
> +       DBusMessage *msg;
> +};
> +
>  struct pullphonebook_apparam {
>        uint8_t     filter_tag;
>        uint8_t     filter_len;
> @@ -167,6 +171,24 @@ struct apparam_hdr {
>
>  static DBusConnection *conn = NULL;
>
> +struct pending_request *pending_request_new(struct pbap_data *pbap,
> +                                               DBusMessage *message)
> +{
> +       struct pending_request *p;
> +
> +       p = g_new0(struct pending_request, 1);
> +       p->pbap = pbap;
> +       p->msg = dbus_message_ref(message);
> +
> +       return p;
> +}
> +
> +static void pending_request_free(struct pending_request *p)
> +{
> +       dbus_message_unref(p->msg);
> +       g_free(p);
> +}
> +
>  static void listing_element(GMarkupParseContext *ctxt,
>                                const gchar *element,
>                                const gchar **names,
> @@ -252,24 +274,21 @@ static void pbap_reset_path(struct pbap_data *pbap)
>  static void pbap_setpath_cb(struct obc_session *session, GError *err,
>                                                        gpointer user_data)
>  {
> -       struct pbap_data *pbap = user_data;
> +       struct pending_request *request = user_data;
> +       struct pbap_data *pbap = request->pbap;
>
>        if (err != NULL)
> -               pbap_reset_path(user_data);
> -
> -       if (pbap->msg == NULL)
> -               return;
> +               pbap_reset_path(pbap);
>
>        if (err) {
> -               DBusMessage *reply= g_dbus_create_error(pbap->msg,
> +               DBusMessage *reply = g_dbus_create_error(request->msg,
>                                                        ERROR_INF ".Failed",
>                                                        "%s", err->message);
>                g_dbus_send_message(conn, reply);
>        } else
> -               g_dbus_send_reply(conn, pbap->msg, DBUS_TYPE_INVALID);
> +               g_dbus_send_reply(conn, request->msg, DBUS_TYPE_INVALID);
>
> -       dbus_message_unref(pbap->msg);
> -       pbap->msg = NULL;
> +       pending_request_free(request);
>  }
>
>  static void read_return_apparam(struct obc_session *session,
> @@ -322,22 +341,19 @@ static void read_return_apparam(struct obc_session *session,
>  static void pull_phonebook_callback(struct obc_session *session,
>                                        GError *err, void *user_data)
>  {
> -       struct pbap_data *pbap = user_data;
> +       struct pending_request *request = user_data;
>        DBusMessage *reply;
>        const char *buf;
>        size_t size;
>
> -       if (pbap->msg == NULL)
> -               return;
> -
>        if (err) {
> -               reply = g_dbus_create_error(pbap->msg,
> +               reply = g_dbus_create_error(request->msg,
>                                                "org.openobex.Error.Failed",
>                                                "%s", err->message);
>                goto send;
>        }
>
> -       reply = dbus_message_new_method_return(pbap->msg);
> +       reply = dbus_message_new_method_return(request->msg);
>
>        buf = obc_session_get_buffer(session, &size);
>        if (size == 0)
> @@ -349,29 +365,25 @@ static void pull_phonebook_callback(struct obc_session *session,
>
>  send:
>        g_dbus_send_message(conn, reply);
> -       dbus_message_unref(pbap->msg);
> -       pbap->msg = NULL;
> +       pending_request_free(request);
>  }
>
>  static void phonebook_size_callback(struct obc_session *session,
>                                        GError *err, void *user_data)
>  {
> -       struct pbap_data *pbap = user_data;
> +       struct pending_request *request = user_data;
>        DBusMessage *reply;
>        guint16 phone_book_size;
>        guint8 new_missed_calls;
>
> -       if (pbap->msg == NULL)
> -               return;
> -
>        if (err) {
> -               reply = g_dbus_create_error(pbap->msg,
> +               reply = g_dbus_create_error(request->msg,
>                                                "org.openobex.Error.Failed",
>                                                "%s", err->message);
>                goto send;
>        }
>
> -       reply = dbus_message_new_method_return(pbap->msg);
> +       reply = dbus_message_new_method_return(request->msg);
>
>        read_return_apparam(session, &phone_book_size, &new_missed_calls);
>
> @@ -381,31 +393,27 @@ static void phonebook_size_callback(struct obc_session *session,
>
>  send:
>        g_dbus_send_message(conn, reply);
> -       dbus_message_unref(pbap->msg);
> -       pbap->msg = NULL;
> +       pending_request_free(request);
>  }
>
>  static void pull_vcard_listing_callback(struct obc_session *session,
>                                        GError *err, void *user_data)
>  {
> -       struct pbap_data *pbap = user_data;
> +       struct pending_request *request = user_data;
>        GMarkupParseContext *ctxt;
>        DBusMessage *reply;
>        DBusMessageIter iter, array;
>        const char *buf;
>        size_t size;
>
> -       if (pbap->msg == NULL)
> -               return;
> -
>        if (err) {
> -               reply = g_dbus_create_error(pbap->msg,
> +               reply = g_dbus_create_error(request->msg,
>                                                "org.openobex.Error.Failed",
>                                                "%s", err->message);
>                goto send;
>        }
>
> -       reply = dbus_message_new_method_return(pbap->msg);
> +       reply = dbus_message_new_method_return(request->msg);
>
>        buf = obc_session_get_buffer(session, &size);
>        if (size == 0)
> @@ -423,8 +431,7 @@ static void pull_vcard_listing_callback(struct obc_session *session,
>
>  send:
>        g_dbus_send_message(conn, reply);
> -       dbus_message_unref(pbap->msg);
> -       pbap->msg = NULL;
> +       pending_request_free(request);
>  }
>
>  static DBusMessage *pull_phonebook(struct pbap_data *pbap,
> @@ -433,14 +440,10 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
>                                        guint8 format, guint16 maxlistcount,
>                                        guint16 liststartoffset)
>  {
> +       struct pending_request *request;
>        struct pullphonebook_apparam apparam;
>        session_callback_t func;
>
> -       if (pbap->msg)
> -               return g_dbus_create_error(message,
> -                               "org.openobex.Error.InProgress",
> -                               "Transfer in progress");
> -
>        apparam.filter_tag = FILTER_TAG;
>        apparam.filter_len = FILTER_LEN;
>        apparam.filter = GUINT64_TO_BE(filter);
> @@ -466,14 +469,16 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
>                return NULL;
>        }
>
> +       request = pending_request_new(pbap, message);
> +
>        if (obc_session_get(pbap->session, "x-bt/phonebook", name, NULL,
>                                (guint8 *) &apparam, sizeof(apparam),
> -                               func, pbap) < 0)
> +                               func, request) < 0) {
> +               pending_request_free(request);
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.Failed",
>                                "Failed");
> -
> -       pbap->msg = dbus_message_ref(message);
> +       }
>
>        return NULL;
>  }
> @@ -495,15 +500,11 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
>                                        guint8 order, char *searchval, guint8 attrib,
>                                        guint16 count, guint16 offset)
>  {
> +       struct pending_request *request;
>        guint8 *p, *apparam = NULL;
>        gint apparam_size;
>        int err;
>
> -       if (pbap->msg)
> -               return g_dbus_create_error(message,
> -                               "org.openobex.Error.InProgress",
> -                               "Transfer in progress");
> -
>        /* trunc the searchval string if it's length exceed the max value of guint8 */
>        if (strlen(searchval) > 254)
>                searchval[255] = '\0';
> @@ -530,16 +531,18 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
>        offset = GUINT16_TO_BE(offset);
>        p = fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
>
> +       request = pending_request_new(pbap, message);
> +
>        err = obc_session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
>                                apparam, apparam_size,
> -                               pull_vcard_listing_callback, pbap);
> +                               pull_vcard_listing_callback, request);
>        g_free(apparam);
> -       if (err < 0)
> +       if (err < 0) {
> +               pending_request_free(request);
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.Failed",
>                                "Failed");
> -
> -       pbap->msg = dbus_message_ref(message);
> +       }
>
>        return NULL;
>  }
> @@ -663,6 +666,7 @@ static DBusMessage *pbap_select(DBusConnection *connection,
>        struct pbap_data *pbap = user_data;
>        const char *item, *location;
>        char *path;
> +       struct pending_request *request;
>        GError *err = NULL;
>
>        if (dbus_message_get_args(message, NULL,
> @@ -682,19 +686,22 @@ static DBusMessage *pbap_select(DBusConnection *connection,
>                return dbus_message_new_method_return(message);
>        }
>
> -       obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, &err);
> +       request = pending_request_new(pbap, message);
> +
> +       obc_session_setpath(pbap->session, path, pbap_setpath_cb, request,
> +                                                                       &err);
>        if (err != NULL) {
>                DBusMessage *reply;
>                reply =  g_dbus_create_error(message, ERROR_INF ".Failed",
>                                                        "%s", err->message);
>                g_error_free(err);
>                g_free(path);
> +               pending_request_free(request);
>                return reply;
>        }
>
>        g_free(pbap->path);
>        pbap->path = path;
> -       pbap->msg = dbus_message_ref(message);
>
>        return NULL;
>  }
> @@ -725,6 +732,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
>        struct pbap_data *pbap = user_data;
>        struct pullvcardentry_apparam apparam;
>        const char *name;
> +       struct pending_request *request;
>
>        if (!pbap->path)
>                return g_dbus_create_error(message,
> @@ -737,11 +745,6 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
>                return g_dbus_create_error(message,
>                                ERROR_INF ".InvalidArguments", NULL);
>
> -       if (pbap->msg)
> -               return g_dbus_create_error(message,
> -                               "org.openobex.Error.InProgress",
> -                               "Transfer in progress");
> -
>        apparam.filter_tag = FILTER_TAG;
>        apparam.filter_len = FILTER_LEN;
>        apparam.filter = GUINT64_TO_BE(pbap->filter);
> @@ -749,14 +752,16 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
>        apparam.format_len = FORMAT_LEN;
>        apparam.format = pbap->format;
>
> +       request = pending_request_new(pbap, message);
> +
>        if (obc_session_get(pbap->session, "x-bt/vcard", name, NULL,
>                        (guint8 *)&apparam, sizeof(apparam),
> -                       pull_phonebook_callback, pbap) < 0)
> +                       pull_phonebook_callback, request) < 0) {
> +               pending_request_free(request);
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.Failed",
>                                "Failed");
> -
> -       pbap->msg = dbus_message_ref(message);
> +       }
>
>        return NULL;
>  }
> --
> 1.7.6.5
>
> --

Ack

-- 
Luiz Augusto von Dentz
