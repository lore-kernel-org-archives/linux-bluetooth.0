Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
References: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
Date: Tue, 28 May 2013 01:37:34 -0700
Message-ID: <CABBYNZLc8=a6xZPzE+Xz9RUvFHpUpG5ouxSHeXvP3ZEoL7X5EA@mail.gmail.com>
Subject: Re: [PATCH 1/4] session: only add Target if it exists
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, May 27, 2013 at 4:07 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> ---
>  obexd/src/manager.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index b67567b..b86565c 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -265,6 +265,14 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static gboolean session_target_exists(const GDBusPropertyTable *property,
> +                                                               void *data)
> +{
> +       struct obex_session *os = data;
> +
> +       return os->service->target ? TRUE : FALSE;
> +}
> +
>  static char *target2str(const uint8_t *t)
>  {
>         if (!t)
> @@ -521,7 +529,7 @@ static const GDBusPropertyTable transfer_properties[] = {
>  };
>
>  static const GDBusPropertyTable session_properties[] = {
> -       { "Target", "s", get_target },
> +       { "Target", "s", get_target, NULL, session_target_exists },
>         { "Root", "s", get_root },
>         { }
>  };
> --
> 1.8.1.4

Patches 1/4 and 4/4 are now upstream, thanks.


--
Luiz Augusto von Dentz
