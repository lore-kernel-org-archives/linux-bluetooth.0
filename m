Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1373017106-4571-1-git-send-email-martin.xu@linux.intel.com>
References: <1373017106-4571-1-git-send-email-martin.xu@linux.intel.com>
Date: Fri, 5 Jul 2013 13:04:19 +0300
Message-ID: <CABBYNZKF67RPpERkQ7RfmQx+Jc_tPz=-Wv3pGrAw=nJqc2=brg@mail.gmail.com>
Subject: Re: [PATCH] obexd/client: Add client session properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: martin.xu@linux.intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Fri, Jul 5, 2013 at 12:38 PM,  <martin.xu@linux.intel.com> wrote:
> From: Martin <martin.xu@linux.intel.com>

Please add a description why are the changes necessary.

> ---
>  obexd/client/session.c |   38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 8d32ed0..e9cbf00 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -630,9 +630,6 @@ static gboolean get_source(const GDBusPropertyTable *property,
>  {
>         struct obc_session *session = data;
>
> -       if (session->source == NULL)
> -               return FALSE;

I guess you haven't read carefully may comments from the last time,
did you? This should not be necessary here, otherwise create another
patch.

>         dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
>                                                         &session->source);
>
> @@ -675,10 +672,35 @@ static const GDBusMethodTable session_methods[] = {
>         { }
>  };
>
> +static gboolean get_target(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct obc_session *session = data;
> +       char *uuid;
> +
> +       uuid = g_strdup(session->driver->uuid);

You don't really need a copy here, just use session->driver->uuid directly.

> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> +       g_free(uuid);
> +
> +       return TRUE;
> +}
> +
> +static gboolean session_target_exists(const GDBusPropertyTable *property,
> +                                                               void *data)
> +{
> +       struct obc_session *session = data;
> +       if (session->driver)
> +               return session->driver->uuid ? TRUE : FALSE;
> +
> +       return FALSE;
> +}
> +
>  static const GDBusPropertyTable session_properties[] = {
>         { "Source", "s", get_source, NULL, source_exists },
>         { "Destination", "s", get_destination },
>         { "Channel", "y", get_channel },
> +       { "Target", "s", get_target, NULL, session_target_exists },
>         { }
>  };
>
> @@ -854,9 +876,13 @@ const char *obc_session_register(struct obc_session *session,
>         session->path = g_strdup_printf("%s/session%ju",
>                                                 SESSION_BASEPATH, counter++);
>
> -       if (g_dbus_register_interface(session->conn, session->path,
> -                                       SESSION_INTERFACE, session_methods,
> -                                       NULL, NULL, session, destroy) == FALSE)
> +       if (g_dbus_register_interface(session->conn,
> +                                       session->path,
> +                                       SESSION_INTERFACE,
> +                                       session_methods,
> +                                       NULL,
> +                                       session_properties,
> +                                       session, destroy) == FALSE)
>                 goto fail;

Im not sure why you are reformatting the lines above, they were fine
according to codestyle and even if they were not you should not mix
changes that are not related to the patch.



--
Luiz Augusto von Dentz
