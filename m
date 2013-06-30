Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1372414567-994-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1372414567-994-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Sun, 30 Jun 2013 22:16:58 +0300
Message-ID: <CABBYNZK6QrWF0gBEKYVW=4_Ur0guD5U8Aoy_rNz0ZntXmHqpvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd: Re-add D-Bus session properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Fri, Jun 28, 2013 at 1:16 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This got lost when switching to org.freedesktop.DBus.Properties.
> ---
>  obexd/client/session.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 8d32ed0..d971982 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -856,7 +856,8 @@ const char *obc_session_register(struct obc_session *session,
>
>         if (g_dbus_register_interface(session->conn, session->path,
>                                         SESSION_INTERFACE, session_methods,
> -                                       NULL, NULL, session, destroy) == FALSE)
> +                                       NULL, session_properties, session,
> +                                       destroy) == FALSE)
>                 goto fail;
>
>         if (session->driver->probe && session->driver->probe(session) < 0) {
> --
> 1.8.3.1
>
> --

Applied, thanks.


--
Luiz Augusto von Dentz
