Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354195173-12750-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1354195173-12750-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 29 Nov 2012 15:39:57 +0200
Message-ID: <CABBYNZLC4ejuAmM09s88ngJU3v4Ypmj_utkzUR__NXQpgYptxw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] core: Attach and detach object manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Nov 29, 2012 at 3:19 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> From: Lucas De Marchi <lucas.de.marchi@gmail.com>
>
> ---
>  src/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/main.c b/src/main.c
> index 414849a..ccb5fa5 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -381,6 +381,7 @@ static void disconnect_dbus(void)
>         if (!conn || !dbus_connection_get_is_connected(conn))
>                 return;
>
> +       g_dbus_detach_object_manager(conn);
>         set_dbus_connection(NULL);
>
>         dbus_connection_unref(conn);
> @@ -412,6 +413,7 @@ static int connect_dbus(void)
>         set_dbus_connection(conn);
>
>         g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
> +       g_dbus_attach_object_manager(conn);
>
>         return 0;
>  }
> --
> 1.8.0.1

Ack.


--
Luiz Augusto von Dentz
