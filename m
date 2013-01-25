Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359106090-31381-1-git-send-email-chanyeol.park@samsung.com>
References: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
	<1359106090-31381-1-git-send-email-chanyeol.park@samsung.com>
Date: Fri, 25 Jan 2013 11:53:56 +0200
Message-ID: <CABBYNZ+SiOnn34gup1Mvge_znoFHxXPLo-z8tArYFTiVrfcp8w@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix format string warnings for g_dbus_create_error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Fri, Jan 25, 2013 at 11:28 AM, Chan-yeol Park
<chanyeol.park@samsung.com> wrote:
> This patch fixes gcc warnings for "format not a string literal and no
> format arguments".
> ---
>  tools/mpris-player.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/mpris-player.c b/tools/mpris-player.c
> index 95ef8ab..aafa142 100644
> --- a/tools/mpris-player.c
> +++ b/tools/mpris-player.c
> @@ -830,7 +830,7 @@ static void player_reply(DBusMessage *message, void *user_data)
>         dbus_error_init(&err);
>         if (dbus_set_error_from_message(&err, message)) {
>                 fprintf(stderr, "error: %s", err.name);
> -               reply = g_dbus_create_error(msg, err.name, err.message);
> +               reply = g_dbus_create_error(msg, err.name, "%s", err.message);
>                 dbus_error_free(&err);
>         } else
>                 reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> --
> 1.7.10.4

Applied, thanks.


--
Luiz Augusto von Dentz
