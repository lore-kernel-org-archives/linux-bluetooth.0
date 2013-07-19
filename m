Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1374115110-11780-1-git-send-email-martin.xu@linux.intel.com>
References: <1374115110-11780-1-git-send-email-martin.xu@linux.intel.com>
Date: Fri, 19 Jul 2013 11:03:19 +0300
Message-ID: <CABBYNZLKOA6uY+J54TBP4+HtUxXvxwSy3Lb6zk5xR19iT8b9eQ@mail.gmail.com>
Subject: Re: [PATCH] obex/session: Export the right target uuid
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: martin.xu@linux.intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Thu, Jul 18, 2013 at 5:38 AM,  <martin.xu@linux.intel.com> wrote:
> From: Martin Xu <martin.xu@linux.intel.com>
>
> ---
>  obexd/client/session.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 361c921..f451093 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -675,13 +675,27 @@ static const GDBusMethodTable session_methods[] = {
>         { }
>  };
>
> +static char *target2str(const uint8_t *t)
> +{
> +       if (t == NULL)
> +               return NULL;
> +
> +       return g_strdup_printf("%02X%02X%02X%02X-%02X%02X-%02X%02X-"
> +                               "%02X%02X-%02X%02X%02X%02X%02X%02X",
> +                               t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7],
> +                               t[8], t[9], t[10], t[11], t[12], t[13], t[14],
> +                               t[15]);
> +}
> +
>  static gboolean get_target(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
>         struct obc_session *session = data;
> +       char *uuid;
>
> -       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> -                                               &session->driver->uuid);
> +       uuid = target2str(session->driver->target);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> +       g_free(uuid);

Did you ever test this? I suspect this will crash with OPP because
there driver->target is NULL so target2str will return NULL as well so
you would be passing NULL to dbus_message_iter_append_basic which I
believe will cause a crash, so instead of fixing anything here this
would be introducing a bug.

>         return TRUE;
>  }
> @@ -690,7 +704,7 @@ static gboolean target_exists(const GDBusPropertyTable *property, void *data)
>  {
>         struct obc_session *session = data;
>
> -       return session->driver->uuid != NULL;
> +       return session->driver->target != NULL;
>  }

I don't understand why you want to use the OBEX target here? There is
no other reference to it instead we should be using what Device1.UUIDs
provides that is Bluetooth 128 bits UUIDs in string format so the
applications can use them directly. So I will repeat again, what needs
to be done is reword the documentation to reflect what is implemented.

And let me repeat one last time, with ObjectManager you got signaled
what interfaces are supported, that is much more important than the
UUID, in fact perhaps it was a mistake to introduce such a thing since
the interfaces can be used directly but this can be handy for
non-standard profiles.

--
Luiz Augusto von Dentz
