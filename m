Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356911904.7243.13.camel@lsdevbox>
References: <50E03F0D.6020605@gmail.com>
	<CABBYNZJTCf9eiVm10SoLRDQ870ayt00Eiz=szXEb1fhktWyHcQ@mail.gmail.com>
	<1356911904.7243.13.camel@lsdevbox>
Date: Mon, 31 Dec 2012 12:13:34 +0200
Message-ID: <CABBYNZJ-=mngCksBaviRc+SPF82gataK_G9nAKSW6Nh8uGGDgQ@mail.gmail.com>
Subject: Re: SEGFAULT in obexd manager.c:find_session
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Zawiejski <dragmz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Mon, Dec 31, 2012 at 1:58 AM, Marcin Zawiejski <dragmz@gmail.com> wrote:
> ---
> diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> index 8f62a30..118dd48 100644
> --- a/obexd/client/manager.c
> +++ b/obexd/client/manager.c
> @@ -59,11 +59,16 @@ static GSList *sessions = NULL;
>
>  static void shutdown_session(struct obc_session *session)
>  {
> -       sessions = g_slist_remove(sessions, session);
>         obc_session_shutdown(session);
>         obc_session_unref(session);
>  }
>
> +static void release_session(struct obc_session *session)
> +{
> +       sessions = g_slist_remove(sessions, session);
> +       shutdown_session(session);
> +}
> +
>  static void unregister_session(void *data)
>  {
>         struct obc_session *session = data;
> @@ -94,6 +99,16 @@ static void create_callback(struct obc_session
> *session,
>
>         path = obc_session_register(session, unregister_session);

Normally we don't have empty lines between assigning and if statements
checking the values, also please follow the code style e.g.
if<space>(<condition>) it is quite similar to the one use in kernel.

> +       if(path == NULL) {
> +               DBusMessage *error = g_dbus_create_error(data->message,
> +                                       ERROR_INTERFACE ".Failed",
> +                                       NULL);
> +               g_dbus_send_message(data->connection, error);
> +               shutdown_session(session);
> +               goto done;
> +       }
> +
> +       sessions = g_slist_append(sessions, session);
>         g_dbus_send_reply(data->connection, data->message,
>                                 DBUS_TYPE_OBJECT_PATH, &path,
>                                 DBUS_TYPE_INVALID);
> @@ -190,7 +205,6 @@ static DBusMessage *create_session(DBusConnection
> *connection,
>                                         dbus_message_get_sender(message),
>                                         create_callback, data);
>         if (session != NULL) {
> -               sessions = g_slist_append(sessions, session);
>                 return NULL;
>         }
>
> @@ -224,7 +238,7 @@ static DBusMessage *remove_session(DBusConnection
> *connection,
>                                 ERROR_INTERFACE ".NotAuthorized",
>                                 "Not Authorized");
>
> -       shutdown_session(session);
> +       release_session(session);
>
>         return dbus_message_new_method_return(message);
>  }
> ---

Besides that the patch looks good, once you fix the code style please
send this a proper patch e.g. git format-patch + git send-email and
please include the backtrace in the patch description.


--
Luiz Augusto von Dentz
