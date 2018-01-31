Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180128135030.18468-1-luiz.dentz@gmail.com>
References: <20180128135030.18468-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 31 Jan 2018 09:33:18 -0200
Message-ID: <CABBYNZJCb6K4d13j+_5geWEy6iUPYVbuwEdeP1X5m=cxLCib7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gdbus: Fix replying to messages marked with
 NOREPLY flag
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jan 28, 2018 at 11:50 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When a sender flags a D-Bus message as not expecting a reply, it is
> against D-Bus policy to send a reply =E2=80=94 sending one can result in =
an
> error as reported in:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D198453
> ---
>  gdbus/object.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 5c8ad7a55..e572c9f01 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1421,6 +1421,10 @@ DBusMessage *g_dbus_create_error_valist(DBusMessag=
e *message, const char *name,
>  {
>         char str[1024];
>
> +       /* Check if the message can be replied */
> +       if (dbus_message_get_no_reply(message))
> +               return NULL;
> +
>         if (format)
>                 vsnprintf(str, sizeof(str), format, args);
>         else
> @@ -1449,6 +1453,10 @@ DBusMessage *g_dbus_create_reply_valist(DBusMessag=
e *message,
>  {
>         DBusMessage *reply;
>
> +       /* Check if the message can be replied */
> +       if (dbus_message_get_no_reply(message))
> +               return NULL;
> +
>         reply =3D dbus_message_new_method_return(message);
>         if (reply =3D=3D NULL)
>                 return NULL;
> @@ -1571,14 +1579,9 @@ gboolean g_dbus_send_reply_valist(DBusConnection *=
connection,
>  {
>         DBusMessage *reply;
>
> -       reply =3D dbus_message_new_method_return(message);
> -       if (reply =3D=3D NULL)
> -               return FALSE;
> -
> -       if (dbus_message_append_args_valist(reply, type, args) =3D=3D FAL=
SE) {
> -               dbus_message_unref(reply);
> +       reply =3D g_dbus_create_reply_valist(message, type, args);
> +       if (!reply)
>                 return FALSE;
> -       }
>
>         return g_dbus_send_message(connection, reply);
>  }
> --
> 2.14.3


Pushed.



--=20
Luiz Augusto von Dentz
